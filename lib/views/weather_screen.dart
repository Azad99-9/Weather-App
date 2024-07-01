import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers/weather_provider.dart';

// WeatherScreen is a ConsumerWidget to listen to Riverpod providers
class WeatherScreen extends ConsumerWidget {
  final String cityName;

  WeatherScreen({required this.cityName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the weatherProvider to get the weather data for the provided cityName
    final weatherAsyncValue = ref.watch(weatherProvider(cityName));

    return Scaffold(
      appBar: AppBar(
        title: const  Text('Weather Details'), // Title of the app bar
        actions: [
          // Refresh button to reload the weather data
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => ref.refresh(weatherProvider(cityName)),
          ),
        ],
      ),
      body: weatherAsyncValue.when(
        // When data is successfully fetched
        data: (weather) {
          // URL for the weather icon
          final weatherIconUrl = 'https://openweathermap.org/img/wn/${weather.icon}@2x.png';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'City: ${weather.cityName}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Image.network(weatherIconUrl), // Display weather icon
                    SizedBox(width: 16),
                    Text(
                      '${weather.temperature}°C',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Weather: ${weather.description}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 8),
                Text(
                  'Humidity: ${weather.humidity}%',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 8),
                Text(
                  'Wind Speed: ${weather.windSpeed} m/s',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          );
        },
        // While data is being loaded
        loading: () => Center(child: CircularProgressIndicator()),
        // When an error occurs
        error: (err, stack) => CityNotFoundWidget(cityName: cityName),
      ),
    );
  }
}

// Widget to display when the city is not found
class CityNotFoundWidget extends StatelessWidget {
  final String cityName;

  CityNotFoundWidget({required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off,
              color: Colors.red,
              size: 100,
            ),
            SizedBox(height: 16),
            Text(
              'City Not Found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'The city "$cityName" could not be found. Please check the spelling or try searching for another city.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
              child: Text('Back to Search'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
