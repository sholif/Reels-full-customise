import 'dart:developer';

import 'package:flutter/material.dart';

import 'flutte_package/lib/reels_viewer.dart';


class ReelsPage extends StatelessWidget {


  final List<ReelModel> reelsList = [
    ReelModel(
      'https://videos.pexels.com/video-files/17169505/17169505-hd_1080_1920_30fps.mp4',
      'User2',
      isLiked: false,
      isFollow: true,
      isFavorite: true,
      likeCount: 100,
      favoriteCount: 10,
      shareCount: 10,
      profileUrl: 'https://www.w3schools.com/html/pic_trulli.jpg',
      reelDescription: 'Another Awesome Reel!',
      commentList: List.generate(
        5,
            (index) => ReelCommentModel(
          comment: 'Great reel $index!',
          userProfilePic: 'https://www.w3schools.com/html/pic_trulli.jpg',
          userName: 'Commenter $index',
          commentTime: DateTime.now().subtract(Duration(minutes: index * 10)),
        ),
      ),
    ),

    ReelModel(
      'https://videos.pexels.com/video-files/17169505/17169505-hd_1080_1920_30fps.mp4',
      'User2',
      isLiked: true,
      isFollow: true,
      isFavorite: false,
      likeCount: 100,
      favoriteCount: 10,
      shareCount: 10,
      profileUrl: 'https://www.w3schools.com/html/pic_trulli.jpg',
      reelDescription: 'Another Awesome Reel!',
      commentList: List.generate(
        5,
            (index) => ReelCommentModel(
          comment: 'Great reel $index!',
          userProfilePic: 'https://www.w3schools.com/html/pic_trulli.jpg',
          userName: 'Commenter $index',
          commentTime: DateTime.now().subtract(Duration(minutes: index * 10)),
        ),
      ),
    ),
    ReelModel(
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'User2',
      isLiked: true,
      favoriteCount: 10,
      shareCount: 10,
      isFavorite: true,
      likeCount: 100,
      profileUrl: 'https://videos.pexels.com/video-files/17169505/17169505-hd_1080_1920_30fps.mp4',
      reelDescription: 'Another Awesome Reel!',
      commentList: List.generate(
        5,
            (index) => ReelCommentModel(
          comment: 'Great reel $index!',
          userProfilePic: 'https://www.w3schools.com/html/pic_trulli.jpg',
          userName: 'Commenter $index',
          commentTime: DateTime.now().subtract(Duration(minutes: index * 10)),
        ),
      ),
    ),
    ReelModel(
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'User2',
      isLiked: true,
      likeCount: 100,
      favoriteCount: 10,
      shareCount: 10,
      isFavorite: false,
      profileUrl: 'https://www.w3schools.com/html/pic_trulli.jpg',
      reelDescription: 'Another Awesome Reel!',
      commentList: List.generate(
        5,
            (index) => ReelCommentModel(
          comment: 'Great reel $index!',
          userProfilePic: 'https://www.w3schools.com/html/pic_trulli.jpg',
          userName: 'Commenter $index',
          commentTime: DateTime.now().subtract(Duration(minutes: index * 10)),
        ),
      ),
    ),
    ReelModel(
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'User2',
      isLiked: true,
      isFavorite: true,
      likeCount: 100,
      favoriteCount: 10,
      shareCount: 10,
      profileUrl: 'https://www.w3schools.com/html/pic_trulli.jpg',
      reelDescription: 'Another Awesome Reel!',
      commentList: List.generate(
        5,
            (index) => ReelCommentModel(
          comment: 'Great reel $index!',
          userProfilePic: 'https://www.w3schools.com/html/pic_trulli.jpg',
          userName: 'Commenter $index',
          commentTime: DateTime.now().subtract(Duration(minutes: index * 10)),
        ),
      ),
    ),
    ReelModel(
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'User2',
      isLiked: true,
      isFavorite: false,
      likeCount: 100,
      favoriteCount: 10,
      shareCount: 10,
      profileUrl: 'https://www.w3schools.com/html/pic_trulli.jpg',
      reelDescription: 'Another Awesome Reel!',
      commentList: List.generate(
        5,
            (index) => ReelCommentModel(
          comment: 'Great reel $index!',
          userProfilePic: 'https://www.w3schools.com/html/pic_trulli.jpg',
          userName: 'Commenter $index',
          commentTime: DateTime.now().subtract(Duration(minutes: index * 10)),
        ),
      ),
    ),
    ReelModel(
      'https://www.w3schools.com/html/mov_bbb.mp4',
      'User2',
      isLiked: false,
      isFavorite: true,
      likeCount: 100,
      favoriteCount: 10,
      shareCount: 10,
      profileUrl: 'https://www.w3schools.com/html/pic_trulli.jpg',
      reelDescription: 'Another Awesome Reel!',
      commentList: List.generate(
        5,
            (index) => ReelCommentModel(
          comment: 'Great reel $index!',
          userProfilePic: 'https://www.w3schools.com/html/pic_trulli.jpg',
          userName: 'Commenter $index',
          commentTime: DateTime.now().subtract(Duration(minutes: index * 10)),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reels Page')),
      body: Stack(
        children: [
          ReelsViewer(

            reelsList: reelsList,
            showProgressIndicator: true,
            showVerifiedTick: false,
            showAppbar: true,
            onShare: (p0) {

              log(">>>>>>>>>>>>>>>>>> SHare");
            },
            onLike: (p0) {
              log(">>>>>>>>>>>>>>>>>> like");
            },
            onComment: (p0) {

              log(">>>>>>>>>>>>>>>>>> =comment");
            },
            onFollow: () {
              log(">>>>>>>>>>>>>>>>>> follow");
            },
          ),
        ],
      ),
    );
  }
}
