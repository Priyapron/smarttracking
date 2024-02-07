import 'package:flutter/material.dart';
import 'mainmenu.dart'; // ต้องการ import หน้า MainMenu

class SOSScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/SOS.jpg',
              height: MediaQuery.of(context).size.height * 2 / 3,
              width: MediaQuery.of(context).size.width * 2 / 3,
            ),
          ],
        ),
      ),
    );
  }
}
