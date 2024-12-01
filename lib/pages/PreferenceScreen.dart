import 'package:flutter/material.dart';
import 'FooterNavBar.dart'; // Ensure FooterNavBar is implemented and imported correctly
import 'home_page.dart'; // Import HomePage widget

class PreferenceScreen extends StatefulWidget {
  final Function(String) onSave;

  PreferenceScreen({required this.onSave});

  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select News Category'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Choose your preferred news category:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedCategory,
              items: <String>['Business', 'Technology', 'Sports', 'Entertainment', 'Health']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              hint: Text('Select a category'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedCategory != null
                  ? () {
                      widget.onSave(_selectedCategory!);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(preference: _selectedCategory!),
                        ),
                      );
                    }
                  : null,
              child: Text('Save and Continue'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterNavBar(), // Ensure FooterNavBar is implemented and working
    );
  }
}
