import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gemini_ai/screens/home/widgets/message_item.dart';
import 'package:provider/provider.dart';

part 'home_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeLogic logic;

  @override
  void initState() {
    logic = HomeLogic(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat With Gemini'),
          surfaceTintColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                logic.clearChat();
              },
              icon: const Icon(Icons.clear_all),
            ),
          ],
        ),
        body: ChangeNotifierProvider.value(
          value: logic,
          child: Consumer<HomeLogic>(
            builder: (context, logic, child) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        controller: logic.scrollController,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: logic.chatMessages.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: logic.chatMessages[index]['isGemini']
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: MessageItem(
                              message: logic.chatMessages[index]['message'],
                              isGemini: logic.chatMessages[index]['isGemini'],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: logic.chatController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Type a message',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (logic.chatController.text.isNotEmpty) {
                              logic.onChatSend();
                            }
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
