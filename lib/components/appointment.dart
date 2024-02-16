import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Appointment extends Equatable {
  final String id;
  final String image;
  final String name;
  final DateTime date;
  final TimeOfDay time;

  const Appointment({
    required this.id,
    required this.image,
    required this.name,
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [id];
}
