enum MessageType { Text, Image, Video }

enum MessageAuthor { User, Agent }

class Message {
  Message({
    required this.text,
    required this.type,
    required this.author,
    this.image,
  });

  final String text;
  final String? image;
  final MessageType type;
  final MessageAuthor author;
}
