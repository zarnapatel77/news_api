import 'package:credit_yodha/news_app/framework_news/model/news_list_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsRepository{
  final Dio _dio = Dio();
  
  Future<NewsListResponseModel?> getNewsApi() async {
    try {
      final respons = await _dio.get(
          'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=4a391eb2d1394a038152fb079373b327');
      print('${respons.data}');
      return NewsListResponseModel.fromJson(respons.data);
    } catch(e) {
      debugPrint('API error: $e');
      return null;
    }
  }
}