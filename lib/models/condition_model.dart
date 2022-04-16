class Condition {
  final String title;
  final String image;
  final String content;

  const Condition(
      {required this.title, required this.image, required this.content});

  Map<String, dynamic> toJson() => {
        'title': title,
        'image': image,
        'content': content,
      };

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        title: json["title"] ?? '',
        image: json['image'] ?? '',
        content: json['content'] ?? '',
      );
}
