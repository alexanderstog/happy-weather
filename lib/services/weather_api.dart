
import 'package:http/http.dart' as http;
import 'dart:convert';


class WeatherApi {
  static const String _apiKey = '2bd91d362af1ba70a21972534d20ecfb';

  static Future<List<Map<String, dynamic>>> getWeatherData(
      double latitude, double longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final weatherDataList = jsonResponse['list'] as List;
      final weatherData =
      weatherDataList.map((data) => data as Map<String, dynamic>).toList();
      return weatherData;
    } else {
      throw Exception('Failed to load weather data');
    }

  }
}
