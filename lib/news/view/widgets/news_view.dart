import 'package:flutter/material.dart';
import 'package:news/shared/constants/app_theme.dart';
import 'package:news/news/data/models/News.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/shared/widgets/details.dart';
import 'package:news/sources/data/models/source.dart';
import 'package:news/news/view/widgets/news_item.dart';
import 'package:news/sources/data/models/widgets/tab_item.dart';
import 'package:news/sources/view_model/sources_view_model.dart';
import 'package:news/shared/widgets/error_indicator.dart';
import 'package:news/shared/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {
  String categoryId;

  NewsView({required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final SourcesViewModel sourcesViewModel = SourcesViewModel();
  final NewsViewModel newsViewModel = NewsViewModel();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    sourcesViewModel.getSources(widget.categoryId).then((_) {
      if (sourcesViewModel.sources.isNotEmpty) {
        newsViewModel.getNews(sourcesViewModel.sources[0].id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sourcesViewModel,
      child: Consumer<SourcesViewModel>(
        builder: (_, viewModel, _) {
          if (viewModel.isLoading) {
            return LoadingIndicator();
          } else if (viewModel.errorMessage != null) {
            return ErrorIndicator(errorMessage: viewModel.errorMessage!);
          } else {
            List<Source> sources = viewModel.sources;
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
                      newsViewModel.getNews(sources[index].id!);
                    },
                  ),
                ),
                Expanded(
                  child: ChangeNotifierProvider.value(
                    value: newsViewModel,
                    child: Consumer<NewsViewModel>(
                      builder: (_, viewModel, _) {
                        if (viewModel.isLoading) {
                          return LoadingIndicator();
                        } else if (viewModel.errorMessage != null) {
                          return ErrorIndicator(
                            errorMessage: viewModel.errorMessage!,
                          );
                        } else {
                          List<News> news = viewModel.news;
                          return ListView.separated(
                            padding: EdgeInsets.only(
                              top: 16,
                              right: 16,
                              left: 16,
                            ),
                            itemBuilder: (_, index) => InkWell(
                              child: NewsItem(news: news[index]),
                              onTap: () => showDetails(context, news[index]),
                            ),
                            separatorBuilder: (_, _) => SizedBox(height: 16),
                            itemCount: news.length,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
