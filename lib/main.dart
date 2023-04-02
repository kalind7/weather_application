import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/export_provider.dart';
import 'screens/export_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => WeatherProvider()..fetchWeatherDatas()),
        ChangeNotifierProvider(
            create: (_) => LocationProvider()..getCurrentLocation())
      ],
      child: MaterialApp(
        title: 'Weather Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
