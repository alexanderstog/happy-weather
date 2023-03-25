class WeatherData {
  final String cityName;
  final String description;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;

  WeatherData({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    return WeatherData(
      cityName: json['name'],
      description: weather['description'],
      temperature: main['temp'].toDouble(),
      feelsLike: main['feels_like'].toDouble(),
      tempMin: main['temp_min'].toDouble(),
      tempMax: main['temp_max'].toDouble(),
      humidity: main['humidity'],
      pressure: main['pressure'],
    );
  }
}
