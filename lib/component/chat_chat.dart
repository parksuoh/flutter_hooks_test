import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  final String nickname;
  final String text;
  final String time;
  const Chat({Key? key, required this.nickname, required this.text, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/default_user.jpeg'),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nickname),
              Container(
                constraints: BoxConstraints(minHeight: 20, maxWidth: MediaQuery.of(context).size.width * 0.5),
                child: Text(text),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.grey,
                ),
              )
            ],
          ),
          const SizedBox(width: 5),
          Text(time, style: TextStyle(fontSize: 12),),
        ],
      ),
    );
  }
}