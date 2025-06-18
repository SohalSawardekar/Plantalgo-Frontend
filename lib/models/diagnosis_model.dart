class DiagnosisModel {
  final String id;
  final String imagePath;
  final String diseaseName;
  final String confidence;
  final String description;
  final List<String> symptoms;
  final List<String> remedies;
  final List<String> preventionTips;
  final DateTime timestamp;
  final String severity;
  final String cropType;

  DiagnosisModel({
    required this.id,
    required this.imagePath,
    required this.diseaseName,
    required this.confidence,
    required this.description,
    required this.symptoms,
    required this.remedies,
    required this.preventionTips,
    required this.timestamp,
    required this.severity,
    required this.cropType,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      id: json['id'] ?? '',
      imagePath: json['image_path'] ?? '',
      diseaseName: json['disease_name'] ?? '',
      confidence: json['confidence'] ?? '',
      description: json['description'] ?? '',
      symptoms: List<String>.from(json['symptoms'] ?? []),
      remedies: List<String>.from(json['remedies'] ?? []),
      preventionTips: List<String>.from(json['prevention_tips'] ?? []),
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      severity: json['severity'] ?? 'Unknown',
      cropType: json['crop_type'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_path': imagePath,
      'disease_name': diseaseName,
      'confidence': confidence,
      'description': description,
      'symptoms': symptoms,
      'remedies': remedies,
      'prevention_tips': preventionTips,
      'timestamp': timestamp.toIso8601String(),
      'severity': severity,
      'crop_type': cropType,
    };
  }
}