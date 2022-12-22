import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class post extends StatefulWidget {
  const post({Key? key}) : super(key: key);

  @override
  State<post> createState() => _PostState();
}

class _PostState extends State<post> {

  List _get = [];

  Future _getPost() async {
    try {
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'));
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
    _getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data Post'),
        ),
        body: ListView.builder(
            itemCount: _get.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(_get[index]['userId'].toString()),
                    subtitle: Text(_get[index]['id']['title']['body'].toString()),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: ((context) => [
                        PopupMenuItem(child: Text('View'),
                        value: 1,
                        ),
                        PopupMenuItem(child: Text('Edit'),
                        ),
                      ]),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )
                );
              }
            ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => post())));
          },
        )
      );
   }
}