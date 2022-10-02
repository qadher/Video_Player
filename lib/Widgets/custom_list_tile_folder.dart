import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

import '../Screens/navigation_screens/video_list.dart';
import '../icons/my_flutter_app_icons.dart';
import '../main.dart';
import '../model/model.dart';

class CustomListTileFolder extends StatelessWidget {
  CustomListTileFolder(
      {Key? key,
      required this.subtite,
      required this.trailicon,
      required this.index,
      required this.text,
      required this.folderName,
      required this.pathList})
      : super(key: key);

  final bool subtite;
  final bool trailicon;
  final int index;
  final String text;
  final String folderName;
  List<String> pathList = [];


  List<String> viewList = [];

  List<String> _pathList = [];

  List thumbs = [];

  var boxVideos = Hive.box<Videos>(videoBox);

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        onTap: ()async {
          // Get.toNamed('/video' ,arguments: [folderName,pathList]);
          Get.to(VideoList(folderName: folderName, pathList: pathList));
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) =>  VideoList(folderName: folderName, pathList: pathList)));
          // getFiles();
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
                  Icon(
                    MyFlutterApp.folder,
                    size: MediaQuery.of(context).size.width * 0.11,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Text(
                          text,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: subtite,
                        child: Text(
                          '${index} Videos',
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
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
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
}
