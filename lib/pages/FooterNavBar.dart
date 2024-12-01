// import 'package:flutter/material.dart';
// import 'home_page.dart';
// import 'settings_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class FooterNavBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       shape: CircularNotchedRectangle(),
//       notchMargin: 10.0,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: () async {
//               SharedPreferences prefs = await SharedPreferences.getInstance();
//               String? preference = prefs.getString('newsCategory') ?? 'general';
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomePage(preference: preference)),
//               );
//             },
//           ),
//           SizedBox(width: 10), // Blank button 1
//           Container(
//             height: 60,
//             width: 60,
//             child: FloatingActionButton(
//               shape: StadiumBorder(),
//               backgroundColor: Colors.purple,
//               onPressed: () {}, // Oval button (blank for now)
//               child: Icon(Icons.add),
//             ),
//           ),
//           SizedBox(width: 10), // Blank button 2
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SettingsPage()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'home_page.dart';
import 'settings_page.dart';
import 'welcome_page.dart'; // Import the WelcomePage
import 'package:shared_preferences/shared_preferences.dart';

class FooterNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? preference = prefs.getString('newsCategory') ?? 'general';
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(preference: preference)),
              );
            },
          ),
          SizedBox(width: 10), // Blank button 1
          Container(
            height: 60,
            width: 60,
            child: FloatingActionButton(
              shape: StadiumBorder(),
              backgroundColor: Colors.purple,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()), // Navigate to WelcomePage
                );
              },
              child: Icon(Icons.info), // Icon for the oval button
            ),
          ),
          SizedBox(width: 10), // Blank button 2
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
