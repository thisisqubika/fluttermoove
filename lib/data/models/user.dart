import 'dart:convert';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final int id;

  User(this.firstName, this.lastName, this.email, this.id);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json['first_name'], json['last_name'], json['email'], json['id']);
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'id': id,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['first_name'] ?? '',
      map['last_name'] ?? '',
      map['id'] ?? '',
      map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName,  email: $email, id: $id)';
  }
}
