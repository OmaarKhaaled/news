import 'package:flutter/material.dart';
import 'package:news/news/data/models/News.dart';
import 'package:news/shared/constants/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';


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
                          webOnlyWindowName: '_blank', 
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
