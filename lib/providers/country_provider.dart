import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/api_service.dart';

class CountryProvider with ChangeNotifier {
  // 1. Dependency Injection: Get the service class
  final ApiService _apiService = ApiService();
  
  // 2. State Variables (Private)
  List<Country> _countries = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // 3. Getters (Public access to private state)
  List<Country> get countries => _countries;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // 4. Main Logic: Fetch data from the service
  Future<void> fetchCountries() async {
    _isLoading = true;
    _errorMessage = '';
    // Notify all listening widgets to rebuild and show the loading indicator
    notifyListeners(); 

    try {
      _countries = await _apiService.getCountries();
    } catch (e) {
      // Catch any network or parsing errors
      _errorMessage = 'Failed to load data: Check your network connection or API URL.';
      print(e); // Good for debugging, remove later
    } finally {
      _isLoading = false;
      // Notify all listening widgets to rebuild with the new data or error message
      notifyListeners(); 
    }
  }
}