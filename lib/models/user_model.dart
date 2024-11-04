import 'package:firebase_auth/firebase_auth.dart';

class UserModels {
  String id;
  String name;
  String email;

  UserModels({
    required this.id,
    required this.name,
    required this.email,
  });

  UserModels.fromJson(Map<String,dynamic> json) : 
  this(id : json['id'],name : json['name'],email : json['email'] 
  );

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'email': email
    };
}
