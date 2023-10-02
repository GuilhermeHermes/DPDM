import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiUrl =
    "https://api.hgbrasil.com/finance?format=json-cors&key=2a34b926";

Future<Map<String, dynamic>> fetchData() async {
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Falha ao carregar dados da API');
  }
}
