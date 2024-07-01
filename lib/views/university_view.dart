import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UniversityView extends StatefulWidget {
  const UniversityView({super.key});

  @override
  _UniversityViewState createState() => _UniversityViewState();
}

class _UniversityViewState extends State<UniversityView> {
  final _controller = TextEditingController();
  List<dynamic> _universities = [];
  bool _isLoading = false;
  int _currentPage = 0;
  static const int _pageSize = 10;

  void _fetchUniversities() async {
    final country = _controller.text.trim().toLowerCase();
    if (country.isEmpty) return;

    setState(() {
      _isLoading = true;
      _universities = []; // Clear previous results
    });

    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _universities = data;
        _isLoading = false;
        _currentPage = 0; // Reset to first page
      });
    } else {
      setState(() {
        _isLoading = false;
        _universities = [];
      });
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<dynamic> _getPaginatedData() {
    final start = _currentPage * _pageSize;
    final end = start + _pageSize;
    return _universities.sublist(start, end > _universities.length ? _universities.length : end);
  }

  void _nextPage() {
    if ((_currentPage + 1) * _pageSize < _universities.length) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades por País'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingrese un País en Inglés',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchUniversities,
              child: const Text('Buscar Universidades'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_universities.isNotEmpty)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _getPaginatedData().length,
                        itemBuilder: (context, index) {
                          final university = _getPaginatedData()[index];
                          return ListTile(
                            title: Text(university['name']),
                            subtitle: Text(university['web_pages'][0]),
                            onTap: () => _launchURL(university['web_pages'][0]),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _previousPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentPage == 0 ? Colors.grey : Colors.lightBlue,
                          ),
                          child: const Text('Anterior'),
                        ),
                        ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (_currentPage + 1) * _pageSize >= _universities.length ? Colors.grey : Colors.lightBlue,
                          ),
                          child: const Text('Siguiente'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            if (!_isLoading && _universities.isEmpty)
              const Text('No se encontraron universidades.'),
          ],
        ),
      ),
    );
  }
}
