import 'package:flutter/material.dart';
import 'package:minimaxis_app/module/chat/presenter/screens/chat/chat_screen.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/message_widget.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/prompt_widget.dart';

class ChatController {
  final List<Map<String, String>> messages = [];

  Widget buildChatList(List<ChatMessage> messages, bool isLoading) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: messages.map((message) {
              return Column(
                children: [
                  PromptWidget(text: message.prompt),
                  if (message.response.isNotEmpty)
                    MessageWidget(text: message.response),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
