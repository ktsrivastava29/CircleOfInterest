import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/chat_message.dart';
import '../../../constants/chat_constants.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe
        ? ChatConstants.myBubbleColor
        : ChatConstants.otherBubbleColor;
    final textColor = isMe ? AppColors.textPrimary : AppColors.textSecondary;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: ChatConstants.bubbleVerticalMargin,
          horizontal: ChatConstants.bubbleHorizontalMargin,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: ChatConstants.bubbleVerticalPadding,
          horizontal: ChatConstants.bubbleHorizontalPadding,
        ),
        constraints: const BoxConstraints(
          maxWidth: ChatConstants.bubbleMaxWidth,
        ),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(ChatConstants.bubbleRadius),
            topRight: const Radius.circular(ChatConstants.bubbleRadius),
            bottomLeft: Radius.circular(isMe ? ChatConstants.bubbleRadius : 0),
            bottomRight: Radius.circular(isMe ? 0 : ChatConstants.bubbleRadius),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message.senderName,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey[600],
                fontSize: 11,
              ),
            ),
            const SizedBox(height: ChatConstants.smallSpace),
            Text(
              message.text,
              style: TextStyle(color: textColor, fontSize: 15),
            ),
            const SizedBox(height: ChatConstants.smallSpace),
            Text(
              "${message.createdAt.hour}:${message.createdAt.minute.toString().padLeft(2, '0')}",
              style: TextStyle(color: Colors.grey[500], fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
