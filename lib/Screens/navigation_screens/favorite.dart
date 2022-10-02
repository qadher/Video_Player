import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../Widgets/custom_appbar.dart';
import '../../Widgets/custom_list_tile_video.dart';
import '../../controllers/favotite_controller/favorite.dart';
import '../../main.dart';

class FavoriteVideoList extends StatelessWidget {
  FavoriteVideoList({Key? key}) : super(key: key);

  final FavoriteController favcontroller = Get.put(FavoriteController());
  final List<String> _pathList = [];
  List thumbs = [];
  List<String> viewList = [];
  bool isFavorite = true;
  @override
  var key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titletext: 'Favorites',
      ),
      body: GetBuilder<FavoriteController>(builder: (cont) {
        List<dynamic> videoPaths = cont.observableFavoriteBox.values.toList();
        for (var i = 0; i < videoPaths.length; i++) {
          _pathList.add(videoPaths[i].favorite);
        }
        return ListView.builder(
          itemCount: videoPaths.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomListTileVideos(
              path: videoPaths[index].favorite,
              subtite: false,
              trailicon: true,
              index: index,
              text: videoPaths[index].favorite.split('/').last,
              url: videoPaths[index].thumb,
              folderName: '',
              pathList: _pathList,
              Customkey: key,
              isFavorite: isFavorite,
            );
          },
        );
      }),
    );
  }
}
