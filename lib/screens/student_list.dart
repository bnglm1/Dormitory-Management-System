import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.teal,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: StudentListPage(),
  ));
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<Map<String, String>> students = [
    {"name": "Student A", "room": "1", "age": "20"},
    {"name": "Student B", "room": "1", "age": "21"},
    {"name": "Student C", "room": "1", "age": "22"},
    {"name": "Student D", "room": "1", "age": "23"},
    {"name": "Student E", "room": "2", "age": "24"},
    {"name": "Student F", "room": "2", "age": "25"},
    {"name": "Student G", "room": "2", "age": "26"},
    {"name": "Student H", "room": "2", "age": "27"},
    {"name": "Student I", "room": "3", "age": "28"},
    {"name": "Student J", "room": "3", "age": "29"},
    {"name": "Student K", "room": "3", "age": "30"},
    {"name": "Student L", "room": "3", "age": "31"},
    {"name": "Student M", "room": "4", "age": "32"},
    {"name": "Student N", "room": "4", "age": "33"},
    {"name": "Student O", "room": "4", "age": "34"},
    {"name": "Student P", "room": "4", "age": "35"},
  ];

  List<Map<String, String>> filteredStudents = [];
  Map<String, List<Map<String, String>>> rooms = {};

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
    _assignRooms();
  }

  void _assignRooms() {
    rooms = {};
    for (var student in filteredStudents) {
      String roomNumber = student["room"]!;
      if (!rooms.containsKey(roomNumber)) {
        rooms[roomNumber] = [];
      }
      rooms[roomNumber]!.add(student);
    }
  }

  void filterSearch(String query) {
    List<Map<String, String>> dummySearchList = [];
    dummySearchList.addAll(students);
    if (query.isNotEmpty) {
      List<Map<String, String>> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item["name"]!.toLowerCase().contains(query.toLowerCase()) ||
            item["room"]!.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredStudents = dummyListData;
        _assignRooms();
      });
      return;
    } else {
      setState(() {
        filteredStudents = students;
        _assignRooms();
      });
    }
  }

  void _addStudent(String name, String room, String age) {
    setState(() {
      students.add({"name": name, "room": room, "age": age});
      filteredStudents = students;
      _assignRooms();
    });
  }

  void _showStudentDetails(Map<String, String> student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailPage(student: student),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        elevation: 0,
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
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  filterSearch(value);
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search by name or room number",
                  prefixIcon: Icon(Icons.search, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: filteredStudents.length,
                  itemBuilder: (context, index) {
                    final colors = [
                      Colors.teal[100],
                      Colors.blue[100],
                      Colors.green[100],
                      Colors.amber[100],
                      Colors.purple[100],
                      Colors.orange[100],
                    ];
                    final color = colors[index % colors.length];

                    return GestureDetector(
                      onTap: () {
                        _showStudentDetails(filteredStudents[index]);
                      },
                      child: StudentCard(
                        name: filteredStudents[index]["name"]!,
                        backgroundColor: color,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudentPage(onAddStudent: _addStudent),
            ),
          );
        },
        label: const Text("Add Student"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final String name;
  final Color? backgroundColor;

  const StudentCard({required this.name, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                color: Colors.teal[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentDetailPage extends StatelessWidget {
  final Map<String, String> student;

  const StudentDetailPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
        elevation: 0,
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
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailRow(title: 'Name', value: student["name"]!),
                  SizedBox(height: 10),
                  DetailRow(title: 'Age', value: student["age"]!),
                  SizedBox(height: 10),
                  DetailRow(title: 'Room', value: student["room"]!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;

  const DetailRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800]),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.teal[600]),
          ),
        ),
      ],
    );
  }
}

class AddStudentPage extends StatelessWidget {
  final Function(String, String, String) onAddStudent;

  const AddStudentPage({required this.onAddStudent});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final roomController = TextEditingController();
    final ageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
        elevation: 0,
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
              buildTextField(nameController, 'Name'),
              SizedBox(height: 10),
              buildTextField(roomController, 'Room'),
              SizedBox(height: 10),
              buildTextField(ageController, 'Age',
                  keyboardType: TextInputType.number),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  final room = roomController.text;
                  final age = ageController.text;
                  if (name.isNotEmpty && room.isNotEmpty && age.isNotEmpty) {
                    onAddStudent(name, room, age);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Student'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
