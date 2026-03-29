import 'package:cloud_firestore/cloud_firestore.dart';

class physicalStats {
  final double heightCm;
  final double weightKg;
  final double bmi;

  physicalStats({
    required this.heightCm,
    required this.weightKg,
    required this.bmi,
  });

  Map<String, dynamic> toMap() {
    return {
      'height_cm': heightCm,
      'weight_kg': weightKg,
      'bmi': bmi,
      'last_updated': FieldValue.serverTimestamp(),
    };
  }

  factory physicalStats.fromMap(Map<String, dynamic> map) {
    return physicalStats(
      heightCm: (map['height_cm'] ?? 0).toDouble(),
      weightKg: (map['weight_kg'] ?? 0).toDouble(),
      bmi: (map['bmi'] ?? 0).toDouble(),
    );
  }
}

class UserModel {
  final String uid;
  final String email;
  final String? name;
  final String? phone;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? bloodGroup;
  final List<String> allergies;
  final physicalStats? stats;
  final bool onboardingCompleted;
  final String recoveryStatus;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.bloodGroup,
    this.allergies = const [],
    this.stats,
    this.onboardingCompleted = false,
    this.recoveryStatus = 'healthy',
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'date_of_birth': dateOfBirth != null ? Timestamp.fromDate(dateOfBirth!) : null,
      'gender': gender,
      'blood_group': bloodGroup,
      'allergies': allergies,
      'physical_stats': stats?.toMap(),
      'onboarding_completed': onboardingCompleted,
      'recovery_status': recoveryStatus,
      'created_at': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      uid: docId,
      email: map['email'] ?? '',
      name: map['name'],
      phone: map['phone'],
      dateOfBirth: (map['date_of_birth'] as Timestamp?)?.toDate(),
      gender: map['gender'],
      bloodGroup: map['blood_group'],
      allergies: List<String>.from(map['allergies'] ?? []),
      stats: map['physical_stats'] != null ? physicalStats.fromMap(map['physical_stats']) : null,
      onboardingCompleted: map['onboarding_completed'] ?? false,
      recoveryStatus: map['recovery_status'] ?? 'healthy',
      createdAt: (map['created_at'] as Timestamp?)?.toDate(),
    );
  }
}
