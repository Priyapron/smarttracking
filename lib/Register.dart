import 'package:smarttracking/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smarttracking/login_screen.dart';
import 'package:smarttracking/login_screen.dart';

class RegisterUserForm extends StatefulWidget {
  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void registerUser() async {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String dob = dobController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String password = passwordController.text;

// URL ของ API ทคี่ ณุ ตอ้ งการเรยี กใช ้(saveregister.php)
    String apiUrl = 'http://localhost/tracking/saveregister.php';
//print(apiUrl);
// สร้าง body ของ request เพอื่ สง่ ขอ้มลู
    Map<String, dynamic> requestBody = {
      'firstname': firstName,
      'lastname': lastName,
      'dob': dob,
      'email': email,
      'phone': phone,
      'password': password,
    };
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
// ด าเนินการเมื่อ request ส าเร็จ
//print('สมัครสมาชกิส าเร็จ');
//print(response.body);
        showSuccessDialog(context);
      } else {
// ด าเนินการเมื่อ request ไมส่ าเร็จ
        print('ไมสามารถสมัครสมาชกิได้');
      }
    } catch (error) {
// ด าเนนิ การเมอื่ เกดิขอ้ผดิ พลาดในการเชอื่ มตอ่
      print('เกดิขอ้ผดิ พลาดในการเชอื่ มตอ่ : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'Firstname'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Lastname'),
            ),
            TextFormField(
              controller: dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
              onTap: () async {
                // Show Date Picker when the user taps on the TextFormField
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                // Update the controller's text with the selected date if not null
                if (selectedDate != null) {
                  dobController.text =
                      selectedDate.toLocal().toString().split(' ')[0];
                }
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Telephone'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: registerUser,
              child: Text('บันทึก'),
            ),
          ],
        ),
      ),
    );
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Successfully'),
        content: Text('Your information has been successfully saved..'),
        actions: [
          TextButton(
            onPressed: () {
//Navigator.of(context).pop(); // ปิดป๊ อปอัพ
              Navigator.of(context).pushReplacement(MaterialPageRoute(
//builder: (context) => MainMenu(),
                  builder: (context) => LoginScreen()));
            },
            child: Text('Goto Login Page'),
          ),
        ],
      );
    },
  );
}
