class CategryModel {
  String id;
  String name;
  String imageName;

  CategryModel({required this.imageName, required this.id, required this.name});

  static List<CategryModel> categories = [
    CategryModel(imageName: 'general', id: '', name: 'General'),
    CategryModel(imageName: 'sports', id: '', name: 'Sports'),
    CategryModel(imageName: 'business', id: '', name: 'Business'),
    CategryModel(imageName: 'health', id: '', name: 'Health'),
    CategryModel(imageName: 'science', id: '', name: 'Science'),
    CategryModel(imageName: 'technology', id: '', name: 'Technology'),
    CategryModel(imageName: 'entertainment', id: '', name: 'Entertainment'),
  ];
}
