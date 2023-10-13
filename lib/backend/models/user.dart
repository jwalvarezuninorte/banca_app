class User {
  final int? id;
  final String name;
  final String email;
  final String identification;
  final String password;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.identification,
    required this.password,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'identification': identification,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, Object?> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      identification: map['identification'] as String,
      password: map['password'] as String,
    );
  }
}
