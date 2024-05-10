import 'dart:convert';

import 'package:countries_info_app/models/country_model.dart';
import 'package:dio/dio.dart';

class CountriesController {
  final Dio _dio = Dio();
  static const String _endpoint = 'https://restcountries.com/v3.1/all';

  Future<List<CountryModel>> fetchCountries() async {
    try {
      final response = await _dio.get(_endpoint);

      if (response.statusCode == 200) {
        final rawData = response.data;

        // Convert to JSON string if not already a string
        final jsonStr = rawData is String ? rawData : json.encode(rawData);
        // print('JSON string: $jsonStr');

        return countryModelFromJson(jsonStr);
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }
}
