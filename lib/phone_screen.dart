import 'package:flutter/material.dart';
import 'mainmenu.dart'; //import หน้า MainMenu

class PhoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Screen'),
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
              'images/Phon.png', // แทนที่ชื่อรูปภาพตามที่คุณต้องการ
              height: MediaQuery.of(context).size.height * 2 / 3,
              width: MediaQuery.of(context).size.width * 2 / 3,
            ),
          ],
        ),
      ),
    );
  }
}
