import 'package:flutter/material.dart';
import '../services/gemini_service.dart';
import '../models/message_model.dart';

class GeminiProvider extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();

  List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String prompt) async {
    _messages.add(Message(text: prompt, isUser: true));
    _isLoading = true;
    notifyListeners();

    final response = await _geminiService.fetchResponse(prompt);

    _messages.add(Message(text: response, isUser: false));
    _isLoading = false;
    notifyListeners();
  }
}
