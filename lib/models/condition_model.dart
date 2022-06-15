import 'package:phytomedicine_app/models/step_model.dart';

class Condition {
  final String title;
  final String? image;
  final List<StepModel>? steps;

  const Condition({required this.title, this.image, required this.steps});

  Map<String, dynamic> toJson() => {
        'title': title,
        'image': image,
        'steps': steps,
      };

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        title: json["title"] ?? '',
        image: json['image'],
        steps: stepFromJson(json['steps']),
      );
}
