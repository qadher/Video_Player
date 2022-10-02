// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../Screens/player_screen/palyer.dart';
import '../controllers/Playlist_controller/playlist_controller.dart';
import '../controllers/favotite_controller/favorite.dart';
import '../controllers/playlist_video_controller/playlist_video_controller.dart';
import '../icons/my_flutter_app_icons.dart';
import '../model/model.dart';
import '../popupmenu/data/menu_list.dart';
import '../popupmenu/model/menu_item.dart';

class CustomListTileVideos extends StatelessWidget {
  CustomListTileVideos(
      {Key? key,
      required this.subtite,
      required this.trailicon,
      required this.index,
      required this.text,
      required this.url,
      required this.path,
      required this.folderName,
      required this.pathList,
      required this.Customkey,
      required this.isFavorite,
      this.voidCallback})
      : super(key: key);
  final String path;
  final bool subtite;
  final bool trailicon;
  final bool isFavorite;
  final int index;
  final String text;
  var url;
  final String folderName;
  List<String> pathList = [];
  // List<String> keyList = [];
  var Customkey;
  final VoidCallback? voidCallback;

  final List<String> _playListNames = [];

  final favController = Get.put(FavoriteController());
  final playlistControl = Get.put(PlaylistController());
  final playlistvideoControl = Get.put(PlaylistVideoController());

  List<String> viewList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlayerScreen(
                    path: path,
                    name: path.split('/').last,
                  )));
        },
        child: SizedBox(
          // color: Colors.grey,
          width: double.infinity,
          // height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: MediaQuery.of(context).size.width * 0.13,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(6.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: url == null ? const AssetImage('assets/images/logo.png') as ImageProvider : MemoryImage(url),
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black45,
                        child: Icon(
                          Icons.play_arrow,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Text(
                          text,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: subtite,
                        child: Text(
                          '$index Videos',
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              // fontSize:  MediaQuery.of(context).size.width * 0.06,
                              color: Colors.grey),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: trailicon,
                    child: PopupMenuButton<MenuItems>(
                      color: const Color.fromARGB(242, 237, 241, 250),
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      onSelected: (item) => onSelected(context, item),
                      itemBuilder: (context) => [
                        ...MenuListItems.itemFirst.map(buildItem).toList(),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<MenuItems> buildItem(MenuItems item) => PopupMenuItem<MenuItems>(
        value: item,
        child: Row(
          children: [
            Icon(
              isFavorite ? item.selectedIcon : item.icon,
              size: 20,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              isFavorite ? item.selectedtext : item.modeltext,
              style: const TextStyle(fontFamily: "Poppins"),
            ),
          ],
        ),
      );

  Future<void> onSelected(BuildContext context, MenuItems item) async {
    switch (item) {
      case MenuListItems.itemFavorite:
        favController.updateFavorites(
            item: Favorites(
              favorite: path,
              thumb: url,
            ),
            path: path);
        break;

      case MenuListItems.itemPLaylist:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.only(top: 6),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Playlists',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(child: GetBuilder<PlaylistController>(builder: (cont) {
                      List<dynamic> playListNames = cont.observablePlaylistBox.values.toList();
                      return ListView.builder(
                          itemCount: playListNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return playListNames.isEmpty
                                ? const Center(
                                    child: Text(
                                      'data',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      playlistvideoControl.updatePlayListVideo(
                                          item: PlayListVideos(path: path, id: playListNames[index].name),
                                          playlist: playListNames[index].name,
                                          path: path);

                                      Navigator.of(context).pop();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: const Color.fromARGB(255, 205, 224, 255),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            playListNames[index].name.toString(),
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.8),
                                              fontFamily: 'Poppins',
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          leading: const Icon(
                                            MyFlutterApp.video_library,
                                            color: Color.fromARGB(255, 23, 68, 138),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                          });
                    }))
                  ],
                ),
              ),
            );
          },
        );
        break;
      case MenuListItems.itemShare:
        // Navigator.of(context).pop();
        await Share.shareFiles([pathList[index]]);
        break;

      default:
    }
  }
}
