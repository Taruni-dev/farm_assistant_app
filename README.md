# 🌾 Farm Assistant App

**Farm Assistant** is a Flutter-based mobile application designed to help farmers by providing **offline crop recommendations** and **pest management guidance** in an easy-to-use interface.

---

## 📌 Key Features

- **🌱 Crop Recommendation**  
  Predicts the best crop to grow based on inputs like N, P, K, temperature, humidity, pH, and rainfall using a **TensorFlow Lite** model.

- **🐛 Pest Help Module**  
  Offers guidance on pest prevention and control for specific crops.

- **📴 Offline Functionality**  
  Works without internet connectivity — all crop prediction and pest help features are available offline.

- **🖥 User-Friendly Interface**  
  Simple Login/Signup pages, clean forms, and responsive design.

---

## 🛠 Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend/Logic:** TensorFlow Lite for crop prediction
- **Database:** SQLite (for authentication & local data storage)
- **Other Tools:** JSON for pest dataset (offline)


## 📂 Folder Structure

farm_assistant_app/
│
├── lib/ # Flutter app source code
│ ├── database/ # SQLite helper files
│ ├── models/ # Data models
│ ├── screens/ # All screen UI files
│ ├── assets/ # Images
│ └── main.dart # App entry point
│
├── assets/ # Static files (images, json data)
├── pubspec.yaml # Flutter dependencies
└── README.md 

1. Clone the Repository
   ```bash
   git clone https://github.com/Taruni-dev/farm_assistant_app.git
   cd farm_assistant_app

2. Install Dependencies
   flutter pub get

3. Run the App
   flutter run
