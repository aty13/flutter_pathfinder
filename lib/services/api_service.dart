import 'dart:convert';
import 'package:http/http.dart' as http;

// 'https://flutter.webspark.dev/flutter/api'

class ApiService {
  Future getResponse(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    return jsonDecode(response.body);
  }

  // _postAnswers() {}
  Future postResponse() async {
    http.Response response = await http.post(
      Uri.parse('https://flutter.webspark.dev/flutter/api'),
      // body: jsonEncode(object),
    );
  }
}
