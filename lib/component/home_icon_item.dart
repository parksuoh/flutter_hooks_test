import 'package:flutter/material.dart';

class HomeIconItem extends StatelessWidget {
  final String iconText;
  final IconData icon;
  const HomeIconItem({Key? key, required this.iconText, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 23,),
        Text(iconText, style: TextStyle(fontSize: 12),),
      ],
    );
  }
}
