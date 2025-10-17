import 'package:circle_of_interest/presentation/screens/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/chat_message.dart';
import '../../../services/chat_service.dart';
import '../../../constants/chat_constants.dart';

class ChatScreen extends StatefulWidget {
  final String? eventId;

  const ChatScreen({
    super.key,
    this.eventId,
    required String currentUserId,
    required String currentUserName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final String _currentUserId = 'u1';

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    await _chatService.sendMessage(
      senderId: _currentUserId,
      senderName: ChatConstants.currentUserName,
      text: text,
    );
    _textController.clear();

    await Future.delayed(ChatConstants.scrollDelay);
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: ChatConstants.scrollAnimationDuration,
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.eventId != null && widget.eventId!.isNotEmpty
              ? '${ChatConstants.title} (${widget.eventId})'
              : ChatConstants.title,
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: _chatService.messageStream,
              builder: (context, snapshot) {
                final messages = snapshot.data ?? [];
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    top: ChatConstants.mediumSpace,
                    bottom: ChatConstants.mediumSpace,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg.senderId == _currentUserId;
                    return ChatBubble(message: msg, isMe: isMe);
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ChatConstants.mediumSpace,
                vertical: ChatConstants.mediumSpace,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: ChatConstants.messageHint,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            ChatConstants.inputBorderRadius,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: ChatConstants.largeSpace,
                          vertical: ChatConstants.smallSpace + 6,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: ChatConstants.mediumSpace),
                  CircleAvatar(
                    // backgroundColor: AppColors.primary,
                    child: IconButton(
                      key: const Key('chat_send_button'),
                      icon: const Icon(Icons.send),
                      // ✅ make send icon purple
                      color: Colors.deepPurple, // or AppColors.primary
                      onPressed: _sendMessage,
                    ),
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
