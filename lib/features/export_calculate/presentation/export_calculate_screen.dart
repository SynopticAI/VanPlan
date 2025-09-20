import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ExportCalculateScreen extends StatelessWidget {
  const ExportCalculateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export & Calculate'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Cost',
                    '\$0',
                    Icons.attach_money,
                    AppColors.success,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _buildStatCard(
                    'Total Weight',
                    '0 lbs',
                    Icons.fitness_center,
                    AppColors.warning,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppSpacing.sm),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Power Gen',
                    '0W',
                    Icons.bolt,
                    AppColors.teal,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _buildStatCard(
                    'Power Use',
                    '0W',
                    Icons.power_settings_new,
                    AppColors.error,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppSpacing.lg),
            
            // Export Options
            Text(
              'Export Options',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            // Shopping List
            Card(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: AppColors.primaryOrange,
                  ),
                ),
                title: const Text('Shopping List'),
                subtitle: const Text('Export component list with prices'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showShoppingList(context);
                },
              ),
            ),
            
            const SizedBox(height: AppSpacing.sm),
            
            // Installation Guide
            Card(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.build,
                    color: AppColors.teal,
                  ),
                ),
                title: const Text('Installation Guide'),
                subtitle: const Text('Step-by-step installation instructions'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showInstallationGuide(context);
                },
              ),
            ),
            
            const SizedBox(height: AppSpacing.sm),
            
            // System Report
            Card(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.deepBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.assessment,
                    color: AppColors.deepBlue,
                  ),
                ),
                title: const Text('System Report'),
                subtitle: const Text('Complete analysis and recommendations'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showSystemReport(context);
                },
              ),
            ),
            
            const SizedBox(height: AppSpacing.lg),
            
            // Compatibility Check
            Card(
              color: AppColors.lightGray,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Compatibility Check',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      'No compatibility issues found.',
                      style: TextStyle(color: AppColors.success),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    const Text(
                      'Your selected components are compatible with each other.',
                      style: TextStyle(color: AppColors.mediumGray),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: AppSpacing.sm),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.mediumGray,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShoppingList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Shopping List',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text('No components selected yet.'),
            const Text('Add components in System Planning to see them here.'),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  void _showInstallationGuide(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Installation Guide',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text('Installation guides will be generated based on your selected components.'),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSystemReport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'System Report',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text('Detailed system analysis will be available once components are selected.'),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}