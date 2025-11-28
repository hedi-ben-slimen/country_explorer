import 'dart:convert'; // For jsonDecode
import 'package:http/http.dart' as http; // Use 'as http' convention
import '../models/country.dart'; // The model we created in Step 1.3

class ApiService {
  // Use the specific API URL provided by your professor.
  // Note: You must check the documentation of apicountries.com for the exact endpoint!
  // This is a common structure for a 'get all' endpoint:
  static const String baseUrl = "https://www.apicountries.com/api/v1/countries";

  Future<List<Country>> getCountries() async {
    // 1. Construct the URL
    final uri = Uri.parse(baseUrl); 
    
    try {
      // 2. Make the HTTP Request
      final response = await http.get(uri);

      // 3. Check the HTTP Status Code
      if (response.statusCode == 200) {
        // HTTP 200 means success. The body contains the JSON data.
        
        // Decode the JSON string into a Dart list of dynamic maps
        List<dynamic> body = json.decode(response.body); 
        
        // 4. Convert JSON Maps to Dart Objects
        List<Country> countries = body.map((dynamic item) {
          // Pass each JSON map to the Country.fromJson factory constructor
          return Country.fromJson(item as Map<String, dynamic>);
        }).toList();

        return countries;

      } else {
        // If status code is 404, 500, etc., throw a custom exception
        throw Exception('Failed to load countries. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Catch network errors (e.g., no internet connection)
      throw Exception('Network Error: Could not connect to the API. Details: $e');
    }
  }
}