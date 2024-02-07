import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditHealthInfoScreen extends StatefulWidget {
  final Map<String, dynamic> healthData;

  EditHealthInfoScreen({required this.healthData});

  @override
  _EditHealthInfoScreenState createState() => _EditHealthInfoScreenState();
}

class _EditHealthInfoScreenState extends State<EditHealthInfoScreen> {
  TextEditingController idCardController = TextEditingController();
  TextEditingController titleNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController heartValueController = TextEditingController();
  TextEditingController pulseValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with existing data if available
    idCardController.text = widget.healthData['id_card'] ?? '';
    titleNameController.text = widget.healthData['titlename'] ?? '';
    firstNameController.text = widget.healthData['firstname'] ?? '';
    lastNameController.text = widget.healthData['lastname'] ?? '';
    dobController.text = widget.healthData['date_of_birth'] ?? '';
    heartValueController.text = widget.healthData['heart_value'] ?? '';
    pulseValueController.text = widget.healthData['pulse_value'] ?? '';
  }

  Future<void> _saveEditedHealthInfo() async {
    final apiUrl = 'http://localhost/tracking/update_health_info.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'case': '2', // Updated to use case '2'
          'id_card': idCardController.text,
          'titlename': titleNameController.text,
          'firstname': firstNameController.text,
          'lastname': lastNameController.text,
          'date_of_birth': dobController.text,
          'heart_value': heartValueController.text,
          'pulse_value': pulseValueController.text,
        },
      );

      if (response.statusCode == 200) {
        print('Health information updated successfully');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Health information updated successfully'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close AlertDialog
                    Navigator.pop(context, true); // Close EditHealthInfoScreen
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Error updating health information: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating health information'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Health Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: idCardController,
              decoration: InputDecoration(labelText: 'ID Card'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: titleNameController,
              decoration: InputDecoration(labelText: 'Title Name'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (selectedDate != null) {
                  dobController.text =
                      selectedDate.toLocal().toString().split(' ')[0];
                }
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: heartValueController,
              decoration: InputDecoration(labelText: 'Heart Value'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: pulseValueController,
              decoration: InputDecoration(labelText: 'Pulse Value'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveEditedHealthInfo,
              child: Text('Save Edited Health Information'),
            ),
          ],
        ),
      ),
    );
  }
}
