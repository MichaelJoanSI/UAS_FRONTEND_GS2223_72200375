import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class comments extends StatefulWidget {
  const comments({Key? key}) : super(key: key);

  @override
  State<comments> createState() => _CommentsState();
}

class _CommentsState extends State<comments> {

  List _get = [];

  Future _getComments() async {
    try {
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _get = data;
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    _getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data Comments'),
        ),
        body: ListView.builder(
            itemCount: _get.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(_get[index]['postId'].toString()),
                    subtitle: Text(_get[index]['id']['name']['email']['body'].toString()),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: ((context) => [
                        PopupMenuItem(child: Text('Edit'),
                        value: 1,
                        ),
                        PopupMenuItem(child: Text('Delete'),
                        ),
                      ]),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                );
              }
            ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => comments())));
          },
        )
      );
   }
}