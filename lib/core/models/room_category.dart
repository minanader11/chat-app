class RoomCategory{
  String id;
  String title;
  String image;
  RoomCategory({required this.id,required this.title,required this.image});
  static List<RoomCategory> getCategory(){
    return [
      RoomCategory(id: 'sports', title: 'Sports', image: 'assets/images/sports.png'),
      RoomCategory(id: 'movies', title: 'Movies', image: 'assets/images/movies.png'),
      RoomCategory(id: 'music', title: 'Music', image: 'assets/images/music.png'),
    ];
  }
}