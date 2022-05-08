import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:popolsuoh/component/board_list_item.dart';
import 'package:popolsuoh/provider/login_provider.dart';
import 'package:popolsuoh/screen/board/board_write2.dart';
import 'package:popolsuoh/screen/main_screen.dart';
import 'package:provider/provider.dart';

class BoardList extends HookWidget {
  const BoardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginProvider _loginProvider = Provider.of<LoginProvider>(context);
    final _boardList = useState<List>([]);


    List<Widget> _boardListWidget(){
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String TodayResult = formatter.format(now);
      print(_boardList.value);
      print(_boardList.value.length);
      print(TodayResult);

      if (_boardList.value.length > 0) {
        return _boardList.value.map((item)=>
              (BoardListItem(boardName: item['BOARD_TITLE'], nick: item['NICKNAME'], boardDate: '04-03'))).toList();
      } else {
        return [SizedBox(
          height: MediaQuery.of(context).size.height - 160,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        )];
      }
    }



    Future getBoards() async{
      var dio = Dio();
      try {
        final result = await dio.get('http://${MainScreen.localhostPath}:4000/api/board/boardlist');
        print(result);
        _boardList.value = result as List;

      } catch (e) {
        print("Exception: $e");
      }
    }

    useEffect(() {

      getBoards();
    }, []);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('게시판 리스트', style: TextStyle(color: Colors.black),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BoardWrite2(loginProvider: _loginProvider),
          ));
          },
        child: const Icon(Icons.playlist_add),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
                children: _boardListWidget(),
              )
          ),
        ],
      ),
    );
  }
}
