class Age {
  final String name;
  final int age;
  final int count;

  Age({required this.name, required this.age, required this.count});

  factory Age.fromJson(Map<String, dynamic> json) {
    return Age(
      name: json['name'],
      age: json['age'],
      count: json['count'],
    );
  }
}
