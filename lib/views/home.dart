// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/constants/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/views/player_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  Home({super.key});

  var controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          leading: const Icon(Icons.sort_rounded, color: whiteColor),
          title: Text("Songs", style: GetTextTheme.sf18Bold),
          actions: [
            IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.search, color: whiteColor))
          ],
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No data found"));
              } else {
                // print(snapshot.data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!
                          .where((element) =>
                              element.isMusic == true &&
                              element.displayName.endsWith(".mp3") &&
                              element.album != "<unknown>")
                          .toList()
                          .length,
                      itemBuilder: (context, i) {
                        final song = snapshot.data!
                            .where((element) =>
                                element.isMusic == true &&
                                element.displayName.endsWith(".mp3") &&
                                element.album != "<unknown>")
                            .toList()[i];
                        final songs = snapshot.data!
                            .where((e) =>
                                e.isMusic == true &&
                                e.displayName.endsWith(".mp3") &&
                                e.album != "<unknown>")
                            .toList();

                        return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Obx(
                              () => ListTile(
                                onTap: () => {
                                  print(song.getMap),
                                  Get.to(() => PlayerView(data: songs),
                                      transition: Transition.downToUp),
                                  // Get.to(Player(data: songs),
                                  //     transition: Transition.downToUp),
                                  {controller.playSong(song.uri, i, song)}
                                },
                                tileColor: bgColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                title: Text(song.displayName,
                                    style: GetTextTheme.sf16Bold
                                        .copyWith(color: whiteColor)),
                                subtitle: Text(song.artist!,
                                    style: GetTextTheme.sf12Regular
                                        .copyWith(color: whiteColor)),
                                leading: QueryArtworkWidget(
                                  id: song.id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: Icon(Icons.music_note,
                                      color: whiteColor, size: 32.sp),
                                ),
                                trailing: controller.playIndex.value == i &&
                                        controller.isPlaying.value
                                    ? Icon(Icons.play_arrow,
                                        color: whiteColor, size: 36.sp)
                                    : null,
                              ),
                            ));
                      }),
                );
              }
            }));
  }
}
