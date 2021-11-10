import 'package:flutter/material.dart';
import 'package:positive_conversion_reframing/data_class/send_data.dart';
import 'package:positive_conversion_reframing/models/repositories/user_repository.dart';

class QuestionnaireViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  QuestionnaireViewModel({required this.userRepository});
  bool isSuccess = false;

  Future<void> sendData(SendData sendData) async {
    isSuccess = false;
    await userRepository.sendData(sendData);

    isSuccess = true;

  }



}