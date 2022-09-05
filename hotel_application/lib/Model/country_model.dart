class CountryModel {
  String label;
  String countryName;
  int noOfTours;
  double rating;
  String imgUrl;

  CountryModel(
      {required this.countryName,
      required this.label,
      required this.noOfTours,
      required this.rating,
      required this.imgUrl});
}
