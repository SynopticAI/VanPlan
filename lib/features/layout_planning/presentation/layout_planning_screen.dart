import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class LayoutPlanningScreen extends StatelessWidget {
  const LayoutPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Planning'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement van dimensions settings
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Van Model Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    const Icon(Icons.directions_car, color: AppColors.primaryOrange),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Van Model: ',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: 'Custom',
                        items: const [
                          DropdownMenuItem(value: 'Custom', child: Text('Custom Dimensions')),
                          DropdownMenuItem(value: 'Transit', child: Text('Ford Transit')),
                          DropdownMenuItem(value: 'Sprinter', child: Text('Mercedes Sprinter')),
                          DropdownMenuItem(value: 'ProMaster', child: Text('Ram ProMaster')),
                        ],
                        onChanged: (value) {
                          // TODO: Implement van model selection
                        },
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppSpacing.lg),
            
            // Canvas Area
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Van Layout Canvas',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      
                      // Canvas placeholder
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.mediumGray),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              // Van outline (placeholder)
                              Center(
                                child: Container(
                                  width: 200,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryOrange,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Van Interior\n(Drag components here)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.mediumGray,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Placeholder components
                              Positioned(
                                top: 20,
                                left: 20,
                                child: _buildDraggableComponent('Battery', Icons.battery_full),
                              ),
                              Positioned(
                                top: 20,
                                right: 20,
                                child: _buildDraggableComponent('Inverter', Icons.power),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            // Weight Distribution
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weight Distribution',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    
                    // Placeholder weight bars
                    Row(
                      children: [
                        Text('Front', style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.3,
                            backgroundColor: AppColors.lightGray,
                            valueColor: const AlwaysStoppedAnimation(AppColors.success),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        const Text('30%'),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Text('Rear ', style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.7,
                            backgroundColor: AppColors.lightGray,
                            valueColor: const AlwaysStoppedAnimation(AppColors.warning),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        const Text('70%'),
                      ],
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

  Widget _buildDraggableComponent(String name, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.primaryOrange.withOpacity(0.1),
        border: Border.all(color: AppColors.primaryOrange),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryOrange, size: 20),
          const SizedBox(height: 2),
          Text(
            name,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.primaryOrange,
            ),
          ),
        ],
      ),
    );
  }
}