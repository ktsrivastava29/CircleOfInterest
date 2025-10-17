import 'dart:async';
import '../models/chat_message.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final List<ChatMessage> _messages = [];
  final StreamController<List<ChatMessage>> _controller =
      StreamController.broadcast();

  Stream<List<ChatMessage>> get messageStream => _controller.stream;

  Future<void> sendMessage({
    required String senderId,
    required String senderName,
    required String text,
  }) async {
    final message = ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      senderId: senderId,
      senderName: senderName,
      text: text.trim(),
      createdAt: DateTime.now(),
    );

    _messages.add(message);
    _controller.add(List.unmodifiable(_messages));
  }

  void dispose() {
    _controller.close();
  }
}
