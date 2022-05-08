import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:popolsuoh/provider/chat_provider.dart';
import 'package:popolsuoh/screen/board/board_read.dart';
import 'package:popolsuoh/screen/user/user_screen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'board/board_list.dart';
import 'chat/chat_screen.dart';
import 'home/home_screen.dart';

class MainScreen extends HookWidget {
  const MainScreen({Key? key}) : super(key: key);
  // static const String localhostPath = "192.168.0.6";
  // static const String localhostPath = "192.168.214.239";
  // static const String localhostPath = "192.168.122.239";
  static const String localhostPath = "192.168.0.20";


  @override
  Widget build(BuildContext context) {
    final ChatProvider _chatProvider = Provider.of<ChatProvider>(context);
    final _selectedIndex = useState(0);


    useEffect(() {

      _chatProvider.connectSocket();
    }, []);


    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex.value,
        children: [
          HomeScreen(),
          // BoardRead(),
          BoardList(),
          ChatScreen(),
          const UserScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex.value,
        backgroundColor: Colors.grey[100],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: (index){
          _selectedIndex.value = index;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈",),
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: "게시판"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_fill), label: "체팅",),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.ellipsis), label: "유저",),
        ],
      ),
    );
  }
}
