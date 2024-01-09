import 'package:http/http.dart' as http;
import 'dart:convert';

class RestUtil {
  static String urlBase = 'localhost:5000';

  static Future<http.Response> addData(String uri, Map<String,dynamic> data) async {
    final response = await http.post(
      Uri.http(urlBase,uri),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return response;
  }

}