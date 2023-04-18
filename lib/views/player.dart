import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/base_getters.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/constants/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  Player({super.key, required this.data});
  final List<SongModel> data;

  final controller = Get.find<PlayerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(children: [
            Expanded(
                child: Obx(() => Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 300.sp,
                      width: 300.sp,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: QueryArtworkWidget(
                        id: data[controller.playIndex.value].id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: double.infinity,
                        artworkWidth: double.infinity,
                        nullArtworkWidget: Icon(Icons.music_note,
                            size: 48.sp, color: whiteColor),
                      ),
                    ))),
            AppServices.addHeight(12.h),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(8.sp),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16.r)),
                        color: whiteColor),
                    child: Obx(
                      () => Column(
                        children: [
                          Text(
                              data[controller.playIndex.value].displayNameWOExt,
                              style: GetTextTheme.sf24Bold,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                          AppServices.addHeight(12.h),
                          Text(data[controller.playIndex.value].artist!,
                              style: GetTextTheme.sf20Regular),
                          AppServices.addHeight(12.h),
                          Obx(
                            () => Row(children: [
                              Text(controller.position.value,
                                  style: GetTextTheme.sf14Regular
                                      .copyWith(color: bgDarkColor)),
                              Expanded(
                                  child: Slider(
                                      min: const Duration(seconds: 0)
                                          .inSeconds
                                          .toDouble(),
                                      max: controller.max.value,
                                      value: controller.value.value,
                                      onChanged: (newValue) {
                                        controller.changeDurationToSeconds(
                                            newValue.toInt());
                                        newValue = newValue;
                                      },
                                      inactiveColor: bgColor,
                                      thumbColor: sliderColor,
                                      activeColor: sliderColor)),
                              Text(controller.duration.value,
                                  style: GetTextTheme.sf14Regular
                                      .copyWith(color: bgDarkColor)),
                            ]),
                          ),
                          AppServices.addHeight(12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () => {
                                        controller.playSong(
                                            data[controller.playIndex.value - 1]
                                                .uri,
                                            controller.playIndex.value - 1,
                                            data[controller.playIndex.value])
                                      },
                                  icon: Icon(Icons.skip_previous_rounded,
                                      size: 40.sp, color: bgDarkColor)),
                              Obx(
                                () => CircleAvatar(
                                  radius: 35.r,
                                  backgroundColor: bgDarkColor,
                                  child: Transform.scale(
                                    scale: 2.5,
                                    child: IconButton(
                                        onPressed: () {
                                          if (controller.isPlaying.value) {
                                            controller.audioPlayer.pause();
                                            controller.isPlaying(false);
                                          } else {
                                            controller.audioPlayer.play();
                                            controller.isPlaying(true);
                                          }
                                        },
                                        icon: Icon(
                                            controller.isPlaying.value
                                                ? Icons.pause
                                                : Icons.play_arrow_rounded,
                                            color: whiteColor)),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () => controller.playSong(
                                      data[controller.playIndex.value + 1].uri,
                                      controller.playIndex.value + 1,
                                      data[controller.playIndex.value]),
                                  icon: Icon(Icons.skip_next_rounded,
                                      size: 40.sp, color: bgDarkColor)),
                            ],
                          )
                        ],
                      ),
                    )))
          ])),
    );
  }
}
