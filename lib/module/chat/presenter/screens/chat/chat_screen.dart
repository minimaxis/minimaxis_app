import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:minimaxis_app/core/styles/colors.dart';
import 'package:minimaxis_app/core/styles/text_style.dart';
import 'package:minimaxis_app/main.dart';
import 'package:minimaxis_app/module/chat/presenter/screens/chat/chat_controller.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/build_appbar.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/build_drawer.dart';
import 'package:minimaxis_app/module/chat/presenter/widgets/text_input_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatMessage {
  final String prompt;
  final String response;

  ChatMessage({required this.prompt, required this.response});
}

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
  bool isLoading = false;
  List<ChatMessage> messages = [];

  @override
  void initState() {
    inputChatController = TextEditingController();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller = ChatController();
    currentConversation = "";

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
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'Not sure where to start? Use this example (click only).',
                                speed: const Duration(milliseconds: 50),
                                textStyle: GoogleFonts.inter(
                                  textStyle: styleModifier.defaultWhite,
                                ),
                              ),
                            ],
                            totalRepeatCount: 1,
                            pause: const Duration(seconds: 1),
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
          buildChatList(),
          _buildLoadingIndicator(),
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
                        _onSendPressed();
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

  Widget _buildLoadingIndicator() {
    return isLoading
        ? Container(
            color: AppColors.onPrimary,
            child: const Center(
              child: SpinKitChasingDots(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          )
        : Container();
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
            "Here is a miniscript policy:\n```miniscript_policy\nor(pk(key_1),or(pk(key_2),or(pk(key_3),or(pk(key_4),or(pk(key_5),or(pk(key_6),or(pk(key_7),pk(key_8))))))))\n```\nExplain what this policy does in plain English.";
      });
    }
  }

  void _onSendPressed() async {
    setState(() {
      isLoading = true;
    });
    await _getOpenAIResponse(inputChatController.text);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _getOpenAIResponse(String prompt) async {
    final log = Logger();

    const apiUrl = "https://api.openai.com/v1/chat/completions";
    final apiKey = dotenv.env['OPENAI_API_KEY'];

    if (apiKey == null) {
      log.e('API key not found in environment variables.');
      return;
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({
        "model": "gpt-4-1106-preview",
        "messages": [
          {
            "role": "system",
            "content":
                "You are a specialized code assistant for Bitcoin Miniscript policies. Miniscript is a language used to write Bitcoin Scripts in a structured manner, which facilitates the analysis and composition of Bitcoin smart contracts. Your role involves assisting users in understanding, composing and correcting Miniscript policies. Your guidance will focus on explaining the principles of Miniscript, helping users understand specific policies, and offering advice on how to compose their own policies effectively. You should strive to provide clear, concise, and accurate explanations, tailored to the user's level of understanding of Miniscript and Bitcoin smart contracts. Valid functions: pk(NAME), after(NUM), older(NUM), sha256(H), hash256(H), ripemd160(H), hash160(H), and(POL,POL), or([N@]POL,[N@]POL), thresh(NUM,POL,POL,...). Any function that is not (pk, after, older, sha256, hash256, ripemd160, hash160, and, or, thresh) should be considered invalid. Every policy must contain function pk, because must have a key to sign."
          },
          {"role": "user", "content": prompt}
        ],
        "temperature": 0,
        "max_tokens": 512,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final messageResponse = responseData['choices'][0]['message']['content'];

      setState(() {
        messages.add(ChatMessage(prompt: prompt, response: messageResponse));
        inputChatController.text = "";
      });
    } else {
      log.e("Erro na chamada à API do OpenAI: ${response.statusCode}");
      log.i(response.body);
    }
  }

  Widget buildChatList() {
    return controller.buildChatList(messages, isLoading);
  }
}
