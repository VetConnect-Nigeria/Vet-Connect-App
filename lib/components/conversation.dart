import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String id;
  final String userId;
  final String image;
  final String header;
  final String subtitle;
  final DateTime timestamp;
  final bool active;
  final int count;

  const Conversation({
    required this.id,
    required this.userId,
    required this.image,
    required this.header,
    required this.subtitle,
    required this.timestamp,
    required this.active,
    required this.count,
  });

  @override
  List<Object?> get props => [id];
}
