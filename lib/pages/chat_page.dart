import 'package:chatapp/constans.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static String id = 'Chatpage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageslist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageslist.add(
              Message.fromJson(snapshot.data!.docs[i]),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white70,
              title: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    Text(
                      "Chat",
                      style: TextStyle(color: Colors.black),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    IconButton(
                      icon: const Icon(Icons.videocam_sharp),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.call),
                      onPressed: () {},
                    ),
                  ]),
              // centerTitle: true,
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/Rectangle.png'), // استبدل بمسار صورتك
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messageslist.length,
                        itemBuilder: (context, index) {
                          return messageslist[index].id == email
                              ? ChatBuble(
                                  message: messageslist[index],
                                )
                              : ChatBubleForFriend(
                                  message: messageslist[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add(
                          {
                            kMessage: data,
                            kCreatedAt: DateTime.now(),
                            'id': email,
                          },
                        );
                        controller.clear();
                        _controller.animateTo(
                          0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: Text('Loading...')),
          );
        }
      },
    );
  }
}
