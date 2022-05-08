import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BoardRead extends HookWidget {
  const BoardRead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final comtController = useTextEditingController(text: '');


    return Scaffold(
      appBar: AppBar(
        title: const Text('게시판 글보기', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10, top: 2, bottom: 2),
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    child: const Text('글제목111'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    child: const Text('04-03'),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10, top: 2, bottom: 2),
              width: MediaQuery.of(context).size.width,
              height: 400,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(
                child: Text('글내용임'),
              ),
            ),

            // Container(
            //   margin: const EdgeInsets.only(right: 10, left: 10, top: 2, bottom: 2),
            //   padding: const EdgeInsets.all(5),
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //       border: Border.all(
            //         color: Colors.grey,
            //         width: 1,
            //       ),
            //       borderRadius: BorderRadius.circular(10)
            //   ),
            //   child: Expanded(
            //     child: Column(
            //       children: [
            //         Container(
            //           margin: const EdgeInsets.only(right: 10, left: 10, top: 2, bottom: 2),
            //           padding: const EdgeInsets.all(5),
            //           width: MediaQuery.of(context).size.width - 30,
            //           decoration: BoxDecoration(
            //               border: Border.all(
            //                 color: Colors.grey,
            //                 width: 1,
            //               ),
            //               borderRadius: BorderRadius.circular(10)
            //           ),
            //           child: Column(
            //             children: [
            //               Row(
            //                 children: const [
            //                   Text('댓글'),
            //                   Text('내용내용'),
            //                   Text('04-03'),
            //                 ],
            //               ),
            //               Row(
            //                 children: const [
            //                   Text('대댓글'),
            //                   Text('내용내용'),
            //                   Text('04-03'),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //
            //         Row(
            //           children: [
            //             Expanded(
            //                 child: TextField(
            //                   controller: comtController,
            //                   maxLines: 1,
            //                   style: const TextStyle(fontSize: 14),
            //                   decoration: const InputDecoration(
            //                     hintText: '댓글을 입력해주세요',
            //                   ),
            //                 )
            //             ),
            //             IconButton(
            //               padding: const EdgeInsets.symmetric(horizontal: 15),
            //               icon: const Icon(Icons.send),
            //               iconSize: 25,
            //               onPressed: () {}
            //             ),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}
