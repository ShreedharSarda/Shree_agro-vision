class Fruits {
  Fruits({
    this.fruits,
    this.fruitDiseases,
    this.message,
  });

  String fruits;
  String fruitDiseases;
  String message;

  factory Fruits.fromJson(Map<String, dynamic> json) => Fruits(
        fruits: json["Fruits"],
        fruitDiseases: json["Fruit_diseases"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Fruits": fruits,
        "Fruit_diseases": fruitDiseases,
        "Message": message,
      };
}
