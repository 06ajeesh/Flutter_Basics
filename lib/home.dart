import 'package:chatbot/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int countValue = 1;
  Widget sideBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ListTile(
          title: Center(
            child: Text(
              "Chats",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      width: 2,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                  child: ListTile(
                    title: Center(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        "Chat_${index + 1}",
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 0,
            ),
            itemCount: countValue,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: ElevatedButton.icon(
                style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
                onPressed: () {
                  _scaffoldKey.currentState!.closeDrawer();
                  Future.delayed(const Duration(milliseconds: 60))
                      .whenComplete(() {
                    _scaffoldKey.currentState!.closeDrawer();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ));
                  });
                },
                icon: const Icon(Icons.settings),
                label: const Text(
                  "Settings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Chat with me",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade500,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.table_rows),
        ),
        actions: [
          IconButton(
            style: const ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
                backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
            onPressed: () {
              setState(() {
                countValue++;
                _scaffoldKey.currentState!.openDrawer();
              });
            },
            icon: const Icon(
              Icons.add,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: sideBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 0) {
              _scaffoldKey.currentState!.openDrawer();
            } else if (details.delta.dx < 0) {
              _scaffoldKey.currentState!.closeDrawer();
            }
          },
          child: chatBody(size),
        ),
      ),
    );
  }

  chatBody(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: SizedBox(
        width: double.maxFinite,
        height: size.height,
        child: const ChatScreen(),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image:
                        'https://images.unsplash.com/photo-1611606063065-ee7946f0787a?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ),
              ),
            ),
            const Divider(
              indent: 50,
              endIndent: 50,
            ),
            repeatedListTile("Built with", "Flutter 3.19"),
            repeatedListTile("Model used", "Generative AI"),
            repeatedListTile("Creator", "Ajeesh"),
            repeatedListTile("Version", "1.0"),
            const Divider(
              indent: 50,
              endIndent: 50,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget repeatedListTile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
