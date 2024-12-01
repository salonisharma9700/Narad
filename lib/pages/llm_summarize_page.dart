// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// // import '../models/api_response.dart';
// import '../widgets/text_input_widget.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final _controller = TextEditingController();
//   String _summary = '';

//   void _summarizeArticle() async {
//     final article = _controller.text;
//     final response = await getSummary(article);
//     setState(() {
//       _summary = response.summary;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Summarizer')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextInputWidget(
//               controller: _controller,
//               onPressed: _summarizeArticle,
//             ),
//             SizedBox(height: 16),
//             Text('Summary:'),
//             SizedBox(height: 8),
//             Text(_summary),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Make sure this points to your correct API service file
import '../widgets/text_input_widget.dart'; // Text input widget for article input

class LLMSummarizePage extends StatefulWidget {
  @override
  _LLMSummarizePageState createState() => _LLMSummarizePageState();
}

class _LLMSummarizePageState extends State<LLMSummarizePage> {
  final _controller = TextEditingController(); // Controller for the text input
  String _summary = ''; // Variable to hold the summary result

  // Function to fetch summary from the LLM API
  void _summarizeArticle() async {
    final article = _controller.text; // Get the input text
    final response = await getSummary(article); // API call to fetch summary
    setState(() {
      _summary = response.summary; // Update the summary state with the API response
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summarizer')), // AppBar with the title 'Summarizer'
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
          children: [
            TextInputWidget( // Custom text input widget for article input
              controller: _controller, // Attach the controller
              onPressed: _summarizeArticle, // Summarize on button press
            ),
            SizedBox(height: 16), // Space between widgets
            Text('Summary:', style: TextStyle(fontWeight: FontWeight.bold)), // Label for summary
            SizedBox(height: 8), // Small space before the summary text
            Text(
              _summary, // Display the summary here
              style: TextStyle(fontSize: 16, color: Colors.black87), // Style for summary text
            ),
          ],
        ),
      ),
    );
  }
}
