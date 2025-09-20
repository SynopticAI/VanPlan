// lib/features/system_planning/presentation/system_planning_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/system_topology_graph.dart';

class SystemPlanningScreen extends ConsumerWidget {
  const SystemPlanningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          // Top control bar
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                // View toggle buttons
                Expanded(
                  child: Row(
                    children: [
                      _buildViewToggleButton(
                        context,
                        'Graph View',
                        Icons.account_tree,
                        isSelected: true,
                        onTap: () {
                          // Already in graph view
                        },
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _buildViewToggleButton(
                        context,
                        'List View',
                        Icons.list,
                        isSelected: false,
                        onTap: () {
                          // TODO: Implement list view toggle
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('List view coming soon!'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                
                // Action buttons
                IconButton(
                  onPressed: () {
                    _showHelpDialog(context);
                  },
                  icon: const Icon(Icons.help_outline),
                  tooltip: 'Help',
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Implement reset functionality
                    _showResetDialog(context, ref);
                  },
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Reset System',
                ),
              ],
            ),
          ),
          
          // Graph view
          Expanded(
            child: const SystemTopologyGraph(),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggleButton(
    BuildContext context,
    String label,
    IconData icon, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryOrange : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : AppColors.mediumGray,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : AppColors.mediumGray,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.mediumGray,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Graph View Help'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How to use the System Topology Graph:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: AppSpacing.sm),
              Text('• Tap any node to expand/collapse it'),
              Text('• Expanded nodes show detailed component information'),
              Text('• Click the + button to add new components'),
              Text('• Toggle component status between Planned/Installed'),
              Text('• Connections show system flow (energy, water, gas)'),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Connection Colors:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('• Yellow: Energy connections'),
              Text('• Blue: Water connections'),
              Text('• White: Gas connections'),
              Text('• Gray: Inactive connections'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset System'),
        content: const Text(
          'This will remove all selected components and reset the system to empty. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement reset functionality
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reset functionality coming soon!'),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}