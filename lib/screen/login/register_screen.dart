import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:popolsuoh/screen/login/login_screen.dart';
import 'package:popolsuoh/screen/main_screen.dart';

import '../../component/login_btn.dart';
import '../../component/login_text_field.dart';

class RegisterScreen extends HookWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final nicknameController = useTextEditingController(text: '');

    void _goLoginScreen() {
      Navigator.of(context).push<String>(
          MaterialPageRoute(builder: (BuildContext context) => const LoginScreen())
      );
    }

    Future _registerDio(String email, String pass, String nickname) async{
      var dio = Dio();

      if (emailController.text != '' && passwordController.text != '' && nicknameController.text != ''){
        try {
          final result = await dio.post(
              'http://${MainScreen.localhostPath}:4000/api/user/register',
              data: {'email': email, 'pass': pass, 'nickname': nickname}
          );

          if (result.data[0]['ERROR'] == 1) {
            print('이메일 이미있음');
            return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('이메일이 이미 존재합니다.'),
                  duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                    label: '확인', //버튼이름
                    onPressed: (){}, //버튼 눌렀을때.
                  ),
                )
            );;
          } else if (result.data[0]['ERROR'] == 2) {
            print('닉네임 이미있음');
            return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('닉네임이 이미 존재합니다.'),
                  duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                    label: '확인', //버튼이름
                    onPressed: (){}, //버튼 눌렀을때.
                  ),
                )
            );;
          } else {
            _goLoginScreen();
          }

        } catch (e) {
          print("Exception: $e");
        }
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('이메일 비밀번호 닉네임을 입력해주세요'),
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: '확인', //버튼이름
                onPressed: (){}, //버튼 눌렀을때.
              ),
            )
        );;
      }


    }



    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입', style: TextStyle(color: Colors.black),),
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
            LoginTextField(hintText: 'nickname', controller: nicknameController,),
            const SizedBox(height: 10,),
            Center(child: LoginBtn(btnName: '회원가입', setFunc: () {
              _registerDio(emailController.text, passwordController.text, nicknameController.text);}
            )
            )
          ],
        ),
      ),
    );
  }
}
