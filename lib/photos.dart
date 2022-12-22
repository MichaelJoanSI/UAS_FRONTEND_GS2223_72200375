import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class photos extends StatefulWidget {
  const photos({Key? key}) : super(key: key);

  @override
  State<photos> createState() => _PhotosState();
}

class _PhotosState extends State<photos> {

  List _get = [];

  Future _getPhotos() async {
    try {
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/photos'));
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
    _getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data Photos'),
        ),
        body: ListView.builder(
            itemCount: _get.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(_get[index]['albumId'].toString()),
                    subtitle: Text(_get[index]['id']['title']['url']['thumbnailUrl'].toString()),
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
                MaterialPageRoute(builder: ((context) => photos())));
          },
        )
      );
   }
}