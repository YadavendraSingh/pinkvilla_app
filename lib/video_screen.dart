import 'package:flutter/material.dart';
import 'package:pinkvilla_app/model/video_list.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pinkvilla_app/utils/toast_utils.dart';
import 'package:pinkvilla_app/utils/video_card.dart';
import 'dart:convert';
import 'package:visibility_detector/visibility_detector.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  List<VideoListBean> videoList = new List();
  static bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.count(
          crossAxisCount: 1,
          children: List.generate(videoList.length, (index) {
            return Center(
              child: VideoCard(
                video: videoList[index],
              ),
            );
          }),
        ),
      ),
    );
  }


  fetchVideo() async {
    final response = await http.get('https://www.pinkvilla.com/feed/video-test/video-feed.json');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        String res = "{\"video\":" + response.body +"}";
        final jsonResponse = json.decode(res);
        VideoList result = VideoList.fromJson(jsonResponse);
        if (result.video.length > 0) {
          setState(() {
            videoList = result.video;
            _isLoading = false;
          });
        } else {
          showError();
        }
      } on Exception catch (exception) {
        showError();
      } catch (error) {
        showError();
      }
    } else {
      // If the server did not return a 200 OK response,
      showError();
    }
  }

  showError() {
    setState(() {
      _isLoading = false;
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    showToast('No result found');
    //videoList.clear();
  }
}
