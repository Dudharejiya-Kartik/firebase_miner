import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import '../../../controller/theme_controller/theme_controller.dart';

Widget themeButton({context}) => IconButton(
      icon: Icon(
        Provider.of<ThemeController>(context).isDark
            ? Icons.sunny
            : CupertinoIcons.moon_fill,
      ),
      onPressed: () {
        Provider.of<ThemeController>(context, listen: false).toggleTheme();
      },
    );
