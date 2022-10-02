import 'package:flutter/material.dart';

import '../../../icons/my_flutter_app_icons.dart';
import '../favorite.dart';
import '../folders.dart';
import '../settings.dart';


enum TabItem { folder, allVideos, favorite, settings }

Map<TabItem, String> tabName = {
  TabItem.folder: 'Folder',
  TabItem.allVideos: 'All Videos',
  TabItem.favorite: 'Favorite',
  TabItem.settings: 'Settings',
};
Map<TabItem, IconData> tabIcon = {
  TabItem.folder: MyFlutterApp.folder_1,
  TabItem.allVideos: MyFlutterApp.video_library,
  TabItem.favorite: MyFlutterApp.heart,
  TabItem.settings: MyFlutterApp.cog_outline,
};
Map<TabItem, Widget> roots = {
  TabItem.folder: FolderScreen(),
  // TabItem.allVideos: AllVideoList(),
  TabItem.favorite: FavoriteVideoList(),
  TabItem.settings: const SettingsScreen(),
};

Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.folder: Colors.red,
  TabItem.allVideos: Colors.green,
  TabItem.favorite: Colors.blue,
  TabItem.settings: Colors.purple,
};
