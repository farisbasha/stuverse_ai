part of 'chat_cubit.dart';

class ChatState extends Equatable {
  ChatState({
    this.messages = const [],
    this.isLoading = false,
    required this.agent,
  });

  final List<Message> messages;
  final bool isLoading;
  final Agent agent;

  @override
  List<Object> get props => [
        messages,
        isLoading,
        agent,
      ];

  ChatState copyWith({
    List<Message>? messages,
    bool? isLoading,
    Agent? agent,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      agent: agent ?? this.agent,
    );
  }
}
