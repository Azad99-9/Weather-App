class Weather {
  /// The name of the city for which the weather data is retrieved.
  final String cityName;

  /// The current temperature in Kelvin (can be converted to other units).
  final double temperature;

  /// A textual description of the current weather conditions.
  final String description;

  /// An identifier for the weather icon (used for displaying an appropriate image).
  final String icon;

  /// The humidity level as a percentage.
  final int humidity;

  /// The wind speed in meters per second.
  final double windSpeed;

  /// Constructor for the Weather class.
  ///
  /// Takes all the properties as required arguments.
  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  /// Factory constructor to create a Weather object from a JSON response.
  ///
  /// This constructor parses a `Map<String, dynamic>` representing the JSON data
  /// from the weather API and extracts relevant weather information.
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
