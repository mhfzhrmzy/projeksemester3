# Pre-Test & Post-Test Dasar Python (Flutter — Frontend Only)

Implementasi frontend Flutter untuk halaman **Pre-Test** dan **Post-Test**
berdasarkan gambar referensi `Pretest.png` dan `Postest.png`.

Murni frontend: **tidak ada backend, API, database, autentikasi, atau
penyimpanan hasil ke server**. Semua state (jawaban terpilih & nomor soal
aktif) disimpan sementara di memory menggunakan `StatefulWidget` + `setState`.

## Struktur folder

```
lib/
├── main.dart                     # Entry point + menu untuk membuka Pre-Test / Post-Test
├── models/
│   └── question.dart             # Model data soal (question, options, correctAnswerIndex, code)
├── data/
│   ├── pretest_data.dart         # 20 soal dummy untuk Pre-Test
│   └── posttest_data.dart        # 20 soal dummy untuk Post-Test (beberapa berisi kode Python)
├── theme/
│   └── app_colors.dart           # Palet warna (maroon primary, selected, dsb)
├── screens/
│   └── test_page.dart            # Halaman utama Pre-Test/Post-Test (reusable), state management
└── widgets/
    ├── test_header.dart          # Header maroon fixed, rounded bottom, shadow
    ├── audio_timer_row.dart      # Row "Play Audio" (dummy) + "30 Detik" (dummy)
    ├── question_card.dart        # Card soal, auto-height, mendukung code block
    ├── answer_option.dart        # Card pilihan jawaban A/B/C/D, state selected/unselected
    ├── question_navigation.dart  # Back / Soal X/Y / Next, disabled di ujung
    └── submit_button.dart        # Tombol Submit, disabled sampai semua soal terjawab
```

`TestPage` adalah widget reusable: dipakai baik untuk Pre-Test maupun
Post-Test, hanya berbeda `title` dan `questions` yang di-pass sebagai
parameter — sesuai poin 11 (reusable UI, data dummy berbeda).

## Fitur yang diimplementasikan

- Header maroon fixed dengan sudut bawah rounded besar + shadow halus.
- Row "Play Audio" (dummy, tanpa audio asli) dan "30 Detik" (dummy timer UI),
  memakai Material Icons (`Icons.volume_up`, `Icons.timer_outlined`).
- Card soal dengan tinggi otomatis (tidak fixed height) — teks panjang atau
  kode Python (ditampilkan dalam code block monospace yang bisa discroll
  horizontal) akan membuat card bertambah tinggi secara otomatis.
- 4 pilihan jawaban berbentuk card:
  - Belum dipilih → background putih, border/shadow halus, teks maroon.
  - Dipilih → background berubah warna (maroon muda), hanya satu jawaban
    aktif per soal, memilih ulang otomatis membatalkan pilihan sebelumnya.
- Navigasi soal (Back / Soal X/20 / Next):
  - Back disabled di soal pertama.
  - Next disabled di soal terakhir.
  - Jawaban tiap soal tetap tersimpan saat pindah maju/mundur (state
    `List<int?> selectedAnswers` di `TestPage`).
- Tombol Submit full-width, maroon, disabled (warna pudar, tidak bisa
  ditekan) sampai seluruh 20 soal terjawab; aktif dan menampilkan dialog
  "Jawaban berhasil dikirim" setelah semua terjawab.
- Layout: `Scaffold > SafeArea > Column [Fixed Header, Expanded +
  SingleChildScrollView, Fixed Bottom Controls]` — header dan navigasi
  bawah tetap terlihat, hanya konten soal yang discroll.
- Responsive: memakai `MediaQuery`, `LayoutBuilder`, `ConstrainedBox`,
  `Expanded`/`Flexible`, dan padding yang menyesuaikan lebar layar
  (termasuk pembatasan lebar konten pada tablet agar tidak terlalu lebar).
- Tidak ada state-management package eksternal (Provider/Bloc/Riverpod/
  GetX) — murni `StatefulWidget` + `setState`.
- Tidak ada asset eksternal — hanya Material Icons bawaan Flutter.

## Cara menjalankan

1. Pastikan Flutter SDK sudah terpasang (`flutter --version`).
2. Salin/replace folder `lib/` dan `pubspec.yaml` ini ke dalam folder
   project Flutter yang sudah ada (atau jalankan `flutter create .` di
   folder ini terlebih dahulu jika folder platform seperti `android/`,
   `ios/` belum ada).
3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Jalankan di device/emulator Android yang terhubung:

   ```bash
   flutter run
   ```

   Atau untuk build APK release yang bisa diinstall langsung ke real
   Android device:

   ```bash
   flutter build apk --release
   ```

   File APK akan ada di `build/app/outputs/flutter-apk/app-release.apk`.

## Catatan integrasi ke project yang sudah ada

Jika project Flutter kamu sudah punya `lib/main.dart` lain, cukup:

- Copy folder `lib/models`, `lib/data`, `lib/theme`, `lib/screens`,
  `lib/widgets` ke dalam `lib/` project kamu.
- Replace atau gabungkan isi `lib/main.dart` sesuai kebutuhan (atau panggil
  `TestPage(title: 'Pre-Test Dasar Python', questions: preTestQuestions)`
  dari halaman/menu yang sudah ada).
- Tidak perlu menambahkan dependency baru di `pubspec.yaml` selain yang
  sudah ada di Flutter SDK bawaan (`cupertino_icons` sudah default di
  hampir semua project Flutter baru).
