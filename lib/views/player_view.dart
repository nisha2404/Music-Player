import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';
import '../controllers/player_controller.dart';
import 'card_view.dart';

class PlayerView extends StatelessWidget {
  final List<SongModel> data;
  PlayerView({super.key, required this.data});

  final controller = Get.find<PlayerController>();
  //create a CardController
  SwipeableCardSectionController cardController =
      SwipeableCardSectionController();

  int counter = 1;

  @override
  build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Row(children: [
                  Text(controller.position.value,
                      style:
                          GetTextTheme.sf14Regular.copyWith(color: whiteColor)),
                  Expanded(
                      child: Slider(
                          min: const Duration(seconds: 0).inSeconds.toDouble(),
                          max: controller.max.value,
                          value: controller.value.value,
                          onChanged: (newValue) {
                            controller
                                .changeDurationToSeconds(newValue.toInt());
                            newValue = newValue;
                          },
                          inactiveColor: bgColor,
                          thumbColor: sliderColor,
                          activeColor: sliderColor)),
                  Text(controller.duration.value,
                      style:
                          GetTextTheme.sf14Regular.copyWith(color: whiteColor)),
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () => {
                            cardController.triggerSwipeLeft(),
                            // controller.playSong(
                            //     data[controller.playIndex.value - 1].uri,
                            //     controller.playIndex.value - 1,
                            //     data[controller.playIndex.value])
                          },
                      icon: Icon(Icons.skip_previous_rounded,
                          size: 30.sp, color: whiteColor)),
                  Obx(
                    () => CircleAvatar(
                      radius: 30.r,
                      backgroundColor: whiteColor,
                      child: Transform.scale(
                        scale: 2,
                        child: IconButton(
                            splashRadius: 20.r,
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
                                color: bgDarkColor)),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () => {
                            cardController.triggerSwipeRight(),
                            // controller.playSong(
                            //     data[controller.playIndex.value + 1].uri,
                            //     controller.playIndex.value + 1,
                            //     data[controller.playIndex.value])
                          },
                      icon: Icon(Icons.skip_next_rounded,
                          size: 30.sp, color: whiteColor)),
                ],
              )
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://w0.peakpx.com/wallpaper/630/252/HD-wallpaper-violin-fall-forest-instrument-music-musical-nature-thumbnail.jpg"),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SwipeableCardsSection(
                  cardController: cardController,
                  context: context,
                  cardHeightMiddleMul: 0.6,
                  cardHeightTopMul: 0.72,
                  cardHeightBottomMul: 0.67,
                  //add the first 3 cards
                  items: [
                    CardView(text: "First card", data: data),
                    CardView(text: "Second card", data: data),
                    CardView(text: "Third card", data: data),
                  ],
                  onCardSwiped: (dir, index, widget) {
                    //Add the next card
                    if (counter <= data.length) {
                      cardController
                          .addItem(CardView(text: "Card $counter", data: data));
                    }

                    if (dir == Direction.left) {
                      if (controller.playIndex.value > 0) {
                        counter--;
                        controller.playSong(
                            data[controller.playIndex.value - 1].uri,
                            controller.playIndex.value - 1,
                            data[controller.playIndex.value - 1]);
                      }
                    } else if (dir == Direction.right) {
                      if (controller.playIndex.value < (data.length - 1)) {
                        counter++;
                        controller.playSong(
                            data[controller.playIndex.value + 1].uri,
                            controller.playIndex.value + 1,
                            data[controller.playIndex.value + 1]);
                      }
                    }
                  },
                ),
                // Container(
                //   margin: const EdgeInsets.symmetric(vertical: 20.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       FloatingActionButton(
                //         heroTag: "1",
                //         child: const Icon(Icons.chevron_left),
                //         onPressed: () => cardController.triggerSwipeLeft(),
                //       ),
                //       FloatingActionButton(
                //         heroTag: "2",
                //         child: const Icon(Icons.chevron_right),
                //         onPressed: () => cardController.triggerSwipeRight(),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        )
        //      Container(
        //   height: AppServices.getScreenHeight(context),
        //   width: AppServices.getScreenWidth(context),
        //   decoration: const BoxDecoration(
        //       image: DecorationImage(
        //           image: NetworkImage(
        //               "https://i.pinimg.com/564x/75/a7/05/75a7056811afbbdf0c24e730d33565da.jpg"),
        //           fit: BoxFit.cover)),
        //   child: GlassMorph(
        //     blur: 4,
        //     opacity: 0.2,
        //     image: "assets/images/stars.png",
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           height: 200.sp,
        //           width: 200.sp,
        //           alignment: Alignment.center,
        //           decoration: BoxDecoration(
        //               border: Border.all(color: whiteColor),
        //               image: const DecorationImage(
        //                   image: NetworkImage(
        //                       "https://i.pinimg.com/564x/75/a7/05/75a7056811afbbdf0c24e730d33565da.jpg"),
        //                   fit: BoxFit.cover),
        //               shape: BoxShape.circle),
        //           child: Stack(
        //             alignment: Alignment.center,
        //             children: [
        //               ClipRRect(
        //                 borderRadius: BorderRadius.circular(1000.r),
        //                 child: QueryArtworkWidget(
        // id: data[controller.playIndex.value].id,
        //                   type: ArtworkType.AUDIO,
        //                   artworkHeight: double.infinity,
        //                   artworkWidth: double.infinity,
        //                   nullArtworkWidget: const SizedBox(),
        //                 ),
        //               ),
        //               Container(
        //                 height: 50.sp,
        //                 width: 50.sp,
        //                 decoration: const BoxDecoration(
        //                   image: DecorationImage(
        //                       image: NetworkImage(
        //                           "https://i.pinimg.com/564x/75/a7/05/75a7056811afbbdf0c24e730d33565da.jpg"),
        //                       fit: BoxFit.cover),
        //                   shape: BoxShape.circle,
        //                 ),
        //               )
        //             ],
        //           ),
        //         )
        //             .animate(onComplete: (v) => v.repeat())
        //             .rotate(duration: const Duration(milliseconds: 5000))
        //       ],
        //     ),
        //   ),
        // )
        );
  }
}
