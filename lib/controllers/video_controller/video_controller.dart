


import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Repository/video_repository/video_repository.dart';
import '../../model/model.dart';


class VideoController extends GetxController{


    final Box observableVideoBox = VideoRepository.getVideoBox();
    clearBox(){
      observableVideoBox.clear();
    }

    updateVideo({required int index, required Videos path}){
      

    observableVideoBox.put( index,path);
    update();
  }
  
}