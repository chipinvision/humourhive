import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService{
  static const String apiUrl = "https://v2.jokeapi.dev";

  static Future<String> getJoke() async{
    final response = await http.get(Uri.parse("$apiUrl/joke/Programming?type=single"));
    if(response.statusCode==200){
      final decodedResponse = json.decode(response.body);
      return decodedResponse['joke'];
    }else{
      throw Exception('Failed to load joke');
    }
  }
}