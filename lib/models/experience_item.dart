import 'package:flutter/foundation.dart';

/// Immutable domain model for a work experience entry.
@immutable
class ExperienceItem {
  final String role;
  final String company;
  final String location;
  final String period;
  final bool isCurrent;
  final String description;
  final List<String> achievements;

  const ExperienceItem({
    required this.role,
    required this.company,
    required this.location,
    required this.period,
    this.isCurrent = false,
    required this.description,
    required this.achievements,
  });

  factory ExperienceItem.fromMap(Map<String, dynamic> map) {
    return ExperienceItem(
      role: map['role'] as String,
      company: map['company'] as String,
      location: map['location'] as String,
      period: map['period'] as String,
      isCurrent: map['isCurrent'] as bool? ?? false,
      description: map['description'] as String,
      achievements: (map['achievements'] as List).cast<String>(),
    );
  }
}

