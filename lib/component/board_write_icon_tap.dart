import 'package:flutter/material.dart';

class BoardWriteIconTap extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function()? setFunc;
  const BoardWriteIconTap({Key? key, required this.name, required this.icon, required this.setFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: setFunc,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5,),
          Text(name),
        ],
      ),
    );
  }
}
