import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? selectedCategory;
  final categories = ['general', 'business', 'technology', 'health', 'entertainment'];

  _savePreference() async {
    if (selectedCategory != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('newsCategory', selectedCategory!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(preference: selectedCategory)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Select Your Preferred News Category', style: TextStyle(fontSize: 20)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  title: Text(categories[index]),
                  value: categories[index],
                  groupValue: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value.toString();
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _savePreference,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
