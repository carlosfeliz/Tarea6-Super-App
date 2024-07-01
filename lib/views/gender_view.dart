import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenderView extends StatefulWidget {
  const GenderView({super.key});

  @override
  _GenderViewState createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  final _controller = TextEditingController();
  String _gender = '';
  bool _isLoading = false;

  void _predictGender() async {
    final name = _controller.text;
    if (name.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    final data = json.decode(response.body);

    setState(() {
      _isLoading = false;
      _gender = data['gender'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina el Genero '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingresa un Nombre',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictGender,
              child: const Text('Ver Genero ?'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_gender.isNotEmpty)
              Container(
                width: double.infinity,
                height: 100,
                color: _gender == 'male' ? Colors.blue : Colors.pink,
                child: Center(
                  child: Text(
                    'Gender: $_gender',
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
