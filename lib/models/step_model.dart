List<StepModel>? stepFromJson(List<dynamic>? str) {
  if (str == null) {
    return null;
  }
  List<StepModel>? list = [];

  for (Map<String, dynamic> x in str) {
    list.add(StepModel.fromJson(x));
  }

  return list;
}

class StepModel {
  final String? title;
  final String? image;
  final List<StepModel>? steps;

  const StepModel(
      {required this.title, required this.image, required this.steps});

  Map<String, dynamic> toJson() => {
        'title': title,
        'image': image,
        'steps': steps,
      };

  factory StepModel.fromJson(Map<String, dynamic> json) => StepModel(
        title: json["title"],
        image: json['image'],
        steps: stepFromJson(json['steps']),
      );
}
