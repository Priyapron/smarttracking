import 'package:flutter/material.dart';
import 'package:smarttracking/HealthDataPage.dart';
import 'package:smarttracking/sos_screen.dart';
import 'package:smarttracking/phone_screen.dart';
import 'package:smarttracking/tracking_screen.dart';
import 'package:smarttracking/menu_health_screen.dart';
import 'package:smarttracking/userinfo_screen.dart';
import 'package:smarttracking/setting_screen.dart';
import 'package:smarttracking/graph_screen.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // First Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: buildStyledImageButton(
                      'images/sos-menu-icon.png',
                      'SOS',
                      SOSScreen(),
                      context,
                    ),
                  ),
                  Expanded(
                    child: buildStyledImageButton(
                      'images/phon-menu-icon.jpeg',
                      'Phone',
                      PhoneScreen(),
                      context,
                    ),
                  ),
                ],
              ),
              // Second Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: buildStyledImageButton(
                      'images/Tracking-menu-icon.jpg',
                      'Tracking',
                      TrackingScreen(),
                      context,
                    ),
                  ),
                  Expanded(
                    child: buildStyledImageButton(
                      'images/health-menu-icon.png',
                      'Menu Health',
                      MenuHealthScreen(),
                      context,
                    ),
                  ),
                ],
              ),
              // Third Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: buildStyledImageButton(
                      'images/settings-menu-icon.png',
                      'Setting',
                      SettingScreen(),
                      context,
                    ),
                  ),
                  Expanded(
                    child: buildStyledImageButton(
                      'images/userinfo-menu-icon.png',
                      'UserInfo',
                      UserInfoScreen(),
                      context,
                    ),
                  ),
                ],
              ),
              //4th Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: buildStyledImageButton(
                      'images/health-info-icon.jpg',
                      'Healt Info',
                      HealthDataPage(),
                      context,
                    ),
                  ),
                  Expanded(
                    child: buildStyledImageButton(
                      'images/userinfo-menu-icon.png',
                      'UserInfo',
                      HealthTemp(),
                      context,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStyledImageButton(String imagePath, String buttonText,
      Widget destination, BuildContext context) {
    return Container(
      width: 180,
      height: 220,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.blue, width: 2.0),
          ),
          elevation: 5.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 100,
              height: 100,
            ),
            SizedBox(height: 15),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
