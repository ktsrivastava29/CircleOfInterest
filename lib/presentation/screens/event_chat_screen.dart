dart
import 'dart:async';

import 'package:flutter/material.dart';

class ChatMessage {
  final String id;
  final String roomId;
  final String senderId;
  final String senderName;
  final String text;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.createdAt,
  });
}

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final Map<String, List<ChatMessage>> _roomMessages = {};
  final Map<String, StreamController<List<ChatMessage>>> _controllers = {};

  Stream<List<ChatMessage>> subscribeToRoom(String roomId) {
    _controllers.putIfAbsent(roomId, () => StreamController<List<ChatMessage>>.broadcast());
    _roomMessages.putIfAbsent(roomId, () => <ChatMessage>[]);
    // Emit current snapshot
    scheduleMicrotask(() {
      _controllers[roomId]!.add(List<ChatMessage>.unmodifiable(_roomMessages[roomId]!));
    });
    return _controllers[roomId]!.stream;
  }

  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String senderName,
    required String text,
  }) async {
    final message = ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      roomId: roomId,
      senderId: senderId,
      senderName: senderName,
      text: text.trim(),
      createdAt: DateTime.now(),
    );
    _roomMessages.putIfAbsent(roomId, () => <ChatMessage>[]);
    _roomMessages[roomId]!.add(message);
    _controllers[roomId]?.add(List<ChatMessage>.unmodifiable(_roomMessages[roomId]!));
  }
}

class EventChatScreen extends StatefulWidget {
  final String eventId;
  final String currentUserId;
  final String currentUserName;

  const EventChatScreen({
    super.key,
    required this.eventId,
    required this.currentUserId,
    required this.currentUserName,
  });

  @override
  State<EventChatScreen> createState() => _EventChatScreenState();
}

class _EventChatScreenState extends State<EventChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final Stream<List<ChatMessage>> _messagesStream;

  @override
  void initState() {
    super.initState();
    _messagesStream = ChatService().subscribeToRoom(widget.eventId);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    await ChatService().sendMessage(
      roomId: widget.eventId,
      senderId: widget.currentUserId,
      senderName: widget.currentUserName,
      text: text,
    );
    _textController.clear();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                final messages = snapshot.data ?? const <ChatMessage>[];
                return ListView.builder(
                  key: const Key('chat_message_list'),
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final m = messages[index];
                    final isMe = m.senderId == widget.currentUserId;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.deepPurple.shade100 : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              m.senderName,
                              style: const TextStyle(fontSize: 11, color: Colors.black54),
                            ),
                            const SizedBox(height: 2),
                            Text(m.text),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const Key('chat_input_field'),
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onSubmitted: (_) => _handleSend(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    key: const Key('chat_send_button'),
                    icon: const Icon(Icons.send),
                    onPressed: _handleSend,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}