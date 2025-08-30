import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/shared/constants/app_theme.dart';

class HomeDrawer extends StatelessWidget {
  VoidCallback onGpToHomeClicked;

  HomeDrawer({required this.onGpToHomeClicked});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    return Container(
      color: AppTheme.black,
      width: screenSize.width * .7,
      child: Column(
        children: [
          Container(
            height: screenSize.height * .2,
            width: double.infinity,
            alignment: Alignment.center,
            color: AppTheme.white,
            child: Text(
              'News App',
              style: textTheme.titleLarge!.copyWith(
                color: AppTheme.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                onGpToHomeClicked();
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/home.svg'),
                  SizedBox(width: 8),
                  Text('Go To Home', style: textTheme.labelLarge),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
