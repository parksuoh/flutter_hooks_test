import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:popolsuoh/provider/chat_provider.dart';
import 'package:popolsuoh/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../../component/chat_chat.dart';
import '../../component/chat_mychat.dart';

class ChatScreen extends HookWidget {
  const ChatScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final ChatProvider _chatProvider = Provider.of<ChatProvider>(context);
    final LoginProvider _loginProvider = Provider.of<LoginProvider>(context);

    final _messages = useState([]);
    final _msgLength = useState(0);
    final _chatController = useTextEditingController(text: '');


    useEffect(() {
      _chatProvider.socket.on('receive-message', (msgData) {
        Map<String, dynamic> receiveMsg = jsonDecode(msgData);
        _messages.value.insert(0, receiveMsg);
        _msgLength.value++; //List useState 상태변화 체크 못함
      });

    }, []);

    List<Widget> _chatList(){
      return _messages.value.map((item)=> item['UID'] == _loginProvider.UID ?
            MyChat(text: item['text'], time: '11:12',) :
            Chat(nickname: item['nickname'], text: item['text'], time: '11:11',)).toList();
    }


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('채팅', style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
                reverse: true,
                children: _chatList(),
              )
          ),
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  icon: const Icon(Icons.add),
                  iconSize: 25,
                  onPressed: () {},
                ),
                Expanded(
                    child: TextField(
                      controller: _chatController,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    )
                ),
                IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  icon: const Icon(Icons.send),
                  iconSize: 25,
                  onPressed: () {
                    if(_chatController.text == '') {
                      return;
                    } else {
                      Map<String, dynamic> msgData = {
                        'UID' :  _loginProvider.UID,
                        'text' : _chatController.text,
                        'nickname' : _loginProvider.nickname
                      };
                      final String jsonMsgData = jsonEncode(msgData);
                      _messages.value.insert(0, msgData);
                      _msgLength.value++; //List useState 상태변화 체크 못함
                      _chatProvider.socket.emit('message', jsonMsgData);
                      _chatController.text = '';
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}





