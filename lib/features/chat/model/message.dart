import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

enum MessageType { Text, Image }

enum MessageAuthor { User, Agent }

class Message {
  Message({
    required this.text,
    required this.type,
    required this.author,
    this.image,
  });

  String text;
  final Uint8List? image;
  final MessageType type;
  final MessageAuthor author;
}
