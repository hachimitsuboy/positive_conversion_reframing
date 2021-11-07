import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:positive_conversion_reframing/view/common/components/custom_button.dart';
import 'package:positive_conversion_reframing/view/home_screen.dart';
import 'package:positive_conversion_reframing/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ログイン画面"),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) {
            return model.isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Text("ポジティブ変換アプリにようこそ"),
                      SizedBox(
                        height: 150,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomButton(
                            label: 'サインイン',
                            onPressed: () => login(context),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  login(BuildContext context) async {
    final loginViewModel = context.read<LoginViewModel>();
    await loginViewModel.signIn();

    if (!loginViewModel.isSuccessful) {
      //ログインが上手くいかなかった場合
      Fluttertoast.showToast(msg: "ログインに失敗しました");
      return;
    }
    _openHomeScreen(context);
  }

  void _openHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );
  }
}
