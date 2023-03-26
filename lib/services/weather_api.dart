import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:happy_weather/models/weather_data.dart';

class WeatherApi {
  static const _apiKey = '2bd91d362af1ba70a21972534d20ecfb';

  static Future<List<WeatherData>> getWeatherData(double lat,double lon) async {
    print('Latitude: $lat, Longitude: $lon');

    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=$_apiKey';

    final response = await http.get(Uri.parse(url));



    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // print the response
      print(jsonData);
      final weatherDataList = <WeatherData>[];
      // print the array
      print(weatherDataList);
      for (final item in jsonData['list']) {
        print('FFFMMMLLL');
        print('item: $item');
        final weatherData = WeatherData.fromJson(item);
        weatherDataList.add(weatherData);
      }
      print('Weather data received successfully');
      return weatherDataList;

    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
