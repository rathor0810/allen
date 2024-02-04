import 'dart:convert';

import 'package:allen/secrets.dart';
import 'package:http/http.dart' as http;

final List<Map<String, String>> messages = [];

class OpenAiService {
  // final List<Map<String, String>> messages = [];

  Future<String> isAtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAiAPIKey'
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content":
                  "Does this message wants to generate AI picture, image,art or anything similar ? $prompt . Simply answer with yes or no. ",
            },
          ]
        }),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = await DallEAPI(prompt);
            return res;
          default:
            final res = await ChatGPTAPI(prompt);
            return res;
        }
      }
      return "An Internal error occur";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> ChatGPTAPI(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAiAPIKey'
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assitant',
          'content': content,
        });
        return content;
      }
      return "An Internal error occur";
    } catch (e) {
      return e.toString();
    }
  }
}

Future<String> DallEAPI(String prompt) async {
  messages.add({'role': 'user', 'content': prompt});
  try {
    final res = await http.post(
      Uri.parse('https://api.openai.com/v1/images/generations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openAiAPIKey'
      },
      body: jsonEncode({
        'prompt': prompt,
        'n': 1,
      }),
    );
    print(res.body);
    if (res.statusCode == 200) {
      String imageUrl = jsonDecode(res.body)['data'][0]['url'];
      imageUrl = imageUrl.trim();
 
      messages.add({
        'role': 'assitant',
        'content': imageUrl,
      });
      return imageUrl;
    }
    return "An Internal error occur";
  } catch (e) {
    return e.toString();
  }
}
