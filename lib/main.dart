import 'package:flutter/material.dart';
import 'package:trea6_super_app/views/about_view.dart';
import 'package:trea6_super_app/views/age_view.dart';
import 'package:trea6_super_app/views/gender_view.dart';
import 'package:trea6_super_app/views/home_view.dart';
import 'package:trea6_super_app/views/university_view.dart';
import 'package:trea6_super_app/views/weather_view.dart';
import 'package:trea6_super_app/views/wordpress_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tarea 6 Super App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
      routes: {
        '/gender': (context) => GenderView(),
        '/age': (context) => const AgeView(),
        '/universities': (context) => const UniversityView(),
        '/weather': (context) => const WeatherView(),
        '/news': (context) => const WordPressView(),
        '/about': (context) => AboutView(),
      },
    );
  }
}
