import 'dart:io';
import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class TestScreen extends HookWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    final _pickedImgs = useState([]);

    Future<void> _pickImg() async {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null) {
        _pickedImgs.value = images;
      }
    }

    List<Widget> _boxContents = [
      IconButton(
        onPressed: () {
          _pickImg();
        },
        icon: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            shape: BoxShape.circle
          ),
          child: Icon(
            CupertinoIcons.camera,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      Container(),
      Container(),
      _pickedImgs.value.length <= 4
        ? Container()
          : FittedBox(
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            shape: BoxShape.circle
          ),
          child: Text(
            '+${(_pickedImgs.value.length - 4).toString()}',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      )
    ];



    return Scaffold(
      appBar: AppBar(
        title: const Text('테스트', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 500,
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: List.generate(
                      4,
                          (index) => DottedBorder(
                            child: Container(
                              child: Center(child: _boxContents[index],),
                              decoration: index <= _pickedImgs.value.length -1
                                ? BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(_pickedImgs.value[index].path))
                                )
                              )
                                : null,
                            ),
                            color: Colors.grey,
                            dashPattern: const [5, 3],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10)
                          )
                  ).toList(),
                ),
              ),

            ],
          ),
      ),
    );
  }
}
