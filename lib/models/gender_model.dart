class Gender {
  final String name;
  final String gender;
  final double probability;
  final int count;

  Gender({required this.name, required this.gender, required this.probability, required this.count});

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      name: json['name'],
      gender: json['gender'],
      probability: json['probability'],
      count: json['count'],
    );
  }
}
