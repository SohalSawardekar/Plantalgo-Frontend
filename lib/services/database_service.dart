import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/diagnosis_model.dart';

class DatabaseService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<DiagnosisModel> _diagnoses = [];
  List<DiagnosisModel> get diagnoses => _diagnoses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> saveDiagnosis(DiagnosisModel diagnosis) async {
    try {
      if (_auth.currentUser != null) {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('diagnoses')
            .doc(diagnosis.id)
            .set(diagnosis.toJson());
        
        _diagnoses.insert(0, diagnosis);
        notifyListeners();
      }
    } catch (e) {
      print('Error saving diagnosis: $e');
    }
  }

  Future<void> loadDiagnoses() async {
    try {
      _isLoading = true;
      notifyListeners();

      if (_auth.currentUser != null) {
        QuerySnapshot snapshot = await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('diagnoses')
            .orderBy('timestamp', descending: true)
            .get();

        _diagnoses = snapshot.docs
            .map((doc) => DiagnosisModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error loading diagnoses: $e');
    }
  }

  Future<void> deleteDiagnosis(String diagnosisId) async {
    try {
      if (_auth.currentUser != null) {
        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('diagnoses')
            .doc(diagnosisId)
            .delete();

        _diagnoses.removeWhere((diagnosis) => diagnosis.id == diagnosisId);
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting diagnosis: $e');
    }
  }
}