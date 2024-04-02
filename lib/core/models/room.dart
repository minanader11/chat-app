class Room {
  String id;
  String title;
  String description;
  String category;

  Room(
      {required this.title, required this.id, required this.category, required this.description});

  Room.fromJson(Map<String, dynamic> json) : this(title: json['title'],
      category: json['category'],
      id: json['id'],
      description: json['description']);
  Map<String , dynamic> toJson(Room room){
    return {
      'title' : room.title,
      'category' : room.category,
      'id' :room.id,
      'description' : room.description
    };
  }
}