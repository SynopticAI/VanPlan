// lib/features/system_planning/widgets/object_type_node.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../models/object_type.dart';
import '../providers/system_planning_providers.dart';

class ObjectTypeNode extends ConsumerWidget {
  final ObjectType objectType;
  final VoidCallback? onAddObject;

  const ObjectTypeNode({
    super.key,
    required this.objectType,
    this.onAddObject,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedNodes = ref.watch(expandedNodesProvider);
    final assignedObjects = ref.watch(assignedObjectsProvider);
    final isExpanded = expandedNodes.contains(objectType.id);
    final objects = assignedObjects[objectType.id] ?? [];

    return GestureDetector(
      onTap: () {
        ref.read(systemPlanningNotifierProvider.notifier)
            .toggleNodeExpansion(objectType.id);
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 150,
          maxWidth: 250,
          minHeight: 60,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: objectType.color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header section
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: objectType.color.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    objectType.icon,
                    color: objectType.color,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(
                      objectType.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: objectType.color,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (objects.isNotEmpty) ...[
                    const SizedBox(width: AppSpacing.xs),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: objectType.color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${objects.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Content section
            if (objects.isNotEmpty || isExpanded) ...[
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Assigned objects list
                    if (objects.isNotEmpty) ...[
                      ...objects.map((object) => _buildObjectItem(
                        context,
                        ref,
                        object,
                        isExpanded,
                      )),
                    ],
                    
                    // Add button (only when expanded or no objects)
                    if (isExpanded || objects.isEmpty) ...[
                      if (objects.isNotEmpty) const SizedBox(height: AppSpacing.xs),
                      _buildAddButton(context, objects.length),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildObjectItem(
    BuildContext context,
    WidgetRef ref,
    ObjectInstance object,
    bool isExpanded,
  ) {
    if (!isExpanded) {
      // Collapsed view - just show name
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: 2,
        ),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          object.name,
          style: Theme.of(context).textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      // Expanded view - show name, status toggle, and remove button
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xs),
        margin: const EdgeInsets.only(bottom: AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: object.status == ObjectStatus.installed
                ? AppColors.success
                : AppColors.warning,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Object name and remove button
            Row(
              children: [
                Expanded(
                  child: Text(
                    object.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(systemPlanningNotifierProvider.notifier)
                        .removeObject(objectType.id, object.id);
                  },
                  icon: const Icon(Icons.close),
                  iconSize: 16,
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            
            // Status toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status:',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final newStatus = object.status == ObjectStatus.planned
                        ? ObjectStatus.installed
                        : ObjectStatus.planned;
                    ref.read(systemPlanningNotifierProvider.notifier)
                        .updateObjectStatus(objectType.id, object.id, newStatus);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: object.status == ObjectStatus.installed
                          ? AppColors.success
                          : AppColors.warning,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      object.status == ObjectStatus.installed ? 'Installed' : 'Planned',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Show some specs if available
            if (object.cost != null || object.weight != null) ...[
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (object.cost != null)
                    Text(
                      '\$${object.cost!.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (object.weight != null)
                    Text(
                      '${object.weight!.toStringAsFixed(1)} lbs',
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.mediumGray,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      );
    }
  }

  Widget _buildAddButton(BuildContext context, int currentCount) {
    final canAddMore = objectType.maxObjects == -1 || currentCount < objectType.maxObjects;
    
    if (!canAddMore) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          'Max ${objectType.maxObjects} allowed',
          style: TextStyle(
            fontSize: 10,
            color: AppColors.mediumGray,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onAddObject,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: objectType.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: objectType.color.withOpacity(0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: objectType.color,
              size: 16,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Add ${objectType.name}',
              style: TextStyle(
                color: objectType.color,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}