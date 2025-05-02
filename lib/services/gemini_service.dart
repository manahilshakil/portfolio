import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  /// Function to send a prompt and get a response from Gemini API
  Future<String> fetchResponse(String prompt) async {
    try {
      final response = await Gemini.instance.prompt(parts: [
        Part.text(prompt)
      ]);
      return response?.output ?? 'No response received';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
