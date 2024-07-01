import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class WordPressView extends StatefulWidget {
  const WordPressView({super.key});

  @override
  _WordPressViewState createState() => _WordPressViewState();
}

class _WordPressViewState extends State<WordPressView> {
  final _urlController = TextEditingController();
  List<dynamic> _articles = [];
  bool _isLoading = false;
  bool _isWordPress = false;

  void _fetchArticles() async {
    setState(() {
      _isLoading = true;
      _isWordPress = false;
      _articles = [];
    });

    String url = _urlController.text.trim();
    if (url.isEmpty) return;

    if (!url.startsWith('http')) {
      url = 'https://www.' + url;
    }

    try {
      final response = await http.get(Uri.parse('$url/wp-json/'));
      if (response.statusCode == 200) {
        setState(() {
          _isWordPress = true;
        });
        final articlesResponse = await http.get(Uri.parse('$url/wp-json/wp/v2/posts?per_page=3'));
        if (articlesResponse.statusCode == 200) {
          final data = json.decode(articlesResponse.body);
          setState(() {
            _articles = data;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WordPress News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Ingrese el dominio del sitio WordPress',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchArticles,
              child: const Text('Buscar Noticias'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading && _isWordPress)
              Expanded(
                child: ListView.builder(
                  itemCount: _articles.length,
                  itemBuilder: (context, index) {
                    final article = _articles[index];
                    return ListTile(
                      title: Text(article['title']['rendered']),
                      subtitle: Text(
                        article['excerpt']['rendered'].replaceAll(RegExp(r'<[^>]*>'), ''), // Remove HTML tags
                      ),
                      onTap: () => launch(article['link']),
                    );
                  },
                ),
              ),
            if (!_isLoading && !_isWordPress)
              const Text('La URL ingresada no corresponde a un sitio WordPress.'),
          ],
        ),
      ),
    );
  }
}
