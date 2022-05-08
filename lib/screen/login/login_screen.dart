import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:popolsuoh/screen/login/register_screen.dart';
import 'package:popolsuoh/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../../component/login_btn.dart';
import '../../component/login_text_field.dart';
import '../../provider/login_provider.dart';
import '../main_screen.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');

    void _goRegiScreen() {
      Navigator.of(context).push<String>(
          MaterialPageRoute(builder: (BuildContext context) => RegisterScreen())
      );
    }

    void _goMainScreen() {
      Navigator.of(context).push<String>(
          MaterialPageRoute(builder: (BuildContext context) => MainScreen())
      );
    }

    Future _loginDio(String email, String pass) async{
      var dio = Dio();

      try {
        final result = await dio.post(
            'http://${MainScreen.localhostPath}:4000/api/user/login',
            data: {'email': email, 'pass': pass}
        );

        if (result.data[0]['ERROR'] == 1) {
          print('이메일 틀렸음');
          return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('이메일이 존재하지 않습니다'),
                duration: const Duration(seconds: 5),
                action: SnackBarAction(
                  label: '확인', //버튼이름
                  onPressed: (){}, //버튼 눌렀을때.
                ),
              )
          );;
        } else if (result.data[0]['ERROR'] == 2) {
          print('비밀번호 틀렸음');
          return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('비밀번호가 틀렸습니다'),
                duration: const Duration(seconds: 5),
                action: SnackBarAction(
                  label: '확인', //버튼이름
                  onPressed: (){}, //버튼 눌렀을때.
                ),
              )
          );;
        } else {
          loginProvider.ProLoginDio(emailController.text, passwordController.text);
          _goMainScreen();
        }

      } catch (e) {
        print("Exception: $e");
      }

    }




    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15,),
            SizedBox(
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: const Image(
                  image: AssetImage(
                      'assets/images/default_user.jpeg'),
                ),
              ),
            ),
            LoginTextField(hintText: 'Email', controller: emailController,),
            LoginTextField(hintText: 'Password', controller: passwordController, obscure: true,),
            const SizedBox(height: 5,),
            LoginBtn(btnName: '로그인', setFunc: () {_loginDio(emailController.text, passwordController.text);}),
            const SizedBox(height: 10,),
            LoginBtn(btnName: '회원가입 하러가기', setFunc: () {_goRegiScreen();}),
          ],
        ),
      ),
    );
  }
}
