part of 'chat_cubit.dart';

class ChatState extends Equatable {
  ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
    required this.agent,
  });

  final List<Message> messages;
  final bool isLoading;
  final Agent agent;
  final bool isError;
  final String errorMessage;

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
    bool? isError,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      agent: agent ?? this.agent,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
