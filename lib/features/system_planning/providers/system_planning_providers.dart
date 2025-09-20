// lib/features/system_planning/providers/system_planning_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/object_type.dart';
import '../data/system_topology_data.dart';

// State class for managing assigned objects
class SystemPlanningState {
  final Map<String, List<ObjectInstance>> assignedObjects;
  final Set<String> expandedNodes;
  final Map<String, TypeConnection> connectionStates;

  const SystemPlanningState({
    required this.assignedObjects,
    required this.expandedNodes,
    required this.connectionStates,
  });

  SystemPlanningState copyWith({
    Map<String, List<ObjectInstance>>? assignedObjects,
    Set<String>? expandedNodes,
    Map<String, TypeConnection>? connectionStates,
  }) {
    return SystemPlanningState(
      assignedObjects: assignedObjects ?? this.assignedObjects,
      expandedNodes: expandedNodes ?? this.expandedNodes,
      connectionStates: connectionStates ?? this.connectionStates,
    );
  }
}

// Modern Riverpod 3.0 Notifier class
class SystemPlanningNotifier extends Notifier<SystemPlanningState> {
  @override
  SystemPlanningState build() {
    // Initialize with empty assigned objects and all connections
    final connectionStates = <String, TypeConnection>{};
    for (final connection in SystemTopologyData.allConnections) {
      final key = '${connection.fromObjectTypeId}_${connection.toObjectTypeId}';
      connectionStates[key] = connection;
    }

    return SystemPlanningState(
      assignedObjects: {},
      expandedNodes: {},
      connectionStates: connectionStates,
    );
  }

  // Toggle node expansion
  void toggleNodeExpansion(String objectTypeId) {
    final newExpandedNodes = Set<String>.from(state.expandedNodes);
    
    if (newExpandedNodes.contains(objectTypeId)) {
      newExpandedNodes.remove(objectTypeId);
    } else {
      newExpandedNodes.add(objectTypeId);
    }

    state = state.copyWith(expandedNodes: newExpandedNodes);
  }

  // Add object to object type
  void addObject(String objectTypeId, ObjectInstance object) {
    final objectType = SystemTopologyData.objectTypes[objectTypeId];
    
    if (objectType == null) return;

    final currentObjects = List<ObjectInstance>.from(
      state.assignedObjects[objectTypeId] ?? []
    );

    // Check if we can add more objects
    if (objectType.maxObjects != -1 && currentObjects.length >= objectType.maxObjects) {
      return; // Cannot add more objects
    }

    currentObjects.add(object);
    
    final newAssignedObjects = Map<String, List<ObjectInstance>>.from(
      state.assignedObjects
    );
    newAssignedObjects[objectTypeId] = currentObjects;

    state = state.copyWith(assignedObjects: newAssignedObjects);
    
    // Update connection states based on new object
    _updateConnectionStates();
  }

  // Remove object from object type
  void removeObject(String objectTypeId, String objectId) {
    final currentObjects = List<ObjectInstance>.from(
      state.assignedObjects[objectTypeId] ?? []
    );

    currentObjects.removeWhere((obj) => obj.id == objectId);
    
    final newAssignedObjects = Map<String, List<ObjectInstance>>.from(
      state.assignedObjects
    );
    
    if (currentObjects.isEmpty) {
      newAssignedObjects.remove(objectTypeId);
    } else {
      newAssignedObjects[objectTypeId] = currentObjects;
    }

    state = state.copyWith(assignedObjects: newAssignedObjects);
    
    // Update connection states
    _updateConnectionStates();
  }

  // Update object status (planned/installed)
  void updateObjectStatus(String objectTypeId, String objectId, ObjectStatus newStatus) {
    final currentObjects = List<ObjectInstance>.from(
      state.assignedObjects[objectTypeId] ?? []
    );

    final objectIndex = currentObjects.indexWhere((obj) => obj.id == objectId);
    if (objectIndex == -1) return;

    currentObjects[objectIndex] = currentObjects[objectIndex].copyWith(status: newStatus);
    
    final newAssignedObjects = Map<String, List<ObjectInstance>>.from(
      state.assignedObjects
    );
    newAssignedObjects[objectTypeId] = currentObjects;

    state = state.copyWith(assignedObjects: newAssignedObjects);
  }

  // Private method to update connection states based on assigned objects
  void _updateConnectionStates() {
    // TODO: Implement sophisticated compatibility checking
    // For now, all connections remain active
    // Later we'll add logic to deactivate connections based on 
    // incompatible voltage, missing components, etc.
  }

  // Get total cost for object type
  double getTotalCostForType(String objectTypeId) {
    final objects = state.assignedObjects[objectTypeId] ?? [];
    return objects
        .where((obj) => obj.cost != null)
        .fold(0.0, (sum, obj) => sum + obj.cost!);
  }

  // Get total weight for object type
  double getTotalWeightForType(String objectTypeId) {
    final objects = state.assignedObjects[objectTypeId] ?? [];
    return objects
        .where((obj) => obj.weight != null)
        .fold(0.0, (sum, obj) => sum + obj.weight!);
  }

  // Get total power consumption for object type
  double getTotalPowerConsumptionForType(String objectTypeId) {
    final objects = state.assignedObjects[objectTypeId] ?? [];
    return objects
        .where((obj) => obj.powerConsumption != null)
        .fold(0.0, (sum, obj) => sum + obj.powerConsumption!);
  }

  // Get total power generation for object type
  double getTotalPowerGenerationForType(String objectTypeId) {
    final objects = state.assignedObjects[objectTypeId] ?? [];
    return objects
        .where((obj) => obj.powerGeneration != null)
        .fold(0.0, (sum, obj) => sum + obj.powerGeneration!);
  }
}

// Modern Riverpod 3.0 NotifierProvider
final systemPlanningNotifierProvider = NotifierProvider<SystemPlanningNotifier, SystemPlanningState>(
  () => SystemPlanningNotifier(),
);

// Providers for accessing specific parts of the state
final allObjectTypesProvider = Provider<List<ObjectType>>((ref) {
  return SystemTopologyData.objectTypes.values.toList();
});

final allConnectionsProvider = Provider<List<TypeConnection>>((ref) {
  final state = ref.watch(systemPlanningNotifierProvider);
  return state.connectionStates.values.toList();
});

final assignedObjectsProvider = Provider<Map<String, List<ObjectInstance>>>((ref) {
  final state = ref.watch(systemPlanningNotifierProvider);
  return state.assignedObjects;
});

final expandedNodesProvider = Provider<Set<String>>((ref) {
  final state = ref.watch(systemPlanningNotifierProvider);
  return state.expandedNodes;
});

final totalSystemCostProvider = Provider<double>((ref) {
  final assignedObjects = ref.watch(assignedObjectsProvider);
  double total = 0.0;
  
  for (final objects in assignedObjects.values) {
    for (final object in objects) {
      if (object.cost != null) {
        total += object.cost!;
      }
    }
  }
  
  return total;
});

final totalSystemWeightProvider = Provider<double>((ref) {
  final assignedObjects = ref.watch(assignedObjectsProvider);
  double total = 0.0;
  
  for (final objects in assignedObjects.values) {
    for (final object in objects) {
      if (object.weight != null) {
        total += object.weight!;
      }
    }
  }
  
  return total;
});

final totalSystemPowerConsumptionProvider = Provider<double>((ref) {
  final assignedObjects = ref.watch(assignedObjectsProvider);
  double total = 0.0;
  
  for (final objects in assignedObjects.values) {
    for (final object in objects) {
      if (object.powerConsumption != null) {
        total += object.powerConsumption!;
      }
    }
  }
  
  return total;
});

final totalSystemPowerGenerationProvider = Provider<double>((ref) {
  final assignedObjects = ref.watch(assignedObjectsProvider);
  double total = 0.0;
  
  for (final objects in assignedObjects.values) {
    for (final object in objects) {
      if (object.powerGeneration != null) {
        total += object.powerGeneration!;
      }
    }
  }
  
  return total;
});