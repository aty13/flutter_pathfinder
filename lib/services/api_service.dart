import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:pathfinder/models/task.dart';

// 'https://flutter.webspark.dev/flutter/api'

class ApiService {
  Future getResponse(String url) async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(url));
    } catch (e) {
      rethrow;
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw 'error';
    }
  }

  // _postAnswers() {}
  Future postResponse(List body) async {
//     var items = [];
//     for (var task in body) {
// items.add(Task);
//     }
    try {
      http.Response response = await http.post(
        Uri.parse('https://flutter.webspark.dev/flutter/api'),
        body: body,
      );
      print(body);
      log(response.body);
    } catch (e) {
      log('$e');
    }
  }
}
