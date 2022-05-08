import 'package:flutter/material.dart';

class MyChat extends StatelessWidget {
  final String text;
  final String time;
  const MyChat({Key? key, required this.text, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(time, style: const TextStyle(fontSize: 12),),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 20, maxWidth: MediaQuery.of(context).size.width * 0.5),
                child: Text(text),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}