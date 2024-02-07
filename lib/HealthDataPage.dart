import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smarttracking/EditHealthInfo.dart';
import 'package:smarttracking/show_health_info.dart';

class HealthDataPage extends StatefulWidget {
  @override
  _HealthDataPageState createState() => _HealthDataPageState();
}

class _HealthDataPageState extends State<HealthDataPage> {
  late Future<List<Map<String, dynamic>>> _HealthData;

  Future<List<Map<String, dynamic>>> _fetchHealthData() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost/tracking/selecthealth.php'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> parsed = json.decode(response.body);
        return parsed.cast<Map<String, dynamic>>();
      } else {
        throw Exception('ไม่สามารถเชื่อมต่อข้อมูลได้ กรุณาตรวจสอบ');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('ไม่สามารถเชื่อมต่อข้อมูลได้ กรุณาตรวจสอบ');
    }
  }

  // Function to delete health data
  Future<void> _deleteHealthData(String idCard) async {
    final response = await http.post(
      Uri.parse('http://localhost/tracking/update_health_info.php'),
      body: {
        'case': '3',
        'id_card': '$idCard', // Change this line
      },
    );

    if (response.statusCode == 200) {
      print('Health data deleted successfully');
    } else {
      print('Failed to delete health data');
    }
  }

  @override
  void initState() {
    super.initState();
    _HealthData = _fetchHealthData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 56, 136, 255),
        leading: IconButton(
          icon: Icon(Icons.home),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/mainmenu');
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Body Health',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _HealthData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('ไม่พบข้อมูล'));
            } else {
              return Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/body_health-icon.png',
                          width: 40,
                          height: 40,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Body Health',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Center(
                          child: DataTable(
                            columns: <DataColumn>[
                              DataColumn(label: Text(' ')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Surname')),
                              DataColumn(label: Text('Temp.')),
                              DataColumn(
                                  label: Text('Search')), // เพิ่มบรรทัดนี้
                              DataColumn(label: Text('Edit')),
                              DataColumn(label: Text('Delete')),
                            ],
                            rows: snapshot.data!.map((data) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(' ')),
                                  DataCell(Text(
                                      data['firstname']?.toString() ?? 'N/A')),
                                  DataCell(Text(
                                      data['lastname']?.toString() ?? 'N/A')),
                                  DataCell(Text(
                                      data['heart_value']?.toString() ??
                                          'N/A')),
                                  DataCell(
                                    IconButton(
                                      icon: Icon(Icons.search), // ใช้ไอคอนค้นหา
                                      color: Colors
                                          .green, // เปลี่ยนสีตามที่ต้องการ
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShowHealthInfoPage(
                                              idCard:
                                                  data['id_card']?.toString() ??
                                                      '',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  DataCell(
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Colors.blue,
                                      onPressed: () async {
                                        bool? result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditHealthInfoScreen(
                                              healthData: data,
                                            ),
                                          ),
                                        );

                                        if (result == true) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Health information updated successfully'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                          setState(() {
                                            _HealthData = _fetchHealthData();
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  DataCell(
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  Text('Delete Confirmation'),
                                              content: Text(
                                                'Are you sure you want to delete this health data?',
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    // Delete the health data
                                                    await _deleteHealthData(
                                                      data['id_card']
                                                              ?.toString() ??
                                                          '',
                                                    ); // Add null check
                                                    Navigator.of(context).pop();
                                                    setState(() {
                                                      _HealthData =
                                                          _fetchHealthData();
                                                    });
                                                  },
                                                  child: Text('Delete'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
