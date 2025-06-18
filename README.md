# Plantalgo 🌱 (Frontend)

**Plantalgo** is a Flutter-based mobile application that helps users diagnose crop diseases by uploading plant images. The app uses an AI model hosted on a Flask backend to analyze the images and return predictions.

---

## 🚀 Features

- 🌾 Upload crop images for disease detection
- 🔐 Firebase Auth: Sign up / login
- 👤 User profile with farm details and crop list
- 📡 Connects to Flask backend for ML prediction
- 💡 Clean and responsive UI

---

## 🛠️ Tech Stack

- **Flutter** (Frontend UI)
- **Firebase** (Authentication)
- **Provider** (State Management)
- **Flask + TensorFlow** (Backend + AI model - [See Backend Repo](../Backend))

---

## 📁 Folder Structure

```bash
lib/
├── main.dart
├── models/           # User & crop models
├── screens/          # UI screens
│   ├── auth/
│   ├── home/
│   └── profile/
├── services/         # Firebase & HTTP services
└── widgets/          # Reusable UI components
```

---

## 🔧 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/plantalgo.git
cd Frontend
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

> Make sure Android/iOS emulator is running or device is connected.

---

## ✅ Requirements

- Flutter SDK 3.x+
- Dart SDK
- Android Studio / Xcode
- Firebase Project (setup auth)
- Flask backend running (for image prediction)

---

## 🔗 Backend API

Ensure your Flask server is running (e.g., at `http://127.0.0.1:5000` or hosted version).

In `lib/services/api_service.dart`, update the base URL:

```dart
const String baseUrl = "http://<your-backend-ip>:5000";
```

---

## 🐛 Known Issues

- Firebase `PromiseJsImpl` error on web: web is not currently supported.
- Use minSdkVersion 23+ to support Firebase Auth

---

## 🧪 Testing

Use real device or emulator to test image uploads and backend prediction.

---

## 📦 Build APK

```bash
flutter build apk --release
```

---

## 🙏 Acknowledgements

- TensorFlow & Kaggle Datasets
- Firebase Auth
- Flutter Dev Community

---

## 📃 License

This project is licensed under the MIT License. See `LICENSE` for more information.