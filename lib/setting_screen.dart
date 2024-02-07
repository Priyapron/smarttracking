import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'mainmenu.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController imeiController = TextEditingController();
  TextEditingController deviceNameController = TextEditingController();

  Future<void> saveData(BuildContext context) async {
    try {
      String url = "http://localhost/tracking/setting.php";
      var response = await http.post(
        Uri.parse(url),
        body: {
          "imei_no": imeiController.text,
          "device_name": deviceNameController.text,
        },
      );

      if (response.statusCode == 200) {
        // Insert ข้อมูลสำเร็จ
        print("Insert ข้อมูลสำเร็จ");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Successfully'),
              content: Text('Your setting has been successfully saved'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // ปิด AlertDialog
                    Navigator.pop(context); // ปิดหน้า SettingScreen
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // เกิดข้อผิดพลาด
        print("เกิดข้อผิดพลาด: ${response.statusCode}");
      }
    } catch (error) {
      // เกิดข้อผิดพลาด
      print("เกิดข้อผิดพลาด: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: imeiController,
              decoration: InputDecoration(labelText: 'IMEI Number'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: deviceNameController,
              decoration: InputDecoration(labelText: 'Device Name'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => saveData(context),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
