import 'package:flutter/material.dart';
import 'package:news/shared/app_theme.dart';
import 'package:news/news/data/models/News.dart';
import 'package:news/news/view_model/news_view_model.dart';
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
  SourcesViewModel sourcesViewModel = SourcesViewModel();
  NewsViewModel newsViewModel = NewsViewModel();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    sourcesViewModel.getSources(widget.categoryId);
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
            newsViewModel.getNews(sources[currentIndex].id!);
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
                  child: ChangeNotifierProvider(
                    create: (_) => newsViewModel,
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

  void showDetails(BuildContext context, News newsItem) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.sizeOf(context).height * .5,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Expanded(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    newsItem.urlToImage ??
                        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ANo_Image_Available.jpg&psig=AOvVaw28WXd06S2HWvPF5tVkcqO3&ust=1755892673763000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCIjH05vYnI8DFQAAAAAdAAAAABAL',
                    height: MediaQuery.sizeOf(context).height * .26,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  newsItem.content ?? "",
                  style: TextStyle(fontSize: 15, color: AppTheme.black),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                SizedBox(
                  height: 65,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final url = newsItem.url ?? "";
                      final uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri ,
                          mode: LaunchMode.externalApplication,
                          webViewConfiguration: WebViewConfiguration(),
                          webOnlyWindowName: '_blank',
                          browserConfiguration: BrowserConfiguration(),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cannot open the article')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'View Full Articel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
