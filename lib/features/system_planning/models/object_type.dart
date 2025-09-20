// lib/features/system_planning/models/object_type.dart

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

enum SystemType {
  energy,
  water, 
  gas,
  multiSystem
}

enum ConnectionType {
  energy,
  water,
  gas,
  inactive
}

enum ObjectStatus {
  planned,
  installed
}

class ObjectType extends Equatable {
  final String id;
  final String name;
  final IconData icon;
  final SystemType systemType;
  final int maxObjects; // -1 for unlimited, 1 for single, n for specific limit
  final List<String> inputConnections; // IDs of object types that connect to this one
  final List<String> outputConnections; // IDs of object types this connects to
  final Color color;

  const ObjectType({
    required this.id,
    required this.name,
    required this.icon,
    required this.systemType,
    required this.maxObjects,
    required this.inputConnections,
    required this.outputConnections,
    required this.color,
  });

  @override
  List<Object?> get props => [
    id, name, icon, systemType, maxObjects, 
    inputConnections, outputConnections, color
  ];
}

class ObjectInstance extends Equatable {
  final String id;
  final String objectTypeId;
  final String name;
  final ObjectStatus status;
  final Map<String, dynamic> specifications; // Will contain product-specific data
  final double? cost;
  final double? weight;
  final double? powerConsumption;
  final double? powerGeneration;
  final String? imageUrl;

  const ObjectInstance({
    required this.id,
    required this.objectTypeId,
    required this.name,
    required this.status,
    this.specifications = const {},
    this.cost,
    this.weight,
    this.powerConsumption,
    this.powerGeneration,
    this.imageUrl,
  });

  ObjectInstance copyWith({
    String? id,
    String? objectTypeId,
    String? name,
    ObjectStatus? status,
    Map<String, dynamic>? specifications,
    double? cost,
    double? weight,
    double? powerConsumption,
    double? powerGeneration,
    String? imageUrl,
  }) {
    return ObjectInstance(
      id: id ?? this.id,
      objectTypeId: objectTypeId ?? this.objectTypeId,
      name: name ?? this.name,
      status: status ?? this.status,
      specifications: specifications ?? this.specifications,
      cost: cost ?? this.cost,
      weight: weight ?? this.weight,
      powerConsumption: powerConsumption ?? this.powerConsumption,
      powerGeneration: powerGeneration ?? this.powerGeneration,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
    id, objectTypeId, name, status, specifications,
    cost, weight, powerConsumption, powerGeneration, imageUrl
  ];
}

class TypeConnection extends Equatable {
  final String fromObjectTypeId;
  final String toObjectTypeId;
  final ConnectionType connectionType;
  final bool isActive;

  const TypeConnection({
    required this.fromObjectTypeId,
    required this.toObjectTypeId,
    required this.connectionType,
    this.isActive = true,
  });

  TypeConnection copyWith({
    String? fromObjectTypeId,
    String? toObjectTypeId,
    ConnectionType? connectionType,
    bool? isActive,
  }) {
    return TypeConnection(
      fromObjectTypeId: fromObjectTypeId ?? this.fromObjectTypeId,
      toObjectTypeId: toObjectTypeId ?? this.toObjectTypeId,
      connectionType: connectionType ?? this.connectionType,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [fromObjectTypeId, toObjectTypeId, connectionType, isActive];
}

// Extension methods for getting connection colors
extension ConnectionTypeExtension on ConnectionType {
  Color get color {
    switch (this) {
      case ConnectionType.energy:
        return Colors.yellow;
      case ConnectionType.water:
        return Colors.blue;
      case ConnectionType.gas:
        return Colors.white;
      case ConnectionType.inactive:
        return Colors.grey;
    }
  }
}

extension SystemTypeExtension on SystemType {
  Color get color {
    switch (this) {
      case SystemType.energy:
        return Colors.yellow.shade700;
      case SystemType.water:
        return Colors.blue.shade700;
      case SystemType.gas:
        return Colors.red.shade700;
      case SystemType.multiSystem:
        return Colors.purple.shade700;
    }
  }
}