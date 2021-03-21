import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test1/helper/helpers.dart';
import 'package:test1/services/auth.dart';
import 'package:test1/services/store.dart';
import 'package:test1/widgets/app_bar.dart';
import 'package:test1/widgets/message_tile.dart';

class ChatScreen extends StatefulWidget {
  final String friendId;

  ChatScreen({this.friendId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  initState() {
    super.initState();

    initial();
  }

  initial() async {
    await createChat(
      fromId: auth.currentUser.uid,
      toId: widget.friendId,
    );
  }

  sendMessage() async {
    String message = messageController.text;

    if (message.isEmpty) {
      return;
    } else {
      await addMessage(
        fromId: auth.currentUser.uid,
        toId: widget.friendId,
        content: message,
      );

      messageController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: firestore
                      .collection('Chats')
                      .doc(getChatId(
                        fromId: auth.currentUser.uid,
                        toId: widget.friendId,
                      ))
                      .collection('messages')
                      .orderBy('at')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    print('StreamBuilder run');
                    if (snapshot.hasError) {
                      print('Có lỗi:');
                      print(snapshot.error);
                      return Text('Something went wrong!');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print('Waiting');
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.active) {
                      print('Active');
                      var tmp = snapshot.data.docs;

                      if (tmp.isEmpty) {
                        print('Empty');
                        return Container();
                      }
                      print('Ok');

                      return ListView.builder(
                        itemCount: tmp.length,
                        itemBuilder: (context, index) {
                          return MessageTile(
                            message: tmp[index].data()['content'],
                            isByMe:
                                tmp[index].data()['to_id'] == widget.friendId,
                          );
                        },
                      );
                    }

                    print('Sai sai');
                    return Container();
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Aa',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
