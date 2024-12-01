// import 'package:flutter/material.dart';
// import 'pages/home_page.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/PreferenceScreen.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _selectedCategory;
  bool _isFirstLaunch = true; // Tracks whether it's the user's first launch

  @override
  void initState() {
    super.initState();
    _loadUserPreference();
  }

  // Load saved user preference from SharedPreferences
  Future<void> _loadUserPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCategory = prefs.getString('newsCategory'); // Updated key to match SettingsPage
      _isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true; // Check if it's the first launch
    });
  }

  // Save user preference in SharedPreferences
  Future<void> _saveUserPreference(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('newsCategory', category); // Updated key to match SettingsPage
    await prefs.setBool('isFirstLaunch', false); // Set first launch to false
    setState(() {
      _selectedCategory = category;
      _isFirstLaunch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isFirstLaunch
          ? PreferenceScreen(onSave: _saveUserPreference)
          : HomePage(preference: _selectedCategory ?? 'general'), // Provide a default value
      routes: {
        '/settings': (context) => SettingsPage(), // No parameters needed
        '/welcome': (context) => WelcomePage(),
      },

    );
  }
}
