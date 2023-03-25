import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApi {
  static const String _apiKey = '2bd91d362af1ba70a21972534d20ecfb';

  static Future<Map<String, dynamic>> getWeatherData(
      double latitude, double longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&cnt=7&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to get weather data');
    }
  }
}
