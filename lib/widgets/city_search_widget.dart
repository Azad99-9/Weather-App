import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_app/providers/weather_provider.dart';

// CitySearchWidget is a ConsumerWidget to use Riverpod state management
class CitySearchWidget extends ConsumerWidget {
  final TextEditingController controller;

  // Constructor to initialize the text controller
  CitySearchWidget({required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the WeatherService instance from the weatherServiceProvider
    final weatherService = ref.read(weatherServiceProvider);

    return TypeAheadField<String>(
      // Callback to get suggestions based on the input pattern
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          return [];
        }
        // Fetch city suggestions from the WeatherService
        return await weatherService.getCitySuggestions(pattern);
      },
      // Builder to create each suggestion item
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      // Action to perform when a suggestion is selected
      onSelected: (suggestion) {
        controller.text = suggestion; // Update the text controller with the selected suggestion
      },
      // Connect the TypeAheadField with the provided text controller
      controller: controller,
      // Widget to display when no suggestions are found
      emptyBuilder: (context) {
        return const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'No cities found.',
            style: TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }
}
