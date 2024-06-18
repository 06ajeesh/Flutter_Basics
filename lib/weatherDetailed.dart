import 'package:flutter/material.dart';

class WeatherDetailsPage extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherDetailsPage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final weather = weatherData['weather'][0];
    final main = weatherData['main'];
    final wind = weatherData['wind'];
    final sys = weatherData['sys'];
    final iconCode = weather['icon'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 5,
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '${weatherData['name']}, ${sys['country']}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: _loadImage(context, 'http://openweathermap.org/img/wn/$iconCode@2x.png'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error, color: Colors.red, size: 100);
                  } else {
                    return Image.network(
                      'http://openweathermap.org/img/wn/$iconCode@2x.png',
                      width: 100,
                      height: 100,
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
              Text(
                weather['description'].toString().toUpperCase(),
                style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildWeatherInfoCard(
                    icon: Icons.thermostat_outlined,
                    label: 'Temp',
                    value: '${(main['temp'] - 273.15).toStringAsFixed(1)} °C',
                  ),
                  _buildWeatherInfoCard(
                    icon: Icons.water_damage_outlined,
                    label: 'Humidity',
                    value: '${main['humidity']}%',
                  ),
                  _buildWeatherInfoCard(
                    icon: Icons.air_outlined,
                    label: 'Wind',
                    value: '${wind['speed']} m/s',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadImage(BuildContext context, String url) async {
    await precacheImage(NetworkImage(url), context);
  }

  Widget _buildWeatherInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.blue),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
