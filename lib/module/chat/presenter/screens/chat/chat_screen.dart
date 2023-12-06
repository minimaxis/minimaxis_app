import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';
import 'package:minimaxis_app/main.dart';
import 'package:minimaxis_app/module/chat/presenter/screens/chat/chat_controller.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/build_appbar.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/build_drawer.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/message_widget.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/prompt_widget.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/text_input_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController inputChatController;
  late AnimationController _animationController;
  late ChatController controller;
  double containerHeight = 0.0;
  bool shouldRenderPromptAndMessage = false;
  bool isLoading = false;

  @override
  void initState() {
    inputChatController = TextEditingController();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller = ChatController();
    currentConversation = controller.messages[0]['category']!;

    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      _animationController.forward();
      setState(() {
        containerHeight = 150.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final styleModifier = context.appTextStyles;
    return Scaffold(
      backgroundColor: AppColors.onPrimary,
      appBar: buildAppbar(context),
      drawer: buildDrawer(context),
      body: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  _toggleContainerHeight();
                },
                child: AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  height: containerHeight,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Not sure where to start? Use this example (click only).',
                            style: GoogleFonts.inter(
                              textStyle: styleModifier.defaultWhite,
                            ),
                          ),
                          SizedBox(
                            height: 55,
                            width: 80,
                            child: Image.asset('assets/logo-2.png'),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 46,
                            width: 203,
                            decoration: BoxDecoration(
                              color: AppColors.specialColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "example",
                              style: GoogleFonts.inter(
                                textStyle: styleModifier.defaultWhite,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          buildChatList(controller),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _animationController.value,
                child: Transform.translate(
                  offset: Offset(0.0, 100.0 * (1 - _animationController.value)),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      if (details.primaryDelta! < 0) {
                        _renderPromptAndMessage();
                      }
                    },
                    child: TextInputWidget(
                      textController: inputChatController,
                      onSendPressed: () => _onSendPressed(),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _toggleContainerHeight() {
    if (containerHeight == 0.0) {
      _animationController.forward();
      Future.delayed(_animationController.duration!, () {
        setState(() {
          containerHeight = 150.0;
        });
      });
    } else {
      setState(() {
        containerHeight = 0.0;
        inputChatController.text =
            controller.messages[0]['prompt']!;
      });
    }
  }

  void _onSendPressed() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    _renderPromptAndMessage();
  }

  void _renderPromptAndMessage() {
    setState(() {
      shouldRenderPromptAndMessage = true;
      isLoading = false;
      inputChatController.text = "";
    });
  }

  Expanded buildChatList(ChatController controller) {
    final styleModifier = context.appTextStyles;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (isLoading)
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Minimaxis is thinking, wait...",
                        style: GoogleFonts.inter(textStyle: styleModifier.defaultWhite),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      CircularProgressIndicator(color: AppColors.onTertiary, strokeWidth: 100),
                    ],
                  ),
                ),
              if (shouldRenderPromptAndMessage)
                PromptWidget(
                  text: controller.messages.isNotEmpty
                      ? controller.messages[0]['prompt']!
                      : 'Error',
                ),
              if (shouldRenderPromptAndMessage)
                MessageWidget(
                  text: controller.messages.isNotEmpty
                      ? controller.messages[0]['explanation']!
                      : 'Error',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
