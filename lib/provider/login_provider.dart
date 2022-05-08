import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../screen/main_screen.dart';

class LoginProvider with ChangeNotifier {
  late String? _UID;
  late String? _email;
  late String? _pass;
  late String _nickname= '';

  String? get UID => _UID;
  String get nickname => _nickname;

  Future ProLoginDio(String email, String pass) async{
    var dio = Dio();
    try {
      final result = await dio.post(
          'http://${MainScreen.localhostPath}:4000/api/user/login',
          data: {'email': email, 'pass': pass}
      );
        _UID = result.data[0]['UID'].toString();
        _email = result.data[0]['EMAIL'];
        _pass = result.data[0]['PASS'];
        _nickname = result.data[0]['NICKNAME'];
    } catch (e) {
      print("Exception: $e");
    }

    notifyListeners();
  }

  void LogOut() {
    _UID = null;
    _email = null;
    _pass = null;
    _nickname = '';

    notifyListeners();
  }




}