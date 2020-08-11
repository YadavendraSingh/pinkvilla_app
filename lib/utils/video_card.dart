import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pinkvilla_app/model/video_list.dart';
import 'package:pinkvilla_app/player/video_item.dart';
class VideoCard extends StatelessWidget {
  const VideoCard({Key key, this.video}) : super(key: key);

  final VideoListBean video;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(child: VideoItem(video.url),
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: Column(
                children: [
                  Icon(Icons.favorite, color: Colors.white,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(video.like_count.toString()),
                  ),
                  Icon(Icons.share, color: Colors.white,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(video.share_count.toString()),
                  ),
                  Icon(Icons.comment, color: Colors.white,),
                  Text(video.comment_count.toString()),
                ],
              ),
          ),
          Positioned(
            bottom: 10,
            left: 8,
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(video.user.headshot),
                      backgroundColor: Colors.transparent,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(video.user.name,),
                    ),

                  ],
                ),
                SizedBox(
                  width: 100,
                  child: Text(video.title, textAlign: TextAlign.left,),
                ),
              ],
            ),
          ),

        ],
      )
    );
  }

}