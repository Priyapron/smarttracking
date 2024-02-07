import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowHealthInfoPage extends StatefulWidget {
  final String idCard;

  ShowHealthInfoPage({required this.idCard});

  @override
  _ShowHealthInfoPageState createState() => _ShowHealthInfoPageState();
}

class _ShowHealthInfoPageState extends State<ShowHealthInfoPage> {
  late Future<Map<String, dynamic>> _healthInfo;

  Future<Map<String, dynamic>> _fetchHealthInfo() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/tracking/show_health_info.php'),
        body: {'id_card': widget.idCard},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> parsed = json.decode(response.body);
        return parsed;
      } else {
        throw Exception('Failed to load health information');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load health information');
    }
  }

  @override
  void initState() {
    super.initState();
    _healthInfo = _fetchHealthInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Information'),
        backgroundColor: Color.fromARGB(255, 56, 136, 255),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _healthInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No health information found'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Health Information',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Table(
                    border: TableBorder.all(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(3),
                    },
                    children: [
                      buildTableRow('ID Card', snapshot.data!['id_card']),
                      buildTableRow('Title Name', snapshot.data!['titlename']),
                      buildTableRow('First Name', snapshot.data!['firstname']),
                      buildTableRow('Last Name', snapshot.data!['lastname']),
                      buildTableRow(
                          'Date of Birth', snapshot.data!['date_of_birth']),
                      buildTableRow(
                          'Heart Value', snapshot.data!['heart_value']),
                      buildTableRow(
                          'Pulse Value', snapshot.data!['pulse_value']),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  TableRow buildTableRow(String label, dynamic value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value.toString(),
              style: TextStyle(
                color: Colors.black, // Set text color to black
              ),
            ),
          ),
        ),
      ],
    );
  }
}
