import 'package:http/http.dart' as http;
import 'dart:convert';

class RestUtil {
  static String urlBase = 'localhost:5000';
  // static String urlBase = '127.0.0.1:5000';
  // static String urlBase = '192.168.28.111:5000';

  static Future<http.Response> addData(String uri, Map<String,dynamic> data) async {
    final response = await http.post(
      Uri.http(urlBase,uri),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print("PUT ${uri} - ${response.statusCode}");
    return response;
  }

  static Future<http.Response> getData(String uri) async {
    final response = await http.get(
      Uri.http(urlBase,uri),
    );
    print("GET $uri - ${response.statusCode}");
    return response;
  }

  static Future<http.Response> getDataId(String uri, String id) async {
    final response = await http.get(
      Uri.http(urlBase,"$uri/$id"),
    );
    print("GET $uri - ${response.statusCode}");
    return response;
  }


}