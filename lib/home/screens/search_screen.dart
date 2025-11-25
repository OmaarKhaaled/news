import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/news/view/widgets/news_item.dart';
import 'package:news/news/view_model/news_state.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/shared/constants/app_theme.dart';
import 'package:news/shared/widgets/details.dart';
import 'package:news/shared/widgets/error_indicator.dart';
import 'package:news/shared/widgets/loading_indicator.dart';
import 'package:news/sources/view_model/sources_state.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<NewsViewModel>().getAllNews();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: TextField(
              controller: searchController,
              style: TextStyle(color: AppTheme.white),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 20, color: AppTheme.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppTheme.white, width: 2),
                ),
                prefixIcon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 18,
                  height: 18,
                  fit: BoxFit.scaleDown,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    searchController.clear();
                    context.read<NewsViewModel>().filterNews('');
                  },
                  child: GestureDetector(
                    onTap: () {
                      searchController.text = '';
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      'assets/icons/cancel.svg',
                      width: 18,
                      height: 18,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.white),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.white),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onChanged: (query) {
                context.read<NewsViewModel>().filterNews(query);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<NewsViewModel, NewsState>(
              builder: (context, state) {
                if (state is GetSourcesLoading) {
                  return LoadingIndicator();
                } else if (state is GetNewsError) {
                  return ErrorIndicator(errorMessage: state.message);
                } else if (state is GetNewsSuccess) {
                  if (state.news.isEmpty) {
                     return Center(
                    child: Text(
                      state.currentQuery.isEmpty
                          ? 'Start typing to search for news'
                          : 'No results found',
                      style: TextStyle(color: AppTheme.white, fontSize: 18),
                    ),
                  );
                  }
                  else {
                  return ListView.separated(
                    padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                    itemCount: state.news.length,
                    itemBuilder: (_, index) => InkWell(
                      child: NewsItem(news: state.news[index]),
                      onTap: () => showDetails(context, state.news[index]),
                    ),
                    separatorBuilder: (_, __) => SizedBox(height: 16),
                  );
                }
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
