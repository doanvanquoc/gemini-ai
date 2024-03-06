import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, this.isGemini = false, required this.message});
  final bool isGemini;
  final String message;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isGemini ? Colors.grey.shade300 : Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Markdown(
          data: message,
          selectable: true,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          styleSheet: MarkdownStyleSheet(
            p: TextStyle(color: isGemini ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}
