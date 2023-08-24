class TravelModel {
  final String title;
  final String subTitle;
  final String imageName;

  TravelModel(
      {required this.title, required this.subTitle, required this.imageName});

  String get imagePath => 'assets/images/$imageName.jpg';

  static final List<TravelModel> mockItems = [
    TravelModel(title: "Lake", subTitle: "A", imageName: 'lake'),
    TravelModel(title: "Sea", subTitle: "B", imageName: 'sea'),
    TravelModel(title: "Sky", subTitle: "C", imageName: 'sky')
  ];
}
