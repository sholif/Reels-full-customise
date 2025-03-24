
import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_reels/reels/src/utils/url_checker.dart';
import 'package:video_player/video_player.dart';
import 'components/like_icon.dart';
import 'components/screen_options.dart';
import 'models/reel_model.dart';

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
    required this.swiperController,
    required this.onFavorite,
  }) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  bool _isPaused = false;
  late Timer _timer;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration.zero, () {});

    if (!UrlChecker.isImageUrl(widget.item.url) && UrlChecker.isValid(widget.item.url)) {
      initializePlayer();
    }
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.item.url));
    await _videoPlayerController.initialize();
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
    _chewieController?.dispose();
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
            ? GestureDetector(
          onDoubleTap: () {
            if (!widget.item.isLiked) {
              _liked = true;
              widget.onLike?.call(widget.item.url);
              setState(() {});
            }
          },
          onTap: _togglePlayPause,
          child: Chewie(controller: _chewieController!),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 10),
            Text('Loading...')
          ],
        ),
        if (_liked) const Center(child: LikeIcon()),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ScreenOptions(
              onFavorite: widget.onFavorite,
              onClickMoreBtn: widget.onClickMoreBtn,
              onComment: widget.onComment,
              onFollow: widget.onFollow,
              onLike: widget.onLike,
              onShare: widget.onShare,
              showVerifiedTick: widget.showVerifiedTick,
              item: widget.item,
            ),
            if (widget.showProgressIndicator)
              if(_isPaused)
                Column(
                  children: [
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause, size: 30, color: Colors.white),
                            onPressed: _togglePlayPause,
                          ),
                          SizedBox(width: 20),
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
                    ),
                  ],
                ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }
}
