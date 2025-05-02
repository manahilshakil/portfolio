import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/gemini_provider.dart';
import '../models/message_model.dart';

class CocoBotChat extends StatefulWidget {
  const CocoBotChat({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<CocoBotChat> createState() => _CocoBotChatState();
}

class _CocoBotChatState extends State<CocoBotChat> {
  final TextEditingController _controller = TextEditingController();

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (widget.scrollController.hasClients) {
        widget.scrollController.jumpTo(widget.scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GeminiProvider>(context);
    _scrollToBottom();

    final Color primaryColor = const Color(0xFF63B3ED);
    final Color backgroundColor = Colors.white;

    return Positioned(
      bottom: 20,
      right: 20,
      child: Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              child: const Text(
                '💬 CocoBot',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: widget.scrollController,
                padding: const EdgeInsets.all(10),
                itemCount: provider.messages.length + (provider.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= provider.messages.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  Message message = provider.messages[index];
                  return Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      constraints: const BoxConstraints(maxWidth: 220),
                      decoration: BoxDecoration(
                        color: message.isUser
                            ? primaryColor.withOpacity(0.3)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: primaryColor.withOpacity(0.2)),
                      ),
                      child: Text(
                        message.text,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          provider.sendMessage(value.trim());
                          _controller.clear();
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Type here...',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        provider.sendMessage(_controller.text.trim());
                        _controller.clear();
                      }
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
