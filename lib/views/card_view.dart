import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_player/views/glass_morph.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../constants/colors.dart';
import '../controllers/player_controller.dart';

class CardView extends StatelessWidget {
  final List<SongModel> data;
  CardView({Key? key, this.text = "Card View", required this.data})
      : super(key: key);
  final String text;

  final controller = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Material(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://w0.peakpx.com/wallpaper/630/252/HD-wallpaper-violin-fall-forest-instrument-music-musical-nature-thumbnail.jpg"),
                        fit: BoxFit.fill)),
                child: GlassMorph(
                    blur: 3,
                    opacity: 0.2,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 160.sp,
                            width: 160.sp,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: whiteColor),
                                image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8BYzcEAnma12Oci2yxzXV0FkBrn6JgLj6UA&usqp=CAU"),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(1000.r),
                                  child: QueryArtworkWidget(
                                    id: data[controller.playIndex.value].id,
                                    type: ArtworkType.AUDIO,
                                    artworkHeight: double.infinity,
                                    artworkWidth: double.infinity,
                                    nullArtworkWidget: const SizedBox(),
                                  ),
                                ),
                                Container(
                                  height: 40.sp,
                                  width: 40.sp,
                                  decoration: const BoxDecoration(
                                    color: bgDarkColor,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
          SizedBox.expand(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data[controller.playIndex.value].displayNameWOExt,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700)),
                    const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    Text(data[controller.playIndex.value].artist!,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.white)),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
