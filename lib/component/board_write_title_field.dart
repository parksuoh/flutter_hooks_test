import 'package:flutter/material.dart';

class BoardWriteTitleField extends StatelessWidget {
  final TextEditingController controller;
  const BoardWriteTitleField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: '제목을 입력해주세요'
            ),
          ),
        ),
      ),
    );
  }
}
