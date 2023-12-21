import 'package:flutter/material.dart';
import 'package:weather_app_error_handling/models/weather_model.dart';
import 'package:weather_app_error_handling/utils/weather_manager/weather_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weather;

  bool get isApiLoaded => weather != null;

  @override
  void initState() {
    WeatherManager.fetchCurrentWeather(20.593683, 78.962883).then((result) {
      result.fold((l) {}, (r) {
        weather = r;
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isApiLoaded
            ? DefaultTextStyle(
                style: Theme.of(context).textTheme.displaySmall!,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Time: ${weather?.time.split('T').join(" ") ?? '--'}"),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Temperature: ${weather?.temperature2m ?? '--'}"),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Wind speed: ${weather?.windSpeed10m ?? '--'}"),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
