Nama: Faiz Aufa Asraf
NIM: 242410102017
Kelas: PBM A


**Struktur Project**
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   └── api\_constants.dart       # Base URL \& endpoint
│   └── theme/
│       └── app\_theme.dart           # Dark theme, warna, font
├── data/
│   ├── models/
│   │   ├── user\_model.dart          # Model User, Role, Class
│   │   ├── product\_model.dart       # Model Product
│   │   └── auth\_response\_model.dart # Model response login
│   └── services/
│       ├── api\_service.dart         # HTTP calls (login, produk, submit)
│       └── storage\_service.dart     # flutter\_secure\_storage wrapper
└── presentation/
        └── screens/
               ├── splash_screen.dart       # Cek status login
               ├── login_screen.dart        # Halaman login
               ├── product_list_screen.dart # Katalog produk (GET)
               ├── add_product_screen.dart  # Tambah produk (POST)
               └── submit_screen.dart       # Submit tugas


**Setup**
1.Install dependencies:
flutter pub get

2.Jalankan aplikasi:
flutter run

3.Login: Gunakan NIM sebagai username dan password.


**API Base URL**
https://task.itprojects.web.id


**Screenshot**

<img width="379" height="878" alt="image" src="https://github.com/user-attachments/assets/f7f25575-fed2-4665-a980-5ac8ee76c596" />

<img width="381" height="887" alt="image" src="https://github.com/user-attachments/assets/8dba99fd-9ca6-49ce-8755-c5f8e95905a8" />

<img width="376" height="885" alt="image" src="https://github.com/user-attachments/assets/40b5b966-3ae2-40c3-9f40-2e5c07a8e18d" />

<img width="382" height="888" alt="image" src="https://github.com/user-attachments/assets/8a0e890e-df84-44dd-8624-338d6d88d977" />
