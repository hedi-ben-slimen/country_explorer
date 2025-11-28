import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/api_service.dart';

class CountryProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Country> _countries = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters to access data safely
  List<Country> get countries => _countries;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchCountries() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners(); // Tells UI: "Show the loading spinner!"

    try {
      _countries = await _apiService.getCountries();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Tells UI: "Data is ready (or error happened), update now!"
    }
  }
}