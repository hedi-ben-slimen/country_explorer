import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class ApiService {
  final String baseUrl = "https://www.apicountries.com/countries"; // Verify endpoint in documentation

  Future<List<Country>> getCountries() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      // Map the list of JSON objects to a list of Country objects
      List<Country> countries = body.map((dynamic item) => Country.fromJson(item)).toList();
      return countries;
    } else {
      throw Exception('Failed to load countries');
    }
  }
}