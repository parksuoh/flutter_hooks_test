import 'package:flutter/material.dart';

class BoardListItem extends StatelessWidget {
  final String boardName;
  final String nick;
  final String boardDate;
  const BoardListItem({Key? key, required this.boardName, required this.boardDate, required this.nick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10, top: 2, bottom: 2),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(boardName),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(nick),
                  Text(boardDate),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
