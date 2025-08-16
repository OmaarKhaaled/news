import 'package:flutter/material.dart';
import 'package:news/app_theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final dateTime = DateTime.now().subtract(Duration(minutes: 50, days: 2));

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.white),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/image.png',
              height: MediaQuery.sizeOf(context).height * .25,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '40-year-old man falls 200 feet to his death while canyoneering at national park',
            style: textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('By : Jon Haworth', style: textTheme.labelSmall),
              Text(timeago.format(dateTime), style: textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
