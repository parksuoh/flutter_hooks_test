import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:popolsuoh/component/board_write_title_field.dart';
import 'package:popolsuoh/component/login_btn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../component/board_write_icon_tap.dart';
import '../../provider/login_provider.dart';

class BoardWrite extends HookWidget {
  List<dynamic> photoList = [null];
  BoardWrite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginProvider _loginProvider = Provider.of<LoginProvider>(context);
    FocusNode _focusNode = FocusNode();
    final ImagePicker _picker = ImagePicker();
    final boardnameController = useTextEditingController(text: '');
    // final _context = useState<List>(['']);
    final _contextText = useState<List<TextEditingController>>([useTextEditingController(text: '')]);
    final _contextSel = useState(0);
    final _photos = useState<List<dynamic>>(photoList);
    final _testparam = useState(0);


    Future<void> _pickImg() async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _photos.value.insert(_contextSel.value, image);
        // _context.value.insert(_contextSel.value+1, '');
        _contextText.value.insert(_contextSel.value+1, useTextEditingController(text: ''));
        _testparam.value ++;
      }
    }

    List<Widget> _boardWriteCont(){
      return _contextText.value.asMap().entries.map((entry) {
        int idx = entry.key;
        // String val = entry.value;

        return Column(
          children: [
            RawKeyboardListener(
              focusNode: _focusNode,
              // onKey: (event) {
              //   if(_contextSel.value != 0 && _context.value[_contextSel.value] == '') {
              //     if (event.logicalKey == LogicalKeyboardKey.backspace) {
              //       _context.value.removeAt(_contextSel.value);
              //       _photos.value.removeAt(_contextSel.value-1);
              //       if (_contextSel.value == _context.value.length) {
              //         _contextSel.value --;
              //       }
              //       _testparam.value --;
              //
              //     }
              //
              //   }
              //
              // },
              child: TextFormField(
                // key: Key(idx.toString()),
                // initialValue: val,
                controller: _contextText.value[idx],
                onTap: () {
                  _contextSel.value = idx;
                  // print(_context.value);
                },
                // onChanged: (text) {
                //   _context.value[_contextSel.value] = text;
                // },
              ),
            ),

            Container(
                width: _photos.value[idx] == null ? 0 : 100,
                height: _photos.value[idx] == null ? 0 : 100,
                decoration: _photos.value[idx] == null
                    ? null
                    : BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(_photos.value[idx].path))
                    )
                )
            ),
          ],
        );}).toList();
    }

    void onConfirm() {
      print('BOARD_TITLE : ${boardnameController.text}');
      print('BOARD_CONT : ');
      print('UID: ${_loginProvider.UID}');

      boardnameController.text = '';
      // _context.value = [''];
      _contextSel.value = 0;
      _photos.value = [null];
    }


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
