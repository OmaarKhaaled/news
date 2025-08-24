import 'package:flutter/material.dart';
import 'package:news/api/api_service.dart';
import 'package:news/app_theme.dart';
import 'package:news/models/news_response/News.dart';
import 'package:news/models/sources_response/source.dart';
import 'package:news/models/sources_response/sources_response.dart';
import 'package:news/news/news_item.dart';
import 'package:news/news/tab_item.dart';
import 'package:news/widgets/error_indicator.dart';
import 'package:news/widgets/loading_indicator.dart';

class NewsView extends StatefulWidget {
  String categoryId;

  NewsView({required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  late Future<SourcesResponse> getsources = ApiService.getSources(
    widget.categoryId,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getsources,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        } else if (snapshot.hasError || snapshot.data?.status != 'ok') {
          return ErrorIndicator();
        } else {
          List<Source> sources = snapshot.data?.sources ?? [];
          return Column(
            children: [
              DefaultTabController(
                length: sources.length,
                child: TabBar(
                  tabs: sources
                      .map(
                        (source) => TabItem(
                          isSelected: currentIndex == sources.indexOf(source),
                          source: source,
                        ),
                      )
                      .toList(),
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicatorColor: AppTheme.white,
                  padding: EdgeInsetsDirectional.only(start: 16),
                  labelPadding: EdgeInsets.only(right: 16),
                  tabAlignment: TabAlignment.start,
                  onTap: (index) {
                    if (currentIndex == index) return;
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: ApiService.getNews(sources[currentIndex].id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingIndicator();
                    } else if (snapshot.hasError ||
                        snapshot.data?.status != 'ok') {
                      return ErrorIndicator();
                    } else {
                      List<News> news = snapshot.data?.news ?? [];
                      return ListView.separated(
                        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                        itemBuilder: (_, index) => NewsItem(news: news[index]),
                        separatorBuilder: (_, _) => SizedBox(height: 16),
                        itemCount: news.length,
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
