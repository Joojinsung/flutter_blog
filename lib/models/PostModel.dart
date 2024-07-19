class PostModel {
  final String id;
  final String userId;
  final String title;
  final String content;
  final DateTime regDate;

  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.regDate,
  });

  // fromJson 생성자 추가
  PostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        userId = json['userId'] ?? '',
        title = json['title'] ?? '',
        content = json['content'] ?? '',
        regDate = DateTime.tryParse(json['regDate'] ?? '') ?? DateTime.now();
}