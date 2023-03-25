import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApi {
  static const String _apiKey = '2bd91d362af1ba70a21972534d20ecfb';

  static Future<List<Map<String, dynamic>>> getWeatherData(
      double latitude, double longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&cnt=7&appid=$_apiKey';
    final response = await http.get(Uri.parse(url)); // use url variable here
    final responseData = json.decode(response.body);

    if (responseData.containsKey('list') && responseData['list'] is List) {
      // Filter the list to get weather data for the next 7 days
      final weatherList = responseData['list'].where((data) {
        final date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
        return date.hour == 12; // Filter by noon to get daily weather data
      }).toList();

      // Extract the relevant weather data for each day
      final weatherData = weatherList.map((data) {
        final date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
        return {
          'date': date,
          'description': data['weather'][0]['description'],
          'icon': data['weather'][0]['icon'],
          'highTemp': data['main']['temp_max'],
          'lowTemp': data['main']['temp_min'],
          'humidity': data['main']['humidity'],
          'windSpeed': data['wind']['speed'],
          'sunrise': null,
          'sunset': null,
        };
      }).toList();

      return weatherData;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
