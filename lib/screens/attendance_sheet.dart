import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.teal,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: AttendanceSheet(),
  ));
}

class AttendanceSheet extends StatefulWidget {
  @override
  _AttendanceSheetState createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  List<Student> students = [
    Student(name: 'Student 1', isPresent: false),
    Student(name: 'Student 2', isPresent: false),
    Student(name: 'Student 3', isPresent: false),
  ];

  void _submitAttendance() {
    // Here you can handle the submission of attendance data
    print('Attendance submitted:');
    for (var student in students) {
      print('${student.name}: ${student.isPresent ? 'Present' : 'Absent'}');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attendance submitted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Sheet'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          students[index].name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        value: students[index].isPresent,
                        onChanged: (bool? value) {
                          setState(() {
                            students[index].isPresent = value ?? false;
                          });
                        },
                        activeColor: Colors.teal,
                        checkColor: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitAttendance,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Student {
  String name;
  bool isPresent;

  Student({required this.name, this.isPresent = false});
}
