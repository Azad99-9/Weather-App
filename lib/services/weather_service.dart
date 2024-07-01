import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherService {
  // API key for accessing OpenWeatherMap data (replace with your own)
  static const String _apiKey = '5c41c60311ff7d47298ef18cdbecd3ac';

  // Base URL for OpenWeatherMap weather API
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  // List of suggested cities (populated during initialization)
  static List<String> cities = [];

  // Fetches and stores city suggestions from an external API on initialization
  static Future<void> initialise() async {
    if (cities.isEmpty) {
      final url = Uri.parse(
          'https://countriesnow.space/api/v0.1/countries/population/cities'); // URL for city suggestions
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final citiesData = json.decode(response.body)['data'];

        citiesData.forEach((city) {
          if (city.containsKey('city')) {
            cities.add(city['city'] as String);
          } else {
            print('Warning: City object missing "city" key');
          }
        });
      } else {
        throw Exception('Failed to load city suggestions');
      }
    }
  }

  // Fetches weather data for a given city name
  Future<Weather> fetchWeather(String cityName) async {
    cityName = cityName.split(' ')[0];
    final url = Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Provides city suggestions based on a search pattern
  Future<List<String>> getCitySuggestions(String pattern) async {
    return cities
        .where((city) => city.toLowerCase().startsWith(pattern.toLowerCase()))
        .toList();
  }
}
