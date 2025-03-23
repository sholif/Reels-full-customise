import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_reels/flutte_package/lib/reels_viewer.dart';
import 'package:new_flutter_reels/flutte_package/lib/src/utils/url_checker.dart';
import 'package:video_player/video_player.dart';
import 'components/like_icon.dart';
import 'components/screen_options.dart';

class ReelsPage extends StatefulWidget {
  final ReelModel item;
  final bool showVerifiedTick;

  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;
  final Function()? onFavorite;
  final SwiperController swiperController;
  final bool showProgressIndicator;

  const ReelsPage({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.showProgressIndicator = true,
    required this.swiperController,required this.onFavorite,  }) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}
class _ReelsPageState extends State<ReelsPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  bool _isPaused = false; // To track the pause/play state
  late Timer _timer;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (!UrlChecker.isImageUrl(widget.item.url) && UrlChecker.isValid(widget.item.url)) {
      initializePlayer();
    }
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.item.url));
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: false,
    );
    setState(() {});

    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position == _videoPlayerController.value.duration) {
        widget.swiperController.next();
      }
    });

    // Set up the timer to update the progress every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_videoPlayerController.value.isPlaying) {
        setState(() {
          _currentPosition = _videoPlayerController.value.position;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _videoPlayerController.dispose();
    if (_chewieController != null) {
      _chewieController!.dispose();
    }
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        _isPaused = true;
      } else {
        _videoPlayerController.play();
        _isPaused = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return getVideoView();
  }

  Widget getVideoView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
            ? FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onDoubleTap: () {
                if (!widget.item.isLiked) {
                  _liked = true;
                  if (widget.onLike != null) {
                    widget.onLike!(widget.item.url);
                  }
                  setState(() {});
                }
              },
              onTap: _togglePlayPause, // Toggle play/pause on tap
              child: Chewie(
                controller: _chewieController!,
              ),
            ),
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 10),
            Text('Loading...')
          ],
        ),
        if (_liked)
          const Center(
            child: LikeIcon(),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            ScreenOptions(

              onFavorite:widget.onFavorite ,
              onClickMoreBtn: widget.onClickMoreBtn,
              onComment: widget.onComment,
              onFollow: widget.onFollow,
              onLike: widget.onLike,
              onShare: widget.onShare,
              showVerifiedTick: widget.showVerifiedTick,
              item: widget.item,
            ),


            if (widget.showProgressIndicator)


              Column(
                children: [
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Pause/Play Icon
                            IconButton(
                              icon: Icon(
                                _isPaused ? Icons.play_arrow : Icons.pause,
                                size: 30,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_isPaused) {
                                    _videoPlayerController.play();
                                  } else {
                                    _videoPlayerController.pause();
                                  }
                                  _isPaused = !_isPaused;
                                });
                              },
                            ),
                            SizedBox(width: 20),
                            // Slider
                            Expanded(
                              child: Slider(
                                activeColor: Colors.red,
                                value: _currentPosition.inSeconds.toDouble(),
                                min: 0,
                                max: _videoPlayerController.value.duration.inSeconds.toDouble(),
                                onChanged: (double value) {
                                  setState(() {
                                    _currentPosition = Duration(seconds: value.toInt());
                                    _videoPlayerController.seekTo(_currentPosition);
                                  });
                                },
                              ),
                            ),
                            Text(
                              _formatDuration(_videoPlayerController.value.duration - _currentPosition),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              )


          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
















//
// class VideoPlayerWidget extends StatefulWidget {
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _videoPlayerController;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController = VideoPlayerController.network('your_video_url')
//       ..initialize().then((_) {
//         setState(() {});
//         _videoPlayerController.play();
//       });
//
//     // Set up a timer to update the progress periodically
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_videoPlayerController.value.isPlaying) {
//         setState(() {});
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     _videoPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           bottom: 0,
//           width: MediaQuery.of(context).size.width,
//           child: VideoProgressIndicator(
//             _videoPlayerController,
//             allowScrubbing: false,
//             colors: const VideoProgressColors(
//               backgroundColor: Colors.red,
//               bufferedColor: Colors.red,
//               playedColor: Colors.red,
//             ),
//           ),
//         ),
//         // Add your other widgets here
//       ],
//     );
//   }
// }
