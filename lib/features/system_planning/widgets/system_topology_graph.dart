// lib/features/system_planning/widgets/system_topology_graph.dart

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';
import '../../../core/theme/app_theme.dart';
import '../models/object_type.dart';
import '../data/system_topology_data.dart';
import '../providers/system_planning_providers.dart';
import 'object_type_node.dart';
import 'object_selection_dialog.dart';

class SystemTopologyGraph extends ConsumerStatefulWidget {
  const SystemTopologyGraph({super.key});

  @override
  ConsumerState<SystemTopologyGraph> createState() => _SystemTopologyGraphState();
}

class _SystemTopologyGraphState extends ConsumerState<SystemTopologyGraph> {
  final Graph graph = Graph()..isTree = false;
  late SugiyamaAlgorithm algorithm;

  @override
  void initState() {
    super.initState();
    _initializeGraph();
  }

  void _initializeGraph() {
    // Create nodes for each object type
    final objectTypes = SystemTopologyData.objectTypes;
    final nodes = <String, Node>{};
    
    for (final objectType in objectTypes.values) {
      final node = Node.Id(objectType.id);
      nodes[objectType.id] = node;
      graph.addNode(node);
    }

    // Create edges for connections
    final connections = SystemTopologyData.allConnections;
    for (final connection in connections) {
      final fromNode = nodes[connection.fromObjectTypeId];
      final toNode = nodes[connection.toObjectTypeId];
      
      if (fromNode != null && toNode != null) {
        graph.addEdge(fromNode, toNode);
      }
    }

    // Configure layout algorithm with tighter constraints
    final builder = SugiyamaConfiguration()
      ..bendPointShape = CurvedBendPointShape(curveLength: 15)
      ..orientation = SugiyamaConfiguration.ORIENTATION_LEFT_RIGHT;
    algorithm = SugiyamaAlgorithm(builder);
  }

  @override
  Widget build(BuildContext context) {
    final connections = ref.watch(allConnectionsProvider);
    final assignedObjects = ref.watch(assignedObjectsProvider);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade50,
      child: Stack(
        children: [
          // Graph canvas with proper constraints
          Positioned.fill(
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(50),
              minScale: 0.3,
              maxScale: 2.0,
              constrained: false,
              child: SizedBox(
                width: 1200,
                height: 800,
                child: GraphView(
                  graph: graph,
                  algorithm: algorithm,
                  paint: Paint()
                    ..color = Colors.grey.shade400
                    ..strokeWidth = 1
                    ..style = PaintingStyle.stroke,
                  builder: (Node node) {
                    final objectType = SystemTopologyData.objectTypes[node.key?.value];
                    if (objectType != null) {
                      return ObjectTypeNode(
                        objectType: objectType,
                        onAddObject: () => _showObjectSelectionDialog(objectType),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
          
          // Legend
          Positioned(
            top: 16,
            right: 16,
            child: _buildLegend(),
          ),
          
          // Stats overlay
          Positioned(
            top: 16,
            left: 16,
            child: _buildStatsOverlay(),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connection Types',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _buildLegendItem('Energy', ConnectionType.energy.color),
            _buildLegendItem('Water', ConnectionType.water.color),
            _buildLegendItem('Gas', ConnectionType.gas.color),
            _buildLegendItem('Inactive', ConnectionType.inactive.color),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 3,
            color: color,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverlay() {
    final totalCost = ref.watch(totalSystemCostProvider);
    final totalWeight = ref.watch(totalSystemWeightProvider);
    final totalPowerConsumption = ref.watch(totalSystemPowerConsumptionProvider);
    final totalPowerGeneration = ref.watch(totalSystemPowerGenerationProvider);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Overview',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _buildStatItem('Total Cost', '\${totalCost.toStringAsFixed(0)}'),
            _buildStatItem('Total Weight', '${totalWeight.toStringAsFixed(1)} lbs'),
            _buildStatItem('Power Generation', '${totalPowerGeneration.toStringAsFixed(0)}W'),
            _buildStatItem('Power Consumption', '${totalPowerConsumption.toStringAsFixed(0)}W'),
            if (totalPowerGeneration > 0 && totalPowerConsumption > 0)
              _buildStatItem(
                'Power Balance',
                '${(totalPowerGeneration - totalPowerConsumption).toStringAsFixed(0)}W',
                color: totalPowerGeneration >= totalPowerConsumption
                    ? AppColors.success
                    : AppColors.error,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 10),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color ?? AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }

  void _showObjectSelectionDialog(ObjectType objectType) {
    showDialog(
      context: context,
      builder: (context) => ObjectSelectionDialog(
        objectType: objectType,
        onObjectSelected: (selectedObject) {
          ref.read(systemPlanningNotifierProvider.notifier)
              .addObject(objectType.id, selectedObject);
        },
      ),
    );
  }
}