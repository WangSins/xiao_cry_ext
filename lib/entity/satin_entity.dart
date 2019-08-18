class SatinEntity {
  int code;
  String msg;
  List<SatinData> data;

  SatinEntity({this.code, this.msg, this.data});

  SatinEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<SatinData>();
      json['data'].forEach((v) {
        data.add(new SatinData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SatinData {
  String type;
  String text;
  String username;
  String uid;
  String header;
  int comment;
  String topCommentsVoiceuri;
  String topCommentsContent;
  String topCommentsHeader;
  String topCommentsName;
  String passtime;
  int soureid;
  int up;
  int down;
  int forward;
  String image;
  String gif;
  String thumbnail;
  String video;

  SatinData(
      {this.type,
      this.text,
      this.username,
      this.uid,
      this.header,
      this.comment,
      this.topCommentsVoiceuri,
      this.topCommentsContent,
      this.topCommentsHeader,
      this.topCommentsName,
      this.passtime,
      this.soureid,
      this.up,
      this.down,
      this.forward,
      this.image,
      this.gif,
      this.thumbnail,
      this.video});

  SatinData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    text = json['text'];
    username = json['username'];
    uid = json['uid'];
    header = json['header'];
    comment = json['comment'];
    topCommentsVoiceuri = json['top_commentsVoiceuri'];
    topCommentsContent = json['top_commentsContent'];
    topCommentsHeader = json['top_commentsHeader'];
    topCommentsName = json['top_commentsName'];
    passtime = json['passtime'];
    soureid = json['soureid'];
    up = json['up'];
    down = json['down'];
    forward = json['forward'];
    image = json['image'];
    gif = json['gif'];
    thumbnail = json['thumbnail'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['text'] = this.text;
    data['username'] = this.username;
    data['uid'] = this.uid;
    data['header'] = this.header;
    data['comment'] = this.comment;
    data['top_commentsVoiceuri'] = this.topCommentsVoiceuri;
    data['top_commentsContent'] = this.topCommentsContent;
    data['top_commentsHeader'] = this.topCommentsHeader;
    data['top_commentsName'] = this.topCommentsName;
    data['passtime'] = this.passtime;
    data['soureid'] = this.soureid;
    data['up'] = this.up;
    data['down'] = this.down;
    data['forward'] = this.forward;
    data['image'] = this.image;
    data['gif'] = this.gif;
    data['thumbnail'] = this.thumbnail;
    data['video'] = this.video;
    return data;
  }
}
