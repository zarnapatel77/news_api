import 'package:credit_yodha/news_app/framework_news/model/news_list_response_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
  final Article article;
  const NewsDetailsScreen({super.key, required this.article});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.article.urlToImage != null
            ? Hero(tag: widget.article.urlToImage ?? '', child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(widget.article.urlToImage ?? '', width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.5, fit: BoxFit.cover),
            ),
            )
                :const Icon(Icons.image_not_supported),
            SizedBox(height: 20,),

            Text('Title: ${widget.article.title ?? 'No Title'}', style: TextStyle(fontWeight: FontWeight.bold)),

            SizedBox(height: 10,),

            Text('Subtitle: ${widget.article.description ?? 'No Subtitle'}'),

            SizedBox(height: 10,),

            Text('Author: ${widget.article.author ?? 'No Author'}'),

            SizedBox(height: 10,),

            Text('Content: ${widget.article.content ?? 'No Content'}'),

            SizedBox(height: 10,),

            Text('Published At: ${widget.article.publishedAt != null ? DateFormat('dd-mm-yyyy').format(widget.article.publishedAt!) : ''}')
          ],
        ),
        ),
      );
  }
}
