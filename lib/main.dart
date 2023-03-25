import 'package:flutter/material.dart';
import 'package:happy_weather/models/weather_data.dart';
import 'package:happy_weather/services/weather_api.dart';

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
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _location = 'unknown';
  late List<WeatherData> _weatherList;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    weatherData = await WeatherApi.getWeatherData(latitude, longitude);
    setState(() {});
  }
  /*
  void getLocation() async {
    WeatherApi.getWeatherData().then((weatherList) {
      setState(() {
        _weatherList = weatherList;
        _location = weatherList[0].cityName;
      });
    });
  }
  */


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
              'Location: $_location',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _weatherList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  var weatherData = _weatherList[index];
                  return ListTile(
                    title: Text('${weatherData.tempMax}'),
                    // this is the correct version >> title: Text('${weatherData.date}, ${weatherData.tempMax}'),
                    subtitle: Text(weatherData.description),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
