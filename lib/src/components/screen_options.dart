

import 'package:flutter/material.dart';
import 'package:new_flutter_reels/src/components/user_profile_image.dart';
import 'package:new_flutter_reels/src/models/reel_model.dart';
import 'package:new_flutter_reels/src/utils/convert_numbers_to_short.dart';
import 'comment_bottomsheet.dart';

class ScreenOptions extends StatelessWidget {
  final ReelModel item;
  final bool showVerifiedTick;

  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;
  final Function()? onFavorite;


  const ScreenOptions({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    required this.onFavorite,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // User information and description
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 110),
                    Row(
                      children: [
                        if (item.profileUrl != null)
                          UserProfileImage(profileUrl: item.profileUrl!),
                        if (item.profileUrl == null)
                          const CircleAvatar(
                            child: Icon(Icons.person, size: 18),
                            radius: 16,
                          ),
                        const SizedBox(width: 6),
                        Text(
                          item.userName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        if (showVerifiedTick)
                          const Icon(
                            Icons.verified,
                            size: 15,
                            color: Colors.white,
                          ),
                        if (onFollow != null)
                          GestureDetector(
                            onTap: onFollow,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: item.isFollow? Colors.red :Colors.transparent,
                                border: Border.all(
                                  color: item.isFollow? Colors.transparent :Colors.red,
                                )
                              ),
                              child: Center(
                                child: Text(
                                 item.isFollow?"Un Follow":"Follow",
                                  style: TextStyle(
                                    color: item.isFollow? Colors.white:Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (item.reelDescription != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          item.reelDescription!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    if (item.musicName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.music_note, size: 15, color: Colors.white),
                            Text(
                              'Original Audio - ${item.musicName}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Action buttons (like, comment, share, favorite, more)
              Column(
                children: [
                  // Like button
                  IconButton(
                    icon: Icon(
                      item.isLiked ? Icons.favorite_rounded : Icons.favorite_outline,
                      color: item.isLiked ? Colors.red : Colors.white,size:35 ,
                    ),
                    onPressed: () => onLike?.call(item.url),
                  ),
                  Text(
                    NumbersToShort.convertNumToShort(item.likeCount),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),

                  // Comment button
                  IconButton(
                    icon: const Icon(Icons.comment_rounded, color: Colors.white ,size:35),
                    onPressed: () {
                      if (onComment != null) {
                        showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (ctx) => CommentBottomSheet(
                            commentList: item.commentList ?? [],
                            onComment: onComment,
                          ),
                        );
                      }
                    },
                  ),
                  Text(
                    NumbersToShort.convertNumToShort(item.commentList?.length ?? 0),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),


                  // Favorite button (fixed)
                  IconButton(
                    icon: Icon(
                      item.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                      color: item.isFavorite ? Colors.red : Colors.white,size: 35,
                    ),
                    onPressed: onFavorite,
                  ),
                  Text(
                    NumbersToShort.convertNumToShort(item.favoriteCount),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),



                  // Share button
                  if (onShare != null)
                    InkWell(
                      onTap: () => onShare!(item.url),
                      child: Transform(
                        transform: Matrix4.rotationZ(0),
                        child: const Icon(Icons.share, color: Colors.white,size:35),
                      ),
                    ),
                  Text(
                    NumbersToShort.convertNumToShort(item.shareCount),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),



                  // More options button
                  if (onClickMoreBtn != null)
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white,size:35),
                      onPressed: onClickMoreBtn,
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
