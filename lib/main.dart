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
      Map<String, dynamic> responseData =
      await WeatherApi.getWeatherData(latitude, longitude);
      print(responseData);
      setState(() {
        _weather =
            responseData['weather'][0]['description'].toString().toUpperCase();
        _location = responseData['name'].toString();
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
  Widget _buildWeatherList(List<Map<String, dynamic>> weatherData) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weatherData.length,
            itemBuilder: (BuildContext context, int index) {
              final data = weatherData[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDateIndex = index;
                  });
                },
                child: Container(
                  width: 150,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: index == _selectedDateIndex
                        ? Colors.blue[100]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey[300],
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        DateFormat('EEEE').format(data['date']),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Image.network(
                        'https://openweathermap.org/img/w/${data['icon']}.png',
                        height: 50,
                        width: 50,
                      ),
                      Text('${data['highTemp']}° / ${data['lowTemp']}°'),
                      Text(data['description']),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 24,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final data =
              weatherData[_selectedDateIndex]['hourlyData'][index];
              return Container(
                width: 100,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey[300],
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat('h a').format(data['date']),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Image.network(
                      'https://openweathermap.org/img/w/${data['icon']}.png',
                      height: 50,
                      width: 50,
                    ),
                    Text('${data['temp']}°'),
                    Text(data['description']),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}
