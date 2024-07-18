import 'package:basic_started/screens/attendance_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:basic_started/screens/student_list.dart';
import '/beginning/get_started.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.teal,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> announcements = [];
  final TextEditingController _announcementController = TextEditingController();
  DateTime? _selectedDate;

  void _addAnnouncement() {
    if (_announcementController.text.isNotEmpty && _selectedDate != null) {
      setState(() {
        announcements.add({
          "text": _announcementController.text,
          "date": DateFormat('dd-MM-yyyy').format(_selectedDate!),
        });
        _announcementController.clear();
        _selectedDate = null;
      });
    }
  }

  void _deleteAnnouncement(int index) {
    setState(() {
      announcements.removeAt(index);
    });
  }

  void _showAddAnnouncementDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Announcement', style: TextStyle(color: Colors.teal)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _announcementController,
              decoration: InputDecoration(
                labelText: 'Announcement',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: Text(_selectedDate == null
                  ? 'Select Date'
                  : DateFormat('yyyy-MM-dd').format(_selectedDate!)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel', style: TextStyle(color: Colors.teal)),
          ),
          ElevatedButton(
            onPressed: () {
              _addAnnouncement();
              Navigator.pop(context);
            },
            child: Text('Add'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Home Page',
            style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            iconSize: 30.0,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => GetStarted()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      NetworkImage('https://picsum.photos/seed/picsum/200/300'),
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_2_sharp, color: Colors.teal),
              title: const Text('Student List', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentListPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.fact_check, color: Colors.teal),
              title: Text('Attendance Sheet', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendanceSheet()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _showAddAnnouncementDialog,
                icon: Icon(Icons.add),
                label: Text('Add Announcement'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Announcements',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: announcements.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          announcements[index]["text"]!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          announcements[index]["date"]!,
                          style: TextStyle(color: Colors.teal),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteAnnouncement(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
