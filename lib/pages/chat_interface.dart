import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/widgets/chat_item.dart';
import 'package:flutter/material.dart';

class ChatInterface extends StatelessWidget {
  const ChatInterface({super.key});
  static String id = 'ChatInterface';

  @override
  Widget build(BuildContext context) {
    // قائمة بيانات الأشخاص
    final List<Map<String, String>> chatData = [
      {
        'name': 'Ali Mohamed',
        'imagePath': 'assets/images/Ali.jpg',
        'time': '12:30 PM',
      },
      {
        'name': 'Eng.Abdelrhman',
        'imagePath': 'assets/images/Abdo.jpg',
        'time': '11:45 AM',
      },
      {
        'name': 'Mohanad Ali',
        'imagePath': 'assets/images/mohanad.jpg',
        'time': '10:15 AM',
      },
      {
        'name': 'Ahmed Fouad',
        'imagePath': 'assets/images/Ahmed.jpg',
        'time': '9:00 AM',
      },
      {
        'name': 'Ahmed Shehata',
        'imagePath': 'assets/images/Ahmed Shehata.jpg',
        'time': 'Yesterday',
      },
      {
        'name': 'Asim Omar',
        'imagePath': 'assets/images/Asim.jpg',
        'time': 'Yesterday',
      },
      {
        'name': 'Ali Alkotob',
        'imagePath': 'assets/images/Alkotob.jpg',
        'time': 'Yesterday',
      },
      {
        'name': 'Mohamed Abed',
        'imagePath': 'assets/images/Abed.jpg',
        'time': 'Yesterday',
      },
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'WhatsApp',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 20,
                  height: 80,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50,
                  width: 50,
                  child: const Center(child: Text('All')),
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50,
                  width: 70,
                  child: const Center(child: Text('Unread')),
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50,
                  width: 70,
                  child: const Center(child: Text('Groups')),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chatData.length,
                itemBuilder: (context, index) {
                  final chat = chatData[index];
                  return ChatItem(
                    name: chat['name']!,
                    imagePath: chat['imagePath']!,
                    time: chat['time']!,
                    ontap: () {
                      Navigator.pushNamed(context, ChatPage.id);
                    },
                    // ontap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => ChatPage()),
                    //   );
                    // },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String name;
  final String imagePath;
  final String time;
  VoidCallback? ontap;
  ChatItem({
    required this.name,
    required this.imagePath,
    required this.time,
    this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            time,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Last message preview...',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
