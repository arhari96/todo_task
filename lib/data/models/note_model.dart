class NoteModel {
  String id;
  String title;
  String content;
  DateTime timestamp;

  String userId;
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map, String documentId) {
    return NoteModel(
      id: documentId,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      timestamp: DateTime.parse(
        map['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
      userId: map['userId'] ?? '',
    );
  }
}
