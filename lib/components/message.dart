import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String? text;
  final String? image;
  final String senderID;
  final String receiverID;
  final DateTime timeStamp;

  const Message({
    required this.id,
    required this.timeStamp,
    required this.senderID,
    required this.receiverID,
    this.text,
    this.image,
  });

  @override
  List<Object?> get props => [id];
}
