import 'package:flutter/cupertino.dart';

class UserModle {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  UserModle({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.phone,
    @required this.password,
  });
}
