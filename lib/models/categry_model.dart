class CategryModel {
  String id;
  String name;
  String imageName;

  CategryModel({required this.imageName, required this.id, required this.name});

  static List<CategryModel> categories = [
    CategryModel(imageName: 'general', id: 'general', name: 'General'),
    CategryModel(imageName: 'sports', id: 'sports', name: 'Sports'),
    CategryModel(imageName: 'business', id: 'business', name: 'Business'),
    CategryModel(imageName: 'health', id: 'health', name: 'Health'),
    CategryModel(imageName: 'science', id: 'science', name: 'Science'),
    CategryModel(imageName: 'technology', id: 'technology', name: 'Technology'),
    CategryModel(
      imageName: 'entertainment',
      id: 'entertainment',
      name: 'Entertainment',
    ),
  ];
}
