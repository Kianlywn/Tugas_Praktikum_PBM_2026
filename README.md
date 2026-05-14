# \# Flutter PBM 2026 — Katalog Produk

# 

# Aplikasi Flutter untuk Tugas Praktikum Pemrograman Berbasis Mobile 2026.

# 

# \## Struktur Project

# 

# ```

# lib/

# ├── main.dart

# ├── core/

# │   ├── constants/

# │   │   └── api\_constants.dart       # Base URL \& endpoint

# │   └── theme/

# │       └── app\_theme.dart           # Dark theme, warna, font

# ├── data/

# │   ├── models/

# │   │   ├── user\_model.dart          # Model User, Role, Class

# │   │   ├── product\_model.dart       # Model Product

# │   │   └── auth\_response\_model.dart # Model response login

# │   └── services/

# │       ├── api\_service.dart         # HTTP calls (login, produk, submit)

# │       └── storage\_service.dart     # flutter\_secure\_storage wrapper

# └── presentation/

# &#x20;   └── screens/

# &#x20;       ├── splash\_screen.dart       # Cek status login

# &#x20;       ├── login\_screen.dart        # Halaman login

# &#x20;       ├── product\_list\_screen.dart # Katalog produk (GET)

# &#x20;       ├── add\_product\_screen.dart  # Tambah produk (POST)

# &#x20;       └── submit\_screen.dart       # Submit tugas

# ```

# 

# \## Setup

# 

# 1\. \*\*Install dependencies:\*\*

# &#x20;  ```bash

# &#x20;  flutter pub get

# &#x20;  ```

# 

# 2\. \*\*Jalankan aplikasi:\*\*

# &#x20;  ```bash

# &#x20;  flutter run

# &#x20;  ```

# 

# 3\. \*\*Login:\*\* Gunakan NIM sebagai username dan password.

# 

# \## Fitur

# 

# \- ✅ Login dengan Bearer Token

# \- ✅ Simpan token secara aman (flutter\_secure\_storage)

# \- ✅ Model class untuk semua data API

# \- ✅ Katalog produk (daftar \& tambah)

# \- ✅ Submit tugas dengan link GitHub

# \- ✅ UI dark theme dengan animasi

# 

# \## API Base URL

# 

# `https://task.itprojects.web.id`

# 

# \## Screenshot

# 

# > Letakkan screenshot di folder ini (root project) setelah aplikasi berjalan.

# 

# \- `screenshot\_login.png`

# \- `screenshot\_catalog.png`

# \- `screenshot\_add\_product.png`

# \- `screenshot\_submit.png`

