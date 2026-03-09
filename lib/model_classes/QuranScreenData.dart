class QuranScreenData {
  String? title;
  String? imageUrl;

  QuranScreenData({required this.title, required this.imageUrl});
}

class QuranScreenDataBloc {
  final String? imageUrl;
  final String? title;


  QuranScreenDataBloc({required this.imageUrl, required this.title});

  // Factory method to create an object from JSON.
  factory QuranScreenDataBloc.fromJson(Map<String, dynamic> json) {
    return QuranScreenDataBloc(
      imageUrl: json['imageUrl'], title: json['title'],
    );
  }

  // Convert object to JSON.
  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'title': title,
  };
}
