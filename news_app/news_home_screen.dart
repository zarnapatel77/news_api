import 'package:credit_yodha/news_app/framework_news/model/news_list_response_model.dart';
import 'package:credit_yodha/news_app/framework_news/repository/news_repository.dart';
import 'package:credit_yodha/news_app/news_details_screen.dart';
import 'package:flutter/material.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({super.key});

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  final NewsRepository repo = NewsRepository();
  NewsListResponseModel? newsData;
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async{
    final result = await repo.getNewsApi();
    if (mounted){
      setState(() {
        newsData = result;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Headlines'),),
      body: isLoading
        ? Center(child: CircularProgressIndicator())
      : newsData == null
        ?Center(child: Text('Failed to fetch newa.'))
      :ListView.builder(
          itemCount: newsData! .articles?.length ?? 0,
          itemBuilder: (context, index){
        final article = newsData! .articles![index];

        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => NewsDetailsScreen(article: article)));
          },
          child: Card(
            child: Column(
              children: [
                if (article.urlToImage != null)
                  Hero(tag: article.urlToImage!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          article.urlToImage!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox(height: 200, child: Center(child: Icon(Icons.broken_image))),
                        ),
                      ),
                  )
                else
                  SizedBox(height: 200, child: Center(child: Icon(Icons.image_not_supported))),
                Padding(padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title ?? 'No Title', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(
                     article.description ?? 'No description available',
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
