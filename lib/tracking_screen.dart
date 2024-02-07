import 'package:flutter/material.dart';
import 'mainmenu.dart'; // ต้องการ import หน้า MainMenu

class TrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking Screen'),
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
              'images/Tracking.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 2 / 3,
              width: MediaQuery.of(context).size.width * 2 / 3,
            ),
          ],
        ),
      ),
    );
  }
}
