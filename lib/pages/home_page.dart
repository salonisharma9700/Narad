import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'settings_page.dart';
import 'article_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FooterNavBar.dart';

class HomePage extends StatefulWidget {
  final String? preference;

  HomePage({this.preference});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  // Fetch the news articles from the API based on preference
  _fetchNews() async {
    final apiKey = '9817fb31783d47a19402fa8cf1667739'; // Replace with your actual API key
    final category = widget.preference ?? 'general'; // Use default 'general' if preference is null
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          articles = (data['articles'] as List).where((article) {
            // Filter out invalid articles
            return article['title'] != null &&
                article['description'] != null &&
                article['url'] != null &&
                article['urlToImage'] != null;
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error: Received status code ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News - ${widget.preference ?? 'General'}'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              // Navigate to settings and wait for preference update
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );

              if (result != null) {
                // Update the preference and reload the news
                setState(() {
                  isLoading = true;
                  _fetchNews();
                });
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : articles.isNotEmpty
              ? ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ListTile(
                      title: Text(article['title'] ?? 'No Title'),
                      subtitle: Text(
                        article['description'] != null && article['description'].length > 100
                            ? article['description'].substring(0, 100) + '...'
                            : article['description'] ?? 'No Description',
                      ),
                      leading: article['urlToImage'] != null
                          ? Image.network(
                              article['urlToImage'],
                              fit: BoxFit.cover,
                              width: 100,
                            )
                          : SizedBox.shrink(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlePage(
                              title: article['title'] ?? 'Article',
                              url: article['url'] ?? '',
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              : Center(child: Text('No articles found')),
      bottomNavigationBar: FooterNavBar(), // Add Footer here
    );
  }
}
