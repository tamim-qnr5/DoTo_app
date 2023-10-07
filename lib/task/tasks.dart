class Tasks {
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  Tasks(
      {required this.title,
      this.id = '',
      required this.dateTime,
      required this.description,
      this.isDone = false});

  Tasks.fromFirestore(Map<String, dynamic> data)
      : this(
          description: data['description'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
          title: data['title'],
          isDone: data['isDone'],
          id: data['id'],
        );

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      "description": description,
      "dateTime": dateTime?.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
