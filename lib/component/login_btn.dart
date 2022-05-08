import 'package:flutter/material.dart';

class LoginBtn extends StatelessWidget {
  final String btnName;
  final Function()? setFunc;
  const LoginBtn({Key? key, required this.btnName, required this.setFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: setFunc,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),

            ),
            child: Center(child: Text(btnName, style: const TextStyle(color: Colors.black54),))
        )
    );
  }
}
