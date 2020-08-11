class VideoList {
  List<VideoListBean> video;

  VideoList({this.video});

 factory VideoList.fromJson(Map<String, dynamic> json) => new VideoList(
      video:(json['video'] as List)!=null?(json['video'] as List).map((i) => VideoListBean.fromJson(i)).toList():null
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video'] = this.video != null?this.video.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class VideoListBean {
  String url;
  String title;
  int comment_count;
  int like_count;
  int share_count;
  UserBean user;

  VideoListBean({this.url, this.title, this.comment_count, this.like_count, this.share_count, this.user});

  VideoListBean.fromJson(Map<String, dynamic> json) {    
    this.url = json['url'];
    this.title = json['title'];
    this.comment_count = json['comment-count'];
    this.like_count = json['like-count'];
    this.share_count = json['share-count'];
    this.user = json['user'] != null ? UserBean.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['title'] = this.title;
    data['comment-count'] = this.comment_count;
    data['like-count'] = this.like_count;
    data['share-count'] = this.share_count;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class UserBean {
  String name;
  String headshot;

  UserBean({this.name, this.headshot});

  UserBean.fromJson(Map<String, dynamic> json) {    
    this.name = json['name'];
    this.headshot = json['headshot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['headshot'] = this.headshot;
    return data;
  }
}
