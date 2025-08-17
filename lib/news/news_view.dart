import 'package:flutter/material.dart';
import 'package:news/app_theme.dart';
import 'package:news/models/categry_model.dart';
import 'package:news/models/source_model.dart';
import 'package:news/news/news_item.dart';
import 'package:news/news/tab_item.dart';

class NewsView extends StatefulWidget { 

  String categoryId; 

  NewsView({required this.categoryId});
  
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  List<SourceModel> sources = List.generate(
    10,
    (index) => SourceModel(id: '$index', name: 'source $index'),
  );

  @override
  Widget build(BuildContext context) {
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
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 16, right: 16, left: 16),
            itemBuilder: (_, index) => NewsItem(),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
