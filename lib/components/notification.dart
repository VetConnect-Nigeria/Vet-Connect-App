import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final String id;
  final String header;
  final bool read;

  const Notification({
    required this.header,
    required this.id,
    required this.read,
  });

  @override
  List<Object?> get props => [id];
}
