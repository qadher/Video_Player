import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sizer/sizer.dart';
import 'package:video_player/provider/theme_provider.dart';

import 'Screens/navigation_screens/favorite.dart';
import 'Screens/navigation_screens/folders.dart';
import 'Screens/navigation_screens/navigation.dart';
import 'Screens/navigation_screens/playlist.dart';
import 'Screens/navigation_screens/playlist_inner.dart';
import 'Screens/navigation_screens/settings.dart';
import 'Screens/navigation_screens/video_list.dart';
import 'Screens/onboarding/onboarding.dart';
import 'Screens/splash/splash.dart';
import 'bottom_navigation/screenhome.dart';
import 'model/model.dart';

const first_time = 'UserLogedIn';
List<String> pathListMain = [];

const videoBox = 'boxVideos';
const favoriteBox = 'boxFavorites';
const playlistBox = 'boxPlaylist';
const playlistVideoBox = 'boxPlaylistVideo';
bool restarting = true;

void main() async {
  restarting = true;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Color.fromARGB(255, 23, 68, 138), // status bar color
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.light, //status barIcon Brightness
    // systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
    // systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(VideosAdapter());
  Hive.registerAdapter(FavoritesAdapter());
  Hive.registerAdapter(PlayListAdapter());
  Hive.registerAdapter(PlayListVideosAdapter());

  await Hive.openBox<Videos>(videoBox);
  await Hive.openBox<Favorites>(favoriteBox);
  await Hive.openBox<PlayList>(playlistBox);
  await Hive.openBox<PlayListVideos>(playlistVideoBox);
  requestPermission();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
  await Hive.openBox('pathlist');

  runApp(const MyApp());
}

void requestPermission() async {
  var requestStatus = await Permission.storage.status;
  if (requestStatus.isDenied) {
    Permission.storage.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return Sizer(builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            title: 'Video Player',
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page:() =>const SplashScreen()),
              GetPage(name: '/onboarding', page:() =>const OnBoardingScreen()),
              GetPage(name: '/home', page:() => ScreenHome(isSatrting: 'yes',)),
              GetPage(name: '/fvorites', page:() => FavoriteVideoList()),
              GetPage(name: '/floder', page:() => FolderScreen()),
              GetPage(name: '/video', page:() => VideoList(pathList: [],folderName: '',)),
              GetPage(name: '/playlist', page:() => PlayListScreen()),
              GetPage(name: '/playlistVideos', page:() => PlayListScreenInner(name: '',)),
              GetPage(name: '/settings', page:() =>const SettingsScreen()),
            ],
          );
        });
      },
    );
  }
}
