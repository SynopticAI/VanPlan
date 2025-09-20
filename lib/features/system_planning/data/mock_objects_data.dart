// lib/features/system_planning/data/mock_objects_data.dart

import '../models/object_type.dart';

class MockObjectsData {
  static final Map<String, List<ObjectInstance>> _mockData = {
    // Energy Storage
    'energy_storage': [
      ObjectInstance(
        id: 'battery_1',
        objectTypeId: 'energy_storage',
        name: 'Battle Born 100Ah LiFePO4',
        status: ObjectStatus.planned,
        cost: 949.99,
        weight: 31.0,
        specifications: {
          'voltage': '12V',
          'capacity': '100Ah',
          'chemistry': 'LiFePO4',
          'cycles': '3000-5000',
          'dimensions': '12.75" x 6.85" x 8.95"',
        },
      ),
      ObjectInstance(
        id: 'battery_2',
        objectTypeId: 'energy_storage',
        name: 'Renogy 100Ah LiFePO4',
        status: ObjectStatus.planned,
        cost: 699.99,
        weight: 28.0,
        specifications: {
          'voltage': '12V',
          'capacity': '100Ah',
          'chemistry': 'LiFePO4',
          'cycles': '4000+',
          'dimensions': '12.8" x 6.77" x 8.43"',
        },
      ),
      ObjectInstance(
        id: 'battery_3',
        objectTypeId: 'energy_storage',
        name: 'AIMS 200Ah LiFePO4',
        status: ObjectStatus.planned,
        cost: 1299.99,
        weight: 52.0,
        specifications: {
          'voltage': '12V',
          'capacity': '200Ah',
          'chemistry': 'LiFePO4',
          'cycles': '3500+',
          'dimensions': '20.5" x 9.4" x 8.6"',
        },
      ),
    ],

    // Energy Sources
    'energy_sources': [
      ObjectInstance(
        id: 'solar_1',
        objectTypeId: 'energy_sources',
        name: 'Renogy 400W Monocrystalline',
        status: ObjectStatus.planned,
        cost: 449.99,
        weight: 48.0,
        powerGeneration: 400.0,
        specifications: {
          'power': '400W',
          'voltage': '12V',
          'efficiency': '22%',
          'dimensions': '82.4" x 47.2" x 1.57"',
          'type': 'Monocrystalline',
        },
      ),
      ObjectInstance(
        id: 'solar_2',
        objectTypeId: 'energy_sources',
        name: 'Goal Zero Boulder 200',
        status: ObjectStatus.planned,
        cost: 899.99,
        weight: 39.2,
        powerGeneration: 200.0,
        specifications: {
          'power': '200W',
          'voltage': '12V',
          'efficiency': '22.5%',
          'dimensions': '58.5" x 26.4" x 1.4"',
          'type': 'Monocrystalline',
        },
      ),
      ObjectInstance(
        id: 'alternator_1',
        objectTypeId: 'energy_sources',
        name: 'Sterling 60A B2B Charger',
        status: ObjectStatus.planned,
        cost: 299.99,
        weight: 4.2,
        powerGeneration: 720.0,
        specifications: {
          'output': '60A',
          'input_voltage': '12V',
          'efficiency': '95%',
          'temperature_compensation': 'Yes',
        },
      ),
    ],

    // Refrigerator
    'refrigerator': [
      ObjectInstance(
        id: 'fridge_1',
        objectTypeId: 'refrigerator',
        name: 'Dometic CFX3 55IM',
        status: ObjectStatus.planned,
        cost: 999.99,
        weight: 60.0,
        powerConsumption: 45.0,
        specifications: {
          'capacity': '54L (57 qt)',
          'voltage': '12V/24V',
          'freezer_temp': '-7°F to 50°F',
          'dimensions': '26.4" x 15.4" x 20.5"',
          'app_control': 'Yes',
        },
      ),
      ObjectInstance(
        id: 'fridge_2',
        objectTypeId: 'refrigerator',
        name: 'ARB 63qt Classic',
        status: ObjectStatus.planned,
        cost: 849.99,
        weight: 64.0,
        powerConsumption: 40.0,
        specifications: {
          'capacity': '63L (67 qt)',
          'voltage': '12V/24V',
          'freezer_temp': '-7°F to 50°F',
          'dimensions': '29.9" x 16.9" x 17.7"',
          'compressor': 'Danfoss BD35F',
        },
      ),
    ],

    // Starlink
    'starlink': [
      ObjectInstance(
        id: 'starlink_1',
        objectTypeId: 'starlink',
        name: 'Starlink Standard Kit',
        status: ObjectStatus.planned,
        cost: 599.99,
        weight: 9.2,
        powerConsumption: 100.0,
        specifications: {
          'download_speed': '25-100 Mbps',
          'upload_speed': '5-15 Mbps',
          'latency': '25-50ms',
          'coverage': 'Global (except polar regions)',
          'dimensions': '23.4" x 15.1" x 1.1"',
        },
      ),
      ObjectInstance(
        id: 'starlink_2',
        objectTypeId: 'starlink',
        name: 'Starlink RV Kit',
        status: ObjectStatus.planned,
        cost: 599.99,
        weight: 9.2,
        powerConsumption: 100.0,
        specifications: {
          'download_speed': '5-100 Mbps',
          'upload_speed': '2-10 Mbps',
          'latency': '25-60ms',
          'coverage': 'North America',
          'portability': 'Yes - pause/unpause service',
        },
      ),
    ],

    // Water Pump
    'water_pump': [
      ObjectInstance(
        id: 'pump_1',
        objectTypeId: 'water_pump',
        name: 'Shurflo 4008-101-E65',
        status: ObjectStatus.planned,
        cost: 179.99,
        weight: 4.0,
        powerConsumption: 84.0,
        specifications: {
          'flow_rate': '3.0 GPM',
          'pressure': '55 PSI',
          'voltage': '12V',
          'self_priming': 'Yes',
          'run_dry_protection': 'Yes',
        },
      ),
      ObjectInstance(
        id: 'pump_2',
        objectTypeId: 'water_pump',
        name: 'Flojet 03526-144A',
        status: ObjectStatus.planned,
        cost: 149.99,
        weight: 3.2,
        powerConsumption: 60.0,
        specifications: {
          'flow_rate': '2.9 GPM',
          'pressure': '50 PSI',
          'voltage': '12V',
          'self_priming': '8 ft vertical',
          'quiet_operation': 'Yes',
        },
      ),
    ],

    // Fresh Water Storage
    'fresh_water_storage': [
      ObjectInstance(
        id: 'tank_1',
        objectTypeId: 'fresh_water_storage',
        name: 'Valterra 42 Gallon Fresh Tank',
        status: ObjectStatus.planned,
        cost: 299.99,
        weight: 25.0,
        specifications: {
          'capacity': '42 gallons',
          'material': 'Polyethylene',
          'dimensions': '34" x 18" x 12"',
          'fittings': '1/2" NPT',
          'drain_valve': 'Included',
        },
      ),
      ObjectInstance(
        id: 'tank_2',
        objectTypeId: 'fresh_water_storage',
        name: 'Plastic-Mart 30 Gallon RV Tank',
        status: ObjectStatus.planned,
        cost: 179.99,
        weight: 18.0,
        specifications: {
          'capacity': '30 gallons',
          'material': 'Linear Polyethylene',
          'dimensions': '29" x 15" x 11"',
          'fittings': '1/2" NPT',
          'color': 'Natural',
        },
      ),
    ],

    // Gas Storage
    'gas_storage': [
      ObjectInstance(
        id: 'propane_1',
        objectTypeId: 'gas_storage',
        name: 'Manchester 11lb Propane Tank',
        status: ObjectStatus.planned,
        cost: 79.99,
        weight: 18.5,
        specifications: {
          'capacity': '11 lbs propane',
          'valve': 'ACME fitting',
          'diameter': '10.12"',
          'height': '17.5"',
          'certification': 'DOT certified',
        },
      ),
      ObjectInstance(
        id: 'propane_2',
        objectTypeId: 'gas_storage',
        name: 'Flame King 20lb Propane Tank',
        status: ObjectStatus.planned,
        cost: 119.99,
        weight: 32.0,
        specifications: {
          'capacity': '20 lbs propane',
          'valve': 'ACME fitting',
          'diameter': '12.2"',
          'height': '18"',
          'certification': 'DOT certified',
        },
      ),
    ],

    // Add more mock data for other object types as needed...
  };

  static List<ObjectInstance> getObjectsForType(String objectTypeId) {
    return _mockData[objectTypeId] ?? [];
  }

  static ObjectInstance? getObjectById(String objectId) {
    for (final objects in _mockData.values) {
      for (final object in objects) {
        if (object.id == objectId) {
          return object;
        }
      }
    }
    return null;
  }

  static List<ObjectInstance> getAllObjects() {
    final allObjects = <ObjectInstance>[];
    for (final objects in _mockData.values) {
      allObjects.addAll(objects);
    }
    return allObjects;
  }
}