import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class uas extends StatefulWidget {
  const uas({super.key, required this.title});

  final String title;

  @override
  _pertemuan2State createState() => _pertemuan2State();
}

class _pertemuan2State extends State<uas> {
  int _counter = 2;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: new InputDecoration(
                  labelText: "Teks Input",
                  hintText: "Teks yang akan diinput formatnya adalah sbb",
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5))),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextFormField(
              decoration: new InputDecoration(
                  labelText: "Teks Input 2",
                  hintText: "Teks yang akan diinput formatnya adalah sbb",
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5))),
            ),
            ElevatedButton(
              child: Text(
                "Simpan",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print("Tombol Simpan Ditekan");
              },
            ),
            ElevatedButton(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            onPressed: () async{
              SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.setInt("is_login", 1);
              Navigator.pushReplacement(
                context,
                  MaterialPageRoute(
                    builder: (context) =>
                      MyHomePage(title: "Flutter demo Home Page"),
               ));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}