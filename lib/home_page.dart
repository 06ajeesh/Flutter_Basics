import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:weather_app_task/DetailPage.dart';
import 'package:weather_app_task/utilities.dart';
import 'package:weather_app_task/weatherDetailed.dart';

const openWeatherMapApiKey =
    'ADD API KEY'; 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String _city = '';
  String _errorMessage = '';
  bool _isLoading = false;
  bool _isFetchingCurrentLocationWeather = true;
  Map<String, dynamic>? _currentWeatherData;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocationWeather();
  }

  Future<void> _fetchCurrentLocationWeather() async {
    Location location = Location();
    LocationData _locationData;

    _locationData = await location.getLocation();
    if (_locationData != null) {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${_locationData.latitude}&lon=${_locationData.longitude}&appid=$openWeatherMapApiKey',
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          _currentWeatherData = jsonDecode(response.body);
          _isFetchingCurrentLocationWeather = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Error fetching weather data.';
          _isFetchingCurrentLocationWeather = false;
        });
      }
    }
  }

  Future<void> _fetchWeather(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final response = await http.get(
      Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$_city&limit=5&appid=$openWeatherMapApiKey',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      if (data.isEmpty) {
        setState(() {
          _errorMessage = 'Location not found.';
          _isLoading = false;
        });
        return;
      }

      final location = data[0];
      final lat = location['lat'];
      final lon = location['lon'];

      final weatherResponse = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$openWeatherMapApiKey',
        ),
      );

      if (weatherResponse.statusCode == 200) {
        final weatherData = jsonDecode(weatherResponse.body);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailPage(weatherData: weatherData)),
        ).then((_) {
          setState(() {
            _isLoading = false;
            _controller.clear();
            _city = '';
          });
        });
      } else {
        setState(() {
          _errorMessage = 'Error fetching weather data.';
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Error fetching location data.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Weather App',
            style: tStyle.copyWith(
              fontSize: 22,
              letterSpacing: 0.8,
            )),
        centerTitle: true,
      ),
      body: Center(
        child: _isFetchingCurrentLocationWeather
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Icon(Icons.person,size: 40,),),
                      ],
                    ),
                    if (_currentWeatherData != null)
                      WeatherDetailsPage(weatherData: _currentWeatherData!),
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Enter city name',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor:
                              Colors.white, 
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                        ),
                        style: const TextStyle(
                            color: Colors.black), 
                        onChanged: (value) => setState(() => _city = value),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed:
                          _isLoading ? null : () => _fetchWeather(context),
                      child: Text(_isLoading ? 'Loading...' : 'Fetch Weather'),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      _errorMessage.isNotEmpty ? _errorMessage : '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
