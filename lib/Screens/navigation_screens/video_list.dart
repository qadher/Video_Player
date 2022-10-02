

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/custom_appbar.dart';
import '../../Widgets/custom_list_tile_video.dart';
import '../../controllers/video_controller/video_controller.dart';

class VideoList extends StatelessWidget {
  VideoList({Key? key, required this.folderName, required this.pathList})
      : super(key: key);
  final String folderName ;
  List<String> pathList = [];



  List<String> _pathList = [];
  List thumbs = [];
  bool? isFavorite;
  var key;
  

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titletext: folderName,
      ),
      body: GetBuilder<VideoController>(
        
        builder: (cont) {
          List<dynamic> videoPaths = cont.observableVideoBox.values.toList();
          
          for (var i = 0; i < videoPaths.length; i++) {
            List<String> video = videoPaths[i].paths.split('/').toList();
            if (video.contains(folderName)) {
              //  keyList.add(videoPaths[i].key);
              isFavorite = videoPaths[i].fav;
              // key = videoPaths[i].key;
              _pathList.add(videoPaths[i].paths);
              thumbs.add(videoPaths[i].thumb);
            }
  
          }
          return ListView.builder(
            itemCount: _pathList.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomListTileVideos(
                path: _pathList[index],
                subtite: false,
                trailicon: true,
                index: index,
                text: _pathList[index].split('/').last,
                url: thumbs[index],
                folderName: '',
                pathList: _pathList,
                Customkey: key,
                isFavorite: isFavorite!,
              );
            },
          );
        },
      ),
    
    );
  }
}
