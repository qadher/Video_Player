import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../Widgets/custom_appbar.dart';
import '../../Widgets/custom_list_tile_folder.dart';
import '../../controllers/video_controller/video_controller.dart';

class FolderScreen extends StatelessWidget {
  FolderScreen({Key? key}) : super(key: key);


  List<String> _pathList = [];
  List<String> folderName = [];
  List<String> folderNameFinal = [];
  

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titletext: 'Folder',
      ),
      body: GetBuilder<VideoController>(
        
        builder: (cont) {
          List<dynamic> videoPaths = cont.observableVideoBox.values.toList();
          // print('ivde aanooov  ${videoPaths}');


        
          for (var i = 0; i < videoPaths.length; i++) {
            // List<String> pathall = videoPaths[i].paths;

            _pathList.add(videoPaths[i].paths);
            List<String> folder = videoPaths[i].paths.split('/').toList();
            String name = folder[folder.length - 2];
            folderName.add(name);
          }
          folderNameFinal = folderName.toSet().toList();
          folderNameFinal.remove('0');

          return ListView.builder(
            itemCount: folderNameFinal.length,
            itemBuilder: (context, index) {
              // print('name finalll====$videoPaths');
              return CustomListTileFolder(
                subtite: false,
                trailicon: false,
                index: index,
                text: folderNameFinal[index],
                folderName: folderNameFinal[index],
                pathList: _pathList,
              );
            },
          );
        },
      ),
    );
  }
}
