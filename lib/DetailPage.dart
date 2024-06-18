import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app_task/utilities.dart';
import 'package:weather_app_task/weatherDetailed.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const DetailPage({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Details',
          style: tStyle.copyWith(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            WeatherDetailsPage(weatherData: weatherData),
            SizedBox(
              width: size.width * 0.85,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: weatherData.entries.map((entry) {
                  String key = entry.key;
                  dynamic value = entry.value;

                  List<Widget> subtitleWidgets1 = [];
                  List<Widget> subtitleWidgets2 = [];

                  if (value is String) {
                    subtitleWidgets1.add(Text(value));
                  } else if (value is List) {
                    for (var item in value) {
                      if (item is Map) {
                        item.forEach((subKey, subValue) {
                          subtitleWidgets1.add(Text(
                              '$subKey:',
                              style: const TextStyle(fontWeight: FontWeight.bold)));
                          subtitleWidgets2.add(Text(subValue.toString()));
                        });
                      } else {
                        subtitleWidgets1.add(Text(item.toString()));
                      }
                    }
                  } else if (value is Map) {
                    value.forEach((subKey, subValue) {
                      subtitleWidgets1.add(Text(
                        '$subKey:',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ));
                      subtitleWidgets2.add(Text(subValue.toString()));
                    });
                  }

                  int maxLength = subtitleWidgets1.length > subtitleWidgets2.length
                      ? subtitleWidgets1.length
                      : subtitleWidgets2.length;

                  while (subtitleWidgets1.length < maxLength) {
                    subtitleWidgets1.add(Text(''));
                  }
                  while (subtitleWidgets2.length < maxLength) {
                    subtitleWidgets2.add(Text(''));
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(maxLength, (index) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(size.width*0.1, 0, 0, 0),
                              width: size.width*0.8,
                              height: size.height*0.1,
                              decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black)),
                              child: ListTile(
                                title: Text(
                                  key,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: subtitleWidgets1[index],
                                      ),
                                    ),
                                    Expanded(
                                      child: subtitleWidgets2[index],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
