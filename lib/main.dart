import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'weather_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Happy Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _weather = 'unknown';
  String _location = 'unknown';

  void _getWeatherData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;
      List<dynamic> responseData =
      await WeatherApi.getWeatherData(latitude, longitude);
      print(responseData);
      print('what the fuck');
      setState(() {
        _weather = 'hello';
            // responseData['weather'][0]['description'].toString().toUpperCase();
        _location = 'world';
            // responseData['name'].toString();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_weather',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 30),
            Text(
              'Location: $_location',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
