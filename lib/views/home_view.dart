import 'package:flutter/material.dart';
import 'gender_view.dart';
import 'age_view.dart';
import 'university_view.dart';
import 'weather_view.dart';
import 'wordpress_view.dart';
import 'about_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget _selectedView = const Center(child: Text('Mi Super App'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarea 6 Super App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Features', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Peticiond e Genero '),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedView = const GenderView();
                });
              },
            ),
            ListTile(
              title: const Text('Peticion de Edad'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedView = const AgeView();
                });
              },
            ),
            ListTile(
              title: const Text('Universidades'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedView = const UniversityView();
                });
              },
            ),
            ListTile(
              title: const Text('El Tiempo en DR'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedView = const WeatherView();
                });
              },
            ),
            ListTile(
              title: const Text('Noticias de  WordPress '),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedView = const WordPressView();
                });
              },
            ),
            ListTile(
              title: const Text('Sobre Mi'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedView = const AboutView();
                });
              },
            ),
          ],
        ),
      ),
      body: _selectedView,
    );
  }
}
