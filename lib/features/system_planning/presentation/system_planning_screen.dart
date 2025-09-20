import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SystemPlanningScreen extends StatelessWidget {
  const SystemPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Planning'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search components...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            
            const SizedBox(height: AppSpacing.lg),
            
            // System Tree Structure (Placeholder)
            Text(
              'Van System Components',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            // Energy Storage Section
            _buildSystemCategory(
              context,
              'Energy Storage',
              Icons.battery_charging_full,
              [
                'Battery Bank 1',
                'Battery Bank 2',
              ],
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            // Energy Sources Section
            _buildSystemCategory(
              context,
              'Energy Sources',
              Icons.solar_power,
              [
                'Solar Panels',
                'Alternator Charger',
                'Shore Power',
              ],
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            // Energy Conversion Section
            _buildSystemCategory(
              context,
              'Energy Conversion',
              Icons.transform,
              [
                'Inverter',
                'DC-DC Converter',
              ],
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            // Heating Section
            _buildSystemCategory(
              context,
              'Heating',
              Icons.local_fire_department,
              [
                'Diesel Heater',
              ],
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            // Dashboard Preview
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: AppColors.secondaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System Dashboard',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildDashboardRow('Total Cost', '\$0', Colors.white),
                  _buildDashboardRow('Total Weight', '0 lbs', Colors.white),
                  _buildDashboardRow('Power Generation', '0W', Colors.white),
                  _buildDashboardRow('Power Consumption', '0W', Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemCategory(
    BuildContext context,
    String title,
    IconData icon,
    List<String> components,
  ) {
    return Card(
      child: ExpansionTile(
        leading: Icon(icon, color: AppColors.primaryOrange),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: components.map((component) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: AppSpacing.xl),
            title: Text(component),
            trailing: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                // TODO: Implement component selection
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Add $component - Coming Soon!')),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDashboardRow(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: textColor)),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}