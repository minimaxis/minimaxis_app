import 'package:flutter_modular/flutter_modular.dart';
import 'package:minimaxis_app/module/chat/presenter/screens/auth/auth_screen.dart';
import 'package:minimaxis_app/module/chat/presenter/screens/chat/chat_screen.dart';
import 'package:minimaxis_app/module/chat/presenter/screens/credit/credit_screen.dart';
import 'package:minimaxis_app/module/chat/presenter/screens/flowchart/flowchart_screen.dart';
import 'package:minimaxis_app/module/chat/presenter/screens/payment/payment_screen.dart';

class ChatModule extends Module {

  @override
  List<Bind> get binds => [

  ];

  @override
  List<ChildRoute> get routes => [
    ChildRoute('/', child: (context, args) => const AuthScreen()),
    ChildRoute('/chat', child: (context, args) => const ChatScreen()),
    ChildRoute('/flowchart', child: (context, args) =>  const FlowchartScreen()),
    ChildRoute('/credit', child: (context, args) => const CreditScreen()),
    ChildRoute('/payment', child: (context, args) => const PaymentScreen())
  ];
}