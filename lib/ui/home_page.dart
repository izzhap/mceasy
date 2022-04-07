import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'list/list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _loadData = false;
  String _imageUrl = "";
  ValueNotifier<int> notificationCounterValueNotifer = ValueNotifier(0);
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(
          text,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 5.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'McEasy',
            style: TextStyle(color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        leading: Icon(Icons.people),
                        title: Text("Semua karyawan"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListPage()))
                              .then((value) {});
                        }),
                    ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        leading: Icon(Icons.people),
                        title: Text("Karyawan pertama bergabung"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListPage()))
                              .then((value) {});
                        }),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
