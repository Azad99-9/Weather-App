import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/views/home_screen.dart';

void main() async {
  // Initialize the WeatherService, typically to set up necessary configurations or dependencies
  await WeatherService.initialise();
  
  // Ensure Flutter bindings are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  
  // Run the app wrapped in a ProviderScope for Riverpod state management
  runApp(ProviderScope(child: MyApp()));
}

// MyApp is the root widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App', // Title of the application
      theme: ThemeData(
        primarySwatch: Colors.blue, // Theme color
      ),
      home: HomeScreen(), // Set HomeScreen as the initial screen of the app
    );
  }
}
