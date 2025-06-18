import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/diagnosis_model.dart';

class ApiService extends ChangeNotifier {
  static const String baseUrl = 'http://127.0.0.1:5000'; // Replace with your actual backend URL
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<DiagnosisModel?> diagnoseCropImage(File imageFile) async {
    try {
      _setLoading(true);
      _setError(null);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/diagnose'),
      );

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        
        DiagnosisModel diagnosis = DiagnosisModel.fromJson({
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'image_path': imageFile.path,
          'disease_name': data['disease_name'] ?? 'Unknown Disease',
          'confidence': data['confidence'] ?? '0%',
          'description': data['description'] ?? 'No description available',
          'symptoms': data['symptoms'] ?? [],
          'remedies': data['remedies'] ?? [],
          'prevention_tips': data['prevention_tips'] ?? [],
          'timestamp': DateTime.now().toIso8601String(),
          'severity': data['severity'] ?? 'Unknown',
          'crop_type': data['crop_type'] ?? 'Unknown',
        });

        _setLoading(false);
        return diagnosis;
      } else {
        _setError('Failed to diagnose image: ${response.statusCode}');
        _setLoading(false);
        return null;
      }
    } catch (e) {
      _setError('Error occurred: $e');
      _setLoading(false);
      return null;
    }
  }

  Future<String?> getChatbotResponse(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': message}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return data['response'];
      } else {
        return 'Sorry, I couldn\'t process your request at the moment.';
      }
    } catch (e) {
      return 'Sorry, I couldn\'t process your request at the moment.';
    }
  }
}