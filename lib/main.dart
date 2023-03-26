import 'package:flutter/material.dart';
import 'package:happy_weather/models/weather_data.dart';
import 'package:happy_weather/services/location.dart';
import 'package:happy_weather/services/weather_api.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Weather',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  late List<WeatherData> _weatherList = [];

  @override
  void initState() {
    super.initState();
    getLocationWeather();
  }

  void getLocationWeather() async {
    // Get the current location of the user
    Location location = Location();
    await location.getCurrentLocation();

    // Get the weather data for the next seven days in the user's location
    List<WeatherData> weatherData = await WeatherApi.getWeatherData(
      location.latitude!,
      location.longitude!,
    );

    setState(() {
      _weatherList = weatherData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_weatherList == null) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HappyB ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.orange,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.yellow[700],
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'HappyWeather',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 70.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              flexibleSpace: Container (
                decoration: BoxDecoration (
                  image: DecorationImage (
                    image: AssetImage('assets/images/cloudsbg.jpg'),
                    fit: BoxFit.cover,
                  )
                )
              )
            ],
          ),
          backgroundColor: Colors.yellow[700]!,
        ),
        body: Center(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _weatherList.length,
            itemBuilder: (BuildContext context, int index) {
              var weatherData = _weatherList[index];
              return SizedBox(
                width: 150,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('h a, d MMMM')
                            .format(_weatherList[index].dateTime),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${weatherData.tempMax}°C',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${weatherData.description}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
