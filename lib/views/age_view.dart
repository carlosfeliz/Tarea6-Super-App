import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgeView extends StatefulWidget {
  const AgeView({super.key});

  @override
  _AgeViewState createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  final _controller = TextEditingController();
  int? _age;
  bool _isLoading = false;
  String _ageCategory = '';

  void _predictAge() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    setState(() {
      _isLoading = true;
      _age = null; // Clear previous age
      _ageCategory = ''; // Clear previous category
    });

    try {
      final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _age = data['age'];
          _ageCategory = _getAgeCategory();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _age = null;
          _ageCategory = 'Desconocido';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _age = null;
        _ageCategory = 'Desconocido';
      });
    }
  }

  String _getAgeCategory() {
    if (_age == null) {
      return 'Desconocido';
    } else if (_age! < 18) {
      return 'Joven';
    } else if (_age! < 60) {
      return 'Adulto';
    } else {
      return 'Anciano';
    }
  }

  String _getImageUrl(String category) {
    switch (category) {
      case 'Joven':
        return 'https://media.istockphoto.com/id/1351047032/es/foto/retrato-de-una-mujer-adulta-joven-sobre-un-fondo-blanco.jpg?s=612x612&w=0&k=20&c=GOWRptBobnf-JsvhOsK4Sx4M2SEh-LJO9p8KU12EN6g=';
      case 'Adulto':
        return 'https://img.freepik.com/foto-gratis/hombre-adulto-atractivo-cruzar-brazos-sonriendo_176420-18744.jpg';
      case 'Anciano':
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTayI49XGFtGwxxcFPXdbz8zI0h9DqMnMA2BQ&s';
      default:
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1YdvvmcCE8FiDUIMcy6uIRyI4mDbxZwmwdA&s';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predicción de Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingrese un nombre',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictAge,
              child: const Text('Predecir Edad'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_age != null && !_isLoading)
              Column(
                children: [
                  Text(
                    'Edad: $_age',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Categoría: $_ageCategory',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    _getImageUrl(_ageCategory),
                    height: 300,
                    width: 300,
                  ),
                ],
              ),
            if (_age == null && !_isLoading && _ageCategory == 'Desconocido')
              Column(
                children: [
                  const Text(
                    'No se pudo predecir la edad.',
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1YdvvmcCE8FiDUIMcy6uIRyI4mDbxZwmwdA&s',
                    height: 300,
                    width: 300,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
