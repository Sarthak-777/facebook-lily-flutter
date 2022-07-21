class Post {
  String description;
  List likes;
  String postId;
  String uid;
  String postUrl;
  DateTime datePosted;
  String firstName;
  String lastName;
  String type;
  String profilePic;

  Post(
      {required this.description,
      required this.likes,
      required this.postId,
      required this.uid,
      required this.postUrl,
      required this.datePosted,
      required this.firstName,
      required this.lastName,
      required this.type,
      required this.profilePic});

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'likes': likes,
      'postId': postId,
      'uid': uid,
      'postUrl': postUrl,
      'datePosted': datePosted,
      'firstName': firstName,
      'lastName': lastName,
      'type': type,
      'profilePic': profilePic,
    };
  }
}
