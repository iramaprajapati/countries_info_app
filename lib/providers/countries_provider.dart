import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:countries_info_app/controllers/countries_controller.dart';
import 'package:countries_info_app/models/country_model.dart';
import 'package:flutter/foundation.dart';

class CountriesProvider with ChangeNotifier {
  final CountriesController _controller = CountriesController();
  List<CountryModel>? _countries;
  bool _isLoading = true;
  String? _errorMessage;

  CountriesProvider() {
    fetchCountries();
  }

  List<CountryModel>? get countries => _countries;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCountries() async {
    try {
      // Check for internet connection
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception("No internet connection");
      }

      _isLoading = true;
      _errorMessage = null;
      notifyListeners(); // Notify listeners about state change

      _countries = await _controller.fetchCountries(); // Fetch data
      _isLoading = false;
      notifyListeners(); // Notify listeners when done
    } catch (error) {
      _isLoading = false;
      _errorMessage = 'Error fetching countries: ${error.toString()}';
      log(_errorMessage.toString());
      notifyListeners(); // Notify listeners about the error
    } finally {
      _isLoading = false; // Data fetching completed
      notifyListeners(); // Notify listeners to rebuild UI
    }
  }
}
