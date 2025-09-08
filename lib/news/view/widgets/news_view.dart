import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/news/view_model/news_state.dart';
import 'package:news/shared/constants/app_theme.dart';
import 'package:news/news/data/models/News.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/shared/widgets/details.dart';
import 'package:news/sources/data/models/source.dart';
import 'package:news/news/view/widgets/news_item.dart';
import 'package:news/sources/data/models/widgets/tab_item.dart';
import 'package:news/sources/view_model/sources_state.dart';
import 'package:news/sources/view_model/sources_view_model.dart';
import 'package:news/shared/widgets/error_indicator.dart';
import 'package:news/shared/widgets/loading_indicator.dart';

class NewsView extends StatefulWidget {
  String categoryId;

  NewsView({required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<SourcesViewModel>().getSources(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SourcesViewModel, SourcesState>(
      listener: (context, state) {
        if (state is GetSourcesSuccess && state.sources.isNotEmpty) {
          final firstSource = state.sources.first;
          context.read<NewsViewModel>().getNews(firstSource.id!);
        }
      },
      child: BlocBuilder<SourcesViewModel, SourcesState>(
        builder: (context, state) {
          if (state is GetSourcesLoading) {
            return LoadingIndicator();
          } else if (state is GetSourcesError) {
            return ErrorIndicator(errorMessage: state.message);
          } else if (state is GetSourcesSuccess) {
            List<Source> sources = state.sources;
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
                      context.read<NewsViewModel>().getNews(sources[index].id!);
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<NewsViewModel, NewsState>(
                    builder: (_, state) {
                      if (state is GetNewsLoading) {
                        return LoadingIndicator();
                      } else if (state is GetNewsError) {
                        return ErrorIndicator(errorMessage: state.message);
                      } else if (state is GetNewsSuccess) {
                        List<News> news = state.news;
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
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
