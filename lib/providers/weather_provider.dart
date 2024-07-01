import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

// Define a provider that supplies an instance of WeatherService
final weatherServiceProvider = Provider((ref) => WeatherService());

// Define a FutureProvider that fetches weather data for a given city name
// The family modifier allows passing an argument (cityName) to the provider
final weatherProvider = FutureProvider.family<Weather, String>((ref, cityName) async {
  // Read the WeatherService instance from the weatherServiceProvider
  final weatherService = ref.read(weatherServiceProvider);

  // Use the WeatherService instance to fetch weather data for the given city name
  return await weatherService.fetchWeather(cityName);
});
