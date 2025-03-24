

import 'package:new_flutter_reels/reels/src/models/reel_comment_model.dart';

class ReelModel {
  final String? id;
  final String url;
  final bool isLiked;
  final bool isFollow;
  final bool isFavorite;
  final int likeCount;
  final int favoriteCount;
  final int shareCount;
  final String userName;
  final String? profileUrl;
  final String? reelDescription;
  final String? musicName;
  final List<ReelCommentModel>? commentList;
  ReelModel(
    this.url,
    this.userName, {
    this.id,
    this.isFollow = false,
    this.isLiked = false,
    this.isFavorite = false,
    this.favoriteCount = 0,
    this.likeCount = 0,
    this.shareCount = 0,
    this.profileUrl,
    this.reelDescription,
    this.musicName,
    this.commentList,
  });
}
