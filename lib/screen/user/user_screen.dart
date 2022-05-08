import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:popolsuoh/component/login_btn.dart';
import 'package:popolsuoh/provider/login_provider.dart';
import 'package:popolsuoh/screen/login/login_screen.dart';
import 'package:provider/provider.dart';


class UserScreen extends StatelessWidget {

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginProvider _loginProvider = Provider.of<LoginProvider>(context);

    void _goLoginScreen() {
      Navigator.of(context).push<String>(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen())
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('유저', style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false,
      ),
      body: Column(
          children: [
            const SizedBox(height: 100,),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/default_user.jpeg'),
                  ),
                  const SizedBox(width: 40,),
                  Text(_loginProvider.nickname,),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            LoginBtn(btnName: '로그아웃', setFunc: () {
              _loginProvider.LogOut();
              _goLoginScreen();
            }),

          ]
      ),
    );
  }
}
