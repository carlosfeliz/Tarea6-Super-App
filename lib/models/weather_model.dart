class Weather {
  final String description;

  Weather({required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
    );
  }
}
