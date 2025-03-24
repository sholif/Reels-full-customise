import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:new_flutter_reels/reels/src/components/cemra_screen.dart';
import 'package:new_flutter_reels/reels/src/models/reel_comment_model.dart';
import 'package:new_flutter_reels/reels/src/models/reel_model.dart';
import 'package:new_flutter_reels/reels/src/reels_viewer.dart';
class ReelsPage extends StatelessWidget {


  final List<ReelModel> reelsList = [
    ReelModel(
      'https://videos.pexels.com/video-files/17169505/17169505-hd_1080_1920_30fps.mp4',
      'User1',
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
      'User3',
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
      'User4',
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
      'User5',
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
      'User6',
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
      'User7',
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
      appBar: AppBar(title: Text('Reels')),
      body: Stack(
        children: [
          ReelsViewer(

            onFavorite: (){
              log(">>>>>>>>>>>>>>>>>> Favorite");
            },
            reelsList: reelsList,
            showProgressIndicator: true,
            showVerifiedTick: false,
            showAppbar: true,
            onCamera: (){

                  showCameraOptions(context);
              log(">>>>>>>>>>>>>>>>>> cemera");
            },
            onSearch: (){
              log(">>>>>>>>>>>>>>>>>> Search");
            },
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
