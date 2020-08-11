import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoItem extends StatefulWidget {
  String url;
  VideoItem(this.url);

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    //_controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.initialized?Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: VisibilityDetector(
              key: Key(widget.url),
              child:  VideoPlayer(_controller),
              onVisibilityChanged: (VisibilityInfo info) {
                var visiblePercentage = info.visibleFraction * 100;
                if(visiblePercentage>=90){
                  var vi = visiblePercentage;
                  _controller.play();
                }
                else{
                  _controller.pause();
                }
              },
            ),

          ),
          Center(
            child: GestureDetector(
              onTap: (){_controller.value.isPlaying ? _controller.pause() : _controller.play();},
            ),
          )
        ],
      ):Container(),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  playPause(){
    _controller.play();
  }
}


