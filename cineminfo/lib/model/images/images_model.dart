import 'package:equatable/equatable.dart';

class Images extends Equatable {
  final String? aspect;
  final String? imagePath;
  final int? height;
  final int? width;
  final String? countryCode;
  final double? voteAverage;
  final int? voteCount;

  const Images(
      {this.aspect,
      this.imagePath,
      this.height,
      this.width,
      this.countryCode,
      this.voteAverage,
      this.voteCount});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
        aspect: json['aspect_ratio'].toString(),
        imagePath: json['file_path'],
        height: json['height'],
        width: json['width'],
        countryCode: json['iso_639_1'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count']);
  }

  @override
  List<Object> get props => [
        aspect!,
        imagePath!,
        height!,
        width!,
        countryCode!,
        voteAverage!,
        voteCount!
      ];
}
