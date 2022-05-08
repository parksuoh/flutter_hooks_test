import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popolsuoh/component/board_write_title_field.dart';
import 'package:popolsuoh/component/login_btn.dart';
import 'package:image_picker/image_picker.dart';

import '../../component/board_write_icon_tap.dart';
import '../../provider/login_provider.dart';

class BoardWrite2 extends StatefulWidget {
  final LoginProvider loginProvider;
  const BoardWrite2({Key? key, required this.loginProvider}) : super(key: key);

  @override
  State<BoardWrite2> createState() => _BoardWrite2State();
}

class _BoardWrite2State extends State<BoardWrite2> {
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  TextEditingController boardnameController = TextEditingController(text:  '');
  List _context = [''];
  List _contextText = [TextEditingController(text:  '')];
  int _contextSel = 0;
  List _photos = [null];
  List _photosPathList = [];


  Future<void> _pickImg() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _photos.insert(_contextSel, image);
        _contextText.insert(_contextSel+1, TextEditingController(text:  ''));
        _context.insert(_contextSel+1, '');
      });
    }
  }

  List<Widget> _boardWriteCont(){
    return _contextText.asMap().entries.map((entry) {
      int idx = entry.key;
      // String val = entry.value;

      return Column(
        children: [
          RawKeyboardListener(
            focusNode: _focusNode,
            onKey: (event) {
              if(_contextSel != 0 && _contextText[_contextSel].text == '') {
                if (event.logicalKey == LogicalKeyboardKey.backspace) {
                  setState(() {
                    _contextText.removeAt(_contextSel);
                    _context.removeAt(_contextSel);
                    _photos.removeAt(_contextSel-1);
                    if (_contextSel == _contextText.length) {
                      _contextSel --;
                    }
                  });

                }

              }

            },
            child: TextFormField(
              controller: _contextText[idx],
              onChanged: (text) {
                _context[idx] = text;
              },
              onTap: () {
                _contextSel = idx;
              },
            ),
          ),

          Container(
              width: _photos[idx] == null ? 0 : 100,
              height: _photos[idx] == null ? 0 : 100,
              decoration: _photos[idx] == null
                  ? null
                  : BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(File(_photos[idx].path))
                  )
              )
          ),
        ],
      );}).toList();
  }

  void onConfirm() {

    _photos.forEach((item) {
      if(item != null) {
        _photosPathList.add(File(item.path));
      }
    });

    print(_photosPathList);

    // _photosPathList.forEach((item) {
    //ß
    // });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시판 글쓰기', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoardWriteTitleField(controller: boardnameController),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                children: [
                  BoardWriteIconTap(
                    name: '사진',
                    icon: CupertinoIcons.camera,
                    setFunc: () { _pickImg();},
                  ),
                ],
              ),
            ),
            Column(
              children: _boardWriteCont(),
            ),
            LoginBtn(
                btnName: '글 등록하기',
                setFunc: () {
                  onConfirm();
                }
            ),
          ],
        ),
      ),
    );
  }
}
