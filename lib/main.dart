import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite_lecture/database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> allData = [];

  getData() async {
    final data = await SqLHelper.getItems();
    allData = data;
    setState(() {});
    log(allData.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: allData.length,
            itemBuilder: (_, i) {
              return ListTile(
                title: Text(allData[i]['name']),
                subtitle: Text(allData[i]['email']),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await SqLHelper.updateItems(allData[i]['id'], 'Chirag', 'Jeet@gmail.com');
                          getData();
                        },
                        child: const Icon(Icons.edit),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          await SqLHelper.deleteItems(allData[i]['id']);
                          getData();
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            SqLHelper.addItems(
                name: 'Gopal', email: 'Chovatiyagopal@gmail.com');
            getData();
          },
        ));
  }
}
