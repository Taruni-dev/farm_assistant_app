class PestInfo {
  final String crop;
  final List<String> issueKeywords;
  final String pest;
  final String symptoms;
  final String solution;

  PestInfo({
    required this.crop,
    required this.issueKeywords,
    required this.pest,
    required this.symptoms,
    required this.solution,
  });

  factory PestInfo.fromJson(Map<String, dynamic> json) {
    return PestInfo(
      crop: json['crop'],
      issueKeywords: List<String>.from(json['issue_keywords']),
      pest: json['pest'],
      symptoms: json['symptoms'],
      solution: json['solution'],
    );
  }
}
