import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    const Message(text: 'Hola, mi amor!', fromWho: FromWho.me),
    const Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me),
    const Message(text: 'Sí, ya regresé', fromWho: FromWho.hers)
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);

    notifyListeners();
    moveScrollController();

    // si tu mensaje termina en '?' ella va a responder
    if (text.endsWith("?")) {
      await herReplay();
    }

    notifyListeners();
    moveScrollController();
  }

  Future<void> herReplay() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
  }

  Future<void> moveScrollController() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
