import 'package:flutter/material.dart';
import 'package:newsly/update.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String description = '';
  String email = '';
  String dpUrl = 'https://www.iitg.ac.in/storage/gallery/1/1302618796.jpg';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Your Name';
      description = prefs.getString('description') ?? 'Your Description';
      email = prefs.getString('email') ?? 'Your Email';
      dpUrl = prefs.getString('dpUrl') ?? 'https://www.iitg.ac.in/storage/gallery/1/1302618796.jpg';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => update_page()),
              ).then((_) => _loadProfile()); // Reload profile after update
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.network(
                    dpUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, size: 150),
                  ),
                ),
              ),
              SizedBox(height: 16),
              const Divider(),
              Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(email, style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),

          ),
      ),
      );
  }
}
