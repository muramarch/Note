class Notes {
  final int? id;
  final String? title;
  final String? content;
  final String? created_at;
  final String? user;

  Notes({
    this.id,
    this.title,
    this.content,
    this.created_at,
    this.user,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        created_at: json["created_at"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "created_at": created_at,
        "user": user,
      };
}
