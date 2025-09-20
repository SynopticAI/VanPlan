// lib/features/system_planning/data/system_topology_data.dart

import 'package:flutter/material.dart';
import '../models/object_type.dart';

class SystemTopologyData {
  // Define all Object Types
  static final Map<String, ObjectType> objectTypes = {
    // === ENERGY SYSTEM ===
    'energy_storage': const ObjectType(
      id: 'energy_storage',
      name: 'Energy Storage',
      icon: Icons.battery_charging_full,
      systemType: SystemType.energy,
      maxObjects: -1, // Unlimited batteries
      inputConnections: ['energy_sources', 'energy_conversion'],
      outputConnections: ['energy_conversion', 'refrigerator', 'air_conditioner', 'starlink', 'washing_machine', 'dishwasher', 'lights', 'water_pump', 'ventilation'],
      color: Color(0xFF4CAF50),
    ),
    
    'energy_sources': const ObjectType(
      id: 'energy_sources',
      name: 'Energy Sources',
      icon: Icons.solar_power,
      systemType: SystemType.energy,
      maxObjects: -1, // Multiple solar panels, alternator, etc.
      inputConnections: [],
      outputConnections: ['energy_conversion', 'energy_storage'],
      color: Color(0xFFFF9800),
    ),
    
    'energy_conversion': const ObjectType(
      id: 'energy_conversion',
      name: 'Energy Conversion',
      icon: Icons.transform,
      systemType: SystemType.energy,
      maxObjects: -1, // Multiple inverters, converters
      inputConnections: ['energy_sources', 'energy_storage'],
      outputConnections: ['energy_storage', 'refrigerator', 'air_conditioner', 'washing_machine', 'dishwasher'],
      color: Color(0xFF9C27B0),
    ),
    
    // === ENERGY CONSUMERS ===
    'refrigerator': const ObjectType(
      id: 'refrigerator',
      name: 'Refrigerator',
      icon: Icons.kitchen,
      systemType: SystemType.energy,
      maxObjects: 1, // Single fridge
      inputConnections: ['energy_storage', 'energy_conversion'],
      outputConnections: [],
      color: Color(0xFF2196F3),
    ),
    
    'air_conditioner': const ObjectType(
      id: 'air_conditioner',
      name: 'Air Conditioner',
      icon: Icons.ac_unit,
      systemType: SystemType.energy,
      maxObjects: 1, // Single AC unit
      inputConnections: ['energy_storage', 'energy_conversion'],
      outputConnections: [],
      color: Color(0xFF00BCD4),
    ),
    
    'starlink': const ObjectType(
      id: 'starlink',
      name: 'Starlink',
      icon: Icons.satellite_alt,
      systemType: SystemType.energy,
      maxObjects: 1, // Single Starlink dish
      inputConnections: ['energy_storage'],
      outputConnections: [],
      color: Color(0xFF607D8B),
    ),
    
    'lights': const ObjectType(
      id: 'lights',
      name: 'Lighting',
      icon: Icons.lightbulb,
      systemType: SystemType.energy,
      maxObjects: -1, // Multiple light fixtures
      inputConnections: ['energy_storage'],
      outputConnections: [],
      color: Color(0xFFFFC107),
    ),
    
    'ventilation': const ObjectType(
      id: 'ventilation',
      name: 'Ventilation',
      icon: Icons.air,
      systemType: SystemType.energy,
      maxObjects: -1, // Multiple fans
      inputConnections: ['energy_storage'],
      outputConnections: [],
      color: Color(0xFF8BC34A),
    ),
    
    // === WATER SYSTEM ===
    'fresh_water_storage': const ObjectType(
      id: 'fresh_water_storage',
      name: 'Fresh Water Storage',
      icon: Icons.water_drop,
      systemType: SystemType.water,
      maxObjects: -1, // Multiple fresh water tanks
      inputConnections: [],
      outputConnections: ['water_pump', 'water_heater'],
      color: Color(0xFF03A9F4),
    ),
    
    'gray_water_storage': const ObjectType(
      id: 'gray_water_storage',
      name: 'Gray Water Storage',
      icon: Icons.water,
      systemType: SystemType.water,
      maxObjects: -1, // Multiple gray water tanks
      inputConnections: ['shower', 'sink', 'washing_machine', 'dishwasher'],
      outputConnections: [],
      color: Color(0xFF607D8B),
    ),
    
    'black_water_storage': const ObjectType(
      id: 'black_water_storage',
      name: 'Black Water Storage',
      icon: Icons.wc,
      systemType: SystemType.water,
      maxObjects: 1, // Single black water tank
      inputConnections: ['toilet'],
      outputConnections: [],
      color: Color(0xFF424242),
    ),
    
    'water_pump': const ObjectType(
      id: 'water_pump',
      name: 'Water Pump',
      icon: Icons.abc_rounded,
      systemType: SystemType.multiSystem, // Uses water + energy
      maxObjects: 1, // Single water pump
      inputConnections: ['fresh_water_storage', 'energy_storage'],
      outputConnections: ['shower', 'sink', 'washing_machine', 'dishwasher', 'water_heater'],
      color: Color(0xFF5C6BC0),
    ),
    
    'water_heater': const ObjectType(
      id: 'water_heater',
      name: 'Water Heater',
      icon: Icons.hot_tub,
      systemType: SystemType.multiSystem, // Can be gas or electric
      maxObjects: 1, // Single water heater
      inputConnections: ['fresh_water_storage', 'water_pump', 'gas_storage', 'energy_storage'],
      outputConnections: ['shower', 'sink', 'dishwasher'],
      color: Color(0xFFFF5722),
    ),
    
    // === WATER CONSUMERS ===
    'shower': const ObjectType(
      id: 'shower',
      name: 'Shower',
      icon: Icons.shower,
      systemType: SystemType.water,
      maxObjects: 1, // Single shower
      inputConnections: ['water_pump', 'water_heater'],
      outputConnections: ['gray_water_storage'],
      color: Color(0xFF29B6F6),
    ),
    
    'sink': const ObjectType(
      id: 'sink',
      name: 'Sink',
      icon: Icons.abc_rounded,
      systemType: SystemType.water,
      maxObjects: -1, // Multiple sinks
      inputConnections: ['water_pump', 'water_heater'],
      outputConnections: ['gray_water_storage'],
      color: Color(0xFF26C6DA),
    ),
    
    'toilet': const ObjectType(
      id: 'toilet',
      name: 'Toilet',
      icon: Icons.wc,
      systemType: SystemType.water,
      maxObjects: 1, // Single toilet
      inputConnections: [],
      outputConnections: ['black_water_storage'],
      color: Color(0xFF78909C),
    ),
    
    // === MULTI-SYSTEM APPLIANCES ===
    'washing_machine': const ObjectType(
      id: 'washing_machine',
      name: 'Washing Machine',
      icon: Icons.local_laundry_service,
      systemType: SystemType.multiSystem, // Uses water + energy
      maxObjects: 1, // Single washing machine
      inputConnections: ['energy_storage', 'energy_conversion', 'water_pump'],
      outputConnections: ['gray_water_storage'],
      color: Color(0xFF9575CD),
    ),
    
    'dishwasher': const ObjectType(
      id: 'dishwasher',
      name: 'Dishwasher',
      icon: Icons.kitchen_outlined,
      systemType: SystemType.multiSystem, // Uses water + energy
      maxObjects: 1, // Single dishwasher
      inputConnections: ['energy_storage', 'energy_conversion', 'water_pump', 'water_heater'],
      outputConnections: ['gray_water_storage'],
      color: Color(0xFF7986CB),
    ),
    
    // === GAS SYSTEM ===
    'gas_storage': const ObjectType(
      id: 'gas_storage',
      name: 'Gas Storage',
      icon: Icons.propane_tank,
      systemType: SystemType.gas,
      maxObjects: -1, // Multiple propane tanks
      inputConnections: [],
      outputConnections: ['gas_stove', 'gas_heater', 'water_heater'],
      color: Color(0xFFE53935),
    ),
    
    'gas_stove': const ObjectType(
      id: 'gas_stove',
      name: 'Gas Stove',
      icon: Icons.local_fire_department,
      systemType: SystemType.gas,
      maxObjects: 1, // Single gas stove
      inputConnections: ['gas_storage'],
      outputConnections: [],
      color: Color(0xFFFF7043),
    ),
    
    'gas_heater': const ObjectType(
      id: 'gas_heater',
      name: 'Gas Heater',
      icon: Icons.whatshot,
      systemType: SystemType.gas,
      maxObjects: 1, // Single gas heater
      inputConnections: ['gas_storage'],
      outputConnections: [],
      color: Color(0xFFFF8A65),
    ),
  };

  // Generate all connections based on object type definitions
  static List<TypeConnection> get allConnections {
    final connections = <TypeConnection>[];
    
    for (final objectType in objectTypes.values) {
      for (final outputId in objectType.outputConnections) {
        if (objectTypes.containsKey(outputId)) {
          // Determine connection type based on the systems involved
          ConnectionType connectionType = _determineConnectionType(objectType.id, outputId);
          
          connections.add(TypeConnection(
            fromObjectTypeId: objectType.id,
            toObjectTypeId: outputId,
            connectionType: connectionType,
            isActive: true, // All connections start active
          ));
        }
      }
    }
    
    return connections;
  }

  // Helper method to determine connection type between two object types
  static ConnectionType _determineConnectionType(String fromId, String toId) {
    final fromType = objectTypes[fromId];
    final toType = objectTypes[toId];
    
    if (fromType == null || toType == null) return ConnectionType.inactive;
    
    // Energy system connections
    if (fromType.systemType == SystemType.energy && toType.systemType == SystemType.energy) {
      return ConnectionType.energy;
    }
    
    // Water system connections
    if (fromType.systemType == SystemType.water && toType.systemType == SystemType.water) {
      return ConnectionType.water;
    }
    
    // Gas system connections  
    if (fromType.systemType == SystemType.gas && toType.systemType == SystemType.gas) {
      return ConnectionType.gas;
    }
    
    // Multi-system connections - determine by the flow type
    if (fromId.contains('energy') || toId.contains('energy') || 
        fromId == 'water_pump' || toId == 'water_pump') {
      // If either involves energy storage/conversion or water pump (electrical)
      if (fromType.systemType == SystemType.energy || toType.systemType == SystemType.energy ||
          fromId == 'water_pump') {
        return ConnectionType.energy;
      }
    }
    
    if (fromId.contains('water') || toId.contains('water') ||
        fromId == 'shower' || fromId == 'sink' || toId == 'shower' || toId == 'sink') {
      return ConnectionType.water;
    }
    
    if (fromId.contains('gas') || toId.contains('gas')) {
      return ConnectionType.gas;
    }
    
    // Default for multi-system connections
    return ConnectionType.energy;
  }

  // Get all object types by system
  static List<ObjectType> getObjectTypesBySystem(SystemType systemType) {
    return objectTypes.values
        .where((type) => type.systemType == systemType)
        .toList();
  }

  // Get connections for a specific object type
  static List<TypeConnection> getConnectionsForObjectType(String objectTypeId) {
    return allConnections
        .where((conn) => conn.fromObjectTypeId == objectTypeId || conn.toObjectTypeId == objectTypeId)
        .toList();
  }
}