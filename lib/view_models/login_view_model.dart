import 'package:flutter/material.dart';
import 'package:positive_conversion_reframing/models/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  LoginViewModel({required this.userRepository});

  Future<bool> isSignIn() async {
    return await userRepository.isSignIn();
  }


}