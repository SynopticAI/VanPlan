// lib/features/system_planning/widgets/object_selection_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../models/object_type.dart';
import '../data/mock_objects_data.dart';

class ObjectSelectionDialog extends ConsumerStatefulWidget {
  final ObjectType objectType;
  final Function(ObjectInstance) onObjectSelected;

  const ObjectSelectionDialog({
    super.key,
    required this.objectType,
    required this.onObjectSelected,
  });

  @override
  ConsumerState<ObjectSelectionDialog> createState() => _ObjectSelectionDialogState();
}

class _ObjectSelectionDialogState extends ConsumerState<ObjectSelectionDialog> {
  String searchQuery = '';
  String sortBy = 'name'; // name, cost, power

  @override
  Widget build(BuildContext context) {
    final availableObjects = MockObjectsData.getObjectsForType(widget.objectType.id);
    final filteredObjects = _filterAndSortObjects(availableObjects);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  widget.objectType.icon,
                  color: widget.objectType.color,
                  size: 24,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Select ${widget.objectType.name}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: widget.objectType.color,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            // Search and filter controls
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search objects...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      isDense: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                DropdownButton<String>(
                  value: sortBy,
                  items: const [
                    DropdownMenuItem(value: 'name', child: Text('Name')),
                    DropdownMenuItem(value: 'cost', child: Text('Cost')),
                    DropdownMenuItem(value: 'power', child: Text('Power')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        sortBy = value;
                      });
                    }
                  },
                ),
              ],
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            // Objects list
            Expanded(
              child: filteredObjects.isEmpty
                  ? const Center(
                      child: Text('No objects available for this category'),
                    )
                  : ListView.builder(
                      itemCount: filteredObjects.length,
                      itemBuilder: (context, index) {
                        final object = filteredObjects[index];
                        return _buildObjectCard(object);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<ObjectInstance> _filterAndSortObjects(List<ObjectInstance> objects) {
    // Filter by search query
    var filtered = objects;
    if (searchQuery.isNotEmpty) {
      filtered = objects
          .where((obj) => obj.name.toLowerCase().contains(searchQuery))
          .toList();
    }

    // Sort by selected criteria
    switch (sortBy) {
      case 'cost':
        filtered.sort((a, b) {
          final aCost = a.cost ?? 0;
          final bCost = b.cost ?? 0;
          return aCost.compareTo(bCost);
        });
        break;
      case 'power':
        filtered.sort((a, b) {
          final aPower = (a.powerConsumption ?? 0) + (a.powerGeneration ?? 0);
          final bPower = (b.powerConsumption ?? 0) + (b.powerGeneration ?? 0);
          return bPower.compareTo(aPower); // Higher power first
        });
        break;
      default: // name
        filtered.sort((a, b) => a.name.compareTo(b.name));
    }

    return filtered;
  }

  Widget _buildObjectCard(ObjectInstance object) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        onTap: () {
          widget.onObjectSelected(object);
          Navigator.of(context).pop();
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Object name and main specs
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: widget.objectType.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      widget.objectType.icon,
                      color: widget.objectType.color,
                      size: 30,
                    ),
                  ),
                  
                  const SizedBox(width: AppSpacing.md),
                  
                  // Object details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          object.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                        const SizedBox(height: AppSpacing.xs),
                        
                        // Key specifications
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.xs,
                          children: [
                            if (object.cost != null)
                              _buildSpecChip(
                                '\$${object.cost!.toStringAsFixed(0)}',
                                AppColors.success,
                              ),
                            if (object.weight != null)
                              _buildSpecChip(
                                '${object.weight!.toStringAsFixed(1)} lbs',
                                AppColors.mediumGray,
                              ),
                            if (object.powerConsumption != null)
                              _buildSpecChip(
                                '${object.powerConsumption!.toStringAsFixed(0)}W',
                                AppColors.error,
                              ),
                            if (object.powerGeneration != null)
                              _buildSpecChip(
                                '+${object.powerGeneration!.toStringAsFixed(0)}W',
                                AppColors.teal,
                              ),
                          ],
                        ),
                        
                        // Additional specifications
                        if (object.specifications.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            _formatSpecifications(object.specifications),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.mediumGray,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Add button
                  Icon(
                    Icons.add_circle,
                    color: widget.objectType.color,
                    size: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _formatSpecifications(Map<String, dynamic> specs) {
    final keySpecs = <String>[];
    
    if (specs.containsKey('voltage')) {
      keySpecs.add('${specs['voltage']}V');
    }
    if (specs.containsKey('capacity')) {
      keySpecs.add('${specs['capacity']}Ah');
    }
    if (specs.containsKey('efficiency')) {
      keySpecs.add('${specs['efficiency']}% efficiency');
    }
    if (specs.containsKey('size')) {
      keySpecs.add('${specs['size']}');
    }
    
    return keySpecs.join(' • ');
  }
}