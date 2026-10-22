TUGAS: REFACTOR STRUKTUR FOLDER DAN CLEAN CODE PROYEK FLUTTER "DASAR PYTHON"

File ini adalah instruksi kerja lengkap untuk agen Antigravity. Letaknya di root proyek, sejajar dengan pubspec.yaml. Baca seluruh isi file ini sebelum melakukan perubahan apa pun.


0. CARA KERJA DI ANTIGRAVITY

0.1 Konteks. Kamu bekerja langsung di workspace proyek ini dan boleh membaca file, mengedit file, serta menjalankan perintah terminal. Acuan standar coding ada di file Standarisasi_Coding.md di root proyek yang sama. Baca file itu sampai habis lebih dulu.
0.2 Rencana dulu. Jika tersedia mode Planning, gunakan. Sebelum mengubah file, buat rencana kerja (daftar tugas) berdasarkan bagian 8 dan tampilkan. Perbarui daftar tugas itu seiring pekerjaan berjalan. Jangan meminta persetujuan untuk setiap langkah kecil, cukup berhenti dan tanya bila ada keputusan yang berisiko mengubah perilaku aplikasi.
0.3 Terminal. Jalankan perintah satu per satu dan baca hasilnya sebelum lanjut. Jangan menjalankan perintah yang menghapus banyak file sekaligus (misalnya hapus rekursif seluruh folder) sebelum pengalihan import terverifikasi.
0.4 Sistem operasi. Pengguna kemungkinan memakai Windows. Gunakan perintah yang berjalan di Windows dan Linux. Untuk mencari teks di seluruh proyek, pakai git grep (jika proyek memakai git) atau fitur pencarian workspace. Jangan bergantung pada perintah khusus Linux.
0.5 Pengguna bisa kehabisan kuota di tengah pekerjaan dan melanjutkan di sesi atau akun lain. Karena itu, kerjakan bagian 11 (commit per tahap dan file progres) dengan disiplin.


1. PERAN DAN TUJUAN

Kamu adalah senior Flutter engineer. Tugasmu:
1. Merapikan struktur folder dan file di lib/ menjadi feature-first (satu fitur = satu folder berisi semua filenya).
2. Menghapus file duplikat dan file orphan.
3. Menulis ulang kode agar mengikuti Standarisasi_Coding.md (penamaan, clean code, dokumentasi), dengan penyesuaian bahasa penamaan di bagian 6.
4. Mengintegrasikan ulang semua import sampai aplikasi bisa dijalankan.

Ini REFACTOR, bukan redesign.


2. ATURAN MUTLAK (tidak boleh dilanggar)

2.1 Jangan mengubah tampilan (UI), warna, ukuran, teks yang tampil ke pengguna (tetap Bahasa Indonesia), alur navigasi, maupun perilaku aplikasi.
2.2 Jangan mengubah pubspec.yaml dan folder selain lib/ (android/, ios/, assets/, dst). Pengecualian: file dokumentasi baru di root (CODING_STANDARD.md, README.md, REFACTOR_PROGRESS.md).
2.3 Jangan menghapus file sebelum isinya dipindahkan ke lokasi baru dan tidak ada lagi import yang menunjuk ke file tersebut.
2.4 Key JSON pada fromJson dan toJson (misalnya 'guru_mapel', 'halaman_konten') jangan diubah karena itu kontrak API. Yang diubah hanya nama field atau variabel Dart-nya.
2.5 Kerjakan bertahap. Setelah setiap tahap, jalankan flutter analyze dan pastikan tidak ada error baru sebelum lanjut.
2.6 Jika ada hal yang ambigu atau berisiko mengubah perilaku, jangan menebak. Pertahankan perilaku asli dan catat di laporan akhir.
2.7 Jika ada pertentangan, aturan di file ini lebih diutamakan daripada Standarisasi_Coding.md. Contoh: dokumen dosen memakai contoh PHP dan menyarankan identifier berbahasa Inggris, sedangkan proyek ini Dart dan memakai penamaan Bahasa Indonesia (bagian 6). Konvensi Dart dan aturan bagian 6 yang dipakai.
2.8 Jangan menonaktifkan warning atau menyembunyikan error dengan komentar ignore.
2.9 Jangan menambah package baru dan jangan memperbarui versi dependency.


3. STRUKTUR SAAT INI (hasil analisis, bagian yang benar-benar dipakai)

```
lib/
├── main.dart                  entry point, home: LoginPage, tema + NoTransitionsBuilder
├── login/
│   └── login_page.dart        login, lanjut ke BerandaView
├── common/                    bagian bersama (shared)
│   ├── models/question.dart
│   ├── screens/test_page.dart     halaman tes generik (dipakai pre dan post test)
│   ├── theme/                     app_colors, auth_colors
│   └── widgets/                   answer_option, audio_timer_row, question_card,
│                                  question_navigation, submit_button, test_header,
│                                  auth_header, auth_avatar_icon, auth_text_field
├── pretest/                   pretest_page.dart + pretest_data.dart
├── posttest/                  posttest_page.dart + posttest_data.dart
├── data/materi_data.dart      data materi
├── models/materi_model.dart   model materi
├── widgets/custom_footer.dart bottom nav, dipakai semua view
└── views/
    ├── beranda/      beranda_view (hub: materi, pretest, posttest)
    ├── materi/       buka_materi_view
    ├── leaderboard/  leaderboard_view
    ├── profile/      profile_view
    ├── sertifikat/   sertifikat_view, upload_sertifikat_view
    └── auth/         register_view (+ auth_view, pretest_view, posttest_view)
```

Alur aplikasi: main -> LoginPage -> BerandaView. Dari beranda ke Pretest/Posttest (keduanya membungkus common/screens/test_page.dart) dan ke BukaMateriView. CustomFooter menghubungkan Beranda, Leaderboard, Profil, dan Sertifikat. ProfileView bisa kembali ke LoginPage (logout).

Catatan: struktur di atas adalah hasil analisis awal. Sebelum bekerja, verifikasi sendiri dengan membaca isi lib/ dan jalur import yang sebenarnya. Jika ada perbedaan, catat di laporan dan ikuti kondisi nyata.


4. FILE DUPLIKAT DAN SISA YANG HARUS DIHAPUS

Hasil perbandingan (diff) menunjukkan file berikut identik dengan versi di common/ atau folder fitur (hanya beda di baris import atau komentar):
- lib/screens/test_page.dart, duplikat dari common/screens/test_page.dart
- lib/theme/app_colors.dart, duplikat dari common/theme/app_colors.dart
- lib/models/question.dart, duplikat dari common/models/question.dart
- lib/widgets/ semua file KECUALI custom_footer.dart (answer_option, audio_timer_row, question_card, question_navigation, submit_button, test_header), duplikat dari common/widgets/
- lib/data/pretest_data.dart dan lib/data/posttest_data.dart, duplikat dari pretest/pretest_data.dart dan posttest/posttest_data.dart
- lib/views/auth/auth_view.dart, pretest_view.dart, posttest_view.dart: tidak ada yang mengimpor (orphan) dan hanya wrapper tidak berguna

PERHATIAN: versi lama (lib/screens/test_page.dart, lib/widgets/answer_option.dart, lib/widgets/test_header.dart) memiliki komentar dokumentasi /// yang TIDAK ada di versi common/. Saat menggabungkan, pertahankan komentar tersebut di file hasil akhir.

CATATAN: register_view.dart sekarang hanya terjangkau dari auth_view (orphan). JANGAN dihapus. Pindahkan ke fitur autentikasi dan tulis di laporan akhir bahwa halaman ini belum punya jalur navigasi.


5. STRUKTUR TARGET (feature-first, penamaan Bahasa Indonesia)

```
lib/
├── main.dart                        hanya memanggil runApp(const Aplikasi())
├── aplikasi/
│   ├── aplikasi.dart                class Aplikasi (MaterialApp, home: LoginView)
│   └── tema_aplikasi.dart           ThemeData + TanpaTransisiBuilder
├── inti/
│   ├── konstanta/warna_aplikasi.dart     gabungan AppColors + auth_colors
│   └── widgets/navigasi_bawah.dart       ex custom_footer (logika navigasi antar tab dipusatkan di sini)
└── fitur/
    ├── autentikasi/
    │   ├── views/ (login_view.dart, register_view.dart)
    │   └── widgets/ (header_autentikasi.dart, ikon_avatar_autentikasi.dart,
    │                 kolom_teks_autentikasi.dart)
    ├── beranda/
    │   ├── views/beranda_view.dart
    │   └── widgets/ (header_profil_beranda, kartu_statistik, item_statistik,
    │                 kartu_materi, lembar_aksi_materi, tile_aksi)
    ├── materi/
    │   ├── data/materi_data.dart
    │   ├── models/materi_model.dart
    │   ├── views/buka_materi_view.dart
    │   └── widgets/ (tombol_kembali_materi, label_deskripsi, kotak_deskripsi,
    │                 kotak_kontainer_pdf, baris_kontrol_navigasi, tombol_navigasi,
    │                 tombol_selesai)
    ├── mesin_tes/                   mesin kuis bersama pretest dan posttest
    │   ├── models/soal.dart
    │   ├── views/tes_view.dart
    │   └── widgets/ (opsi_jawaban, baris_timer_audio, kartu_soal,
    │                 navigasi_soal, tombol_kirim, header_tes)
    ├── pretest/    (pretest_view.dart, pretest_data.dart)
    ├── posttest/   (posttest_view.dart, posttest_data.dart)
    ├── papan_peringkat/             ex leaderboard
    │   ├── models/pengguna_peringkat.dart
    │   ├── views/papan_peringkat_view.dart
    │   └── widgets/ (batang_podium.dart dan widget lain hasil pecahan view)
    ├── profil/
    │   ├── views/profil_view.dart
    │   └── widgets/ (header_profil, tombol_menu_profil, tombol_keluar)
    └── sertifikat/
        ├── models/item_sertifikat.dart
        ├── views/ (sertifikat_view.dart, upload_sertifikat_view.dart)
        └── widgets/ (header_sertifikat, header_unggah, kartu_sertifikat, dst.)
```

Aturan struktur:
- Nama subfolder teknis (data, models, views, widgets) tetap bahasa Inggris karena itu istilah arsitektur Flutter yang baku. Subfolder hanya dibuat jika ada isinya.
- Kode yang dipakai lebih dari satu fitur masuk inti/ atau fitur/mesin_tes/.
- Tidak boleh ada folder lama tersisa: common/, data/, models/, screens/, theme/, widgets/, views/, login/.

DAFTAR PEMINDAHAN FILE (lama -> baru)
- main.dart -> tetap, dipecah menjadi main.dart + aplikasi/aplikasi.dart + aplikasi/tema_aplikasi.dart
- login/login_page.dart -> fitur/autentikasi/views/login_view.dart
- views/auth/register_view.dart -> fitur/autentikasi/views/register_view.dart
- common/widgets/auth_header.dart -> fitur/autentikasi/widgets/header_autentikasi.dart
- common/widgets/auth_avatar_icon.dart -> fitur/autentikasi/widgets/ikon_avatar_autentikasi.dart
- common/widgets/auth_text_field.dart -> fitur/autentikasi/widgets/kolom_teks_autentikasi.dart
- common/theme/app_colors.dart + common/theme/auth_colors.dart -> inti/konstanta/warna_aplikasi.dart
- widgets/custom_footer.dart -> inti/widgets/navigasi_bawah.dart
- common/screens/test_page.dart -> fitur/mesin_tes/views/tes_view.dart
- common/models/question.dart -> fitur/mesin_tes/models/soal.dart
- common/widgets/answer_option.dart -> fitur/mesin_tes/widgets/opsi_jawaban.dart
- common/widgets/audio_timer_row.dart -> fitur/mesin_tes/widgets/baris_timer_audio.dart
- common/widgets/question_card.dart -> fitur/mesin_tes/widgets/kartu_soal.dart
- common/widgets/question_navigation.dart -> fitur/mesin_tes/widgets/navigasi_soal.dart
- common/widgets/submit_button.dart -> fitur/mesin_tes/widgets/tombol_kirim.dart
- common/widgets/test_header.dart -> fitur/mesin_tes/widgets/header_tes.dart
- pretest/pretest_page.dart -> fitur/pretest/pretest_view.dart
- pretest/pretest_data.dart -> fitur/pretest/pretest_data.dart
- posttest/posttest_page.dart -> fitur/posttest/posttest_view.dart
- posttest/posttest_data.dart -> fitur/posttest/posttest_data.dart
- data/materi_data.dart -> fitur/materi/data/materi_data.dart
- models/materi_model.dart -> fitur/materi/models/materi_model.dart
- views/beranda/beranda_view.dart -> fitur/beranda/views/beranda_view.dart
- views/materi/buka_materi_view.dart -> fitur/materi/views/buka_materi_view.dart
- views/leaderboard/leaderboard_view.dart -> fitur/papan_peringkat/views/papan_peringkat_view.dart
- views/profile/profile_view.dart -> fitur/profil/views/profil_view.dart
- views/sertifikat/sertifikat_view.dart -> fitur/sertifikat/views/sertifikat_view.dart
- views/sertifikat/upload_sertifikat_view.dart -> fitur/sertifikat/views/upload_sertifikat_view.dart


6. ATURAN PENAMAAN (BAHASA INDONESIA)

Keputusan pengguna: semua nama buatan sendiri memakai Bahasa Indonesia. Aturan ini menggantikan anjuran identifier berbahasa Inggris di Standarisasi_Coding.md.

6.1 Yang memakai Bahasa Indonesia: nama variabel, field, parameter buatan sendiri, nama fungsi dan method buatan sendiri, nama class buatan sendiri, nama file, dan nama folder fitur.
6.2 Yang tetap bahasa Inggris:
- API Flutter dan Dart (StatelessWidget, build, setState, Navigator, BuildContext, nama parameter bawaan widget seperti child, onPressed, padding).
- Istilah teknis arsitektur yang sudah baku: akhiran View, Model, Data, Widget, nama subfolder views, models, data, widgets, dan kata Login, Register, Pretest, Posttest.
- Key JSON, nama package, dan isi pubspec.yaml.
6.3 Format penulisan mengikuti Dart:
- File: snake_case.dart (contoh: kartu_materi.dart). Akhiran sesuai jenis komponen: _view, _data, _model hanya bila sudah menjadi pola. Seragamkan semua halaman menjadi _view (hapus akhiran _page).
- Class: PascalCase (KartuMateri). Variabel, fungsi, parameter: camelCase (indeksSaatIni). Anggota private diawali garis bawah.
- Konstanta: lowerCamelCase sesuai Effective Dart, bukan UPPER_SNAKE_CASE. Hapus awalan k (kMaroon dst).
6.4 Nama harus bermakna dan konsisten. Nama fungsi menggambarkan aksi (ambilSiswaBerdasarkanId, hitungTotalSkor, bukan data atau proses). Tidak boleh nama satu huruf (a, x1, data1) kecuali variabel loop. Hindari singkatan yang tidak umum. Pakai satu kata Indonesia yang sama untuk satu konsep di seluruh proyek (misalnya selalu soal, jangan campur soal dan pertanyaan untuk objek yang sama).
6.5 Jangan memakai nama yang bentrok dengan kata kunci Dart atau widget bawaan Flutter. Saat widget privat dipecah menjadi file sendiri dan menjadi public, beri nama spesifik (misalnya TombolKembaliMateri, bukan BackButton).
6.6 Jika dua widget dari fitur berbeda punya nama privat yang sama (misalnya _ProfileHeader di beranda dan profil), beri nama berbeda setelah dipublikkan: HeaderProfilBeranda dan HeaderProfil.

Tabel rename wajib (nama Inggris -> Indonesia, nama yang sudah Indonesia dibiarkan):
- App -> Aplikasi
- NoTransitionsBuilder -> TanpaTransisiBuilder
- AppColors -> WarnaAplikasi, dengan field: primary -> utama, primaryDark -> utamaGelap, selected -> terpilih, selectedBorder -> borderTerpilih, border -> border, background -> latarBelakang, primaryFaded -> utamaRedup, softShadow -> bayanganLembut
- CustomFooter -> NavigasiBawah, currentIndex -> indeksSaatIni
- Question -> Soal, dengan field: question -> pertanyaan, options -> pilihan, correctAnswerIndex -> indeksJawabanBenar
- TestPage -> TesView
- preTestQuestions -> daftarSoalPretest, dan variabel posttest disamakan: daftarSoalPosttest
- PretestPage -> PretestView
- PosttestPage -> PosttestView
- LoginPage -> LoginView
- LeaderboardView -> PapanPeringkatView
- LeaderboardUser -> PenggunaPeringkat
- ProfileView -> ProfilView
- BerandaView, MateriModel, BukaMateriView, SertifikatView, UploadSertifikatView, SertifikatItem (-> ItemSertifikat): nama domain sudah Indonesia. Hanya SertifikatItem yang diubah menjadi ItemSertifikat agar urutan katanya konsisten (benda lalu keterangan seperti KartuMateri, ItemSertifikat).
- Field MateriModel (kelas, judul, guruMapel, deskripsi, halamanKonten, totalHalaman) sudah Indonesia, tetap.

Untuk identifier berbahasa Inggris lain yang kamu temukan (variabel lokal, state, controller, method private, dan seterusnya), terjemahkan dengan pola yang sama dan daftarkan di laporan akhir. Contoh: _currentQuestionIndex -> _indeksSoalSaatIni, _selectedAnswers -> _jawabanTerpilih, isSelected -> apakahTerpilih atau terpilih, onTap (milik parameter sendiri) -> saatDiketuk.

Penggabungan warna:
- kMaroon dan kMaroonLight -> WarnaAplikasi.utama
- kMaroonDark -> WarnaAplikasi.utamaGelap
- kCardBorder -> WarnaAplikasi.border (nilainya sama, 0xFFEDE1E5)
- kBackground (0xFFF5F5F5) BERBEDA dari WarnaAplikasi.latarBelakang (putih). Buat WarnaAplikasi.latarBelakangAutentikasi supaya tampilan login dan register tidak berubah.


7. ATURAN CLEAN CODE

- Single Responsibility: pecah file besar (upload_sertifikat_view sekitar 1100 baris, sertifikat_view sekitar 885, leaderboard_view sekitar 660, beranda_view sekitar 600) menjadi widget kecil, satu file per widget, di folder widgets/ fiturnya (Extract Widget dan Extract Method).
- Model data yang tertanam di file view (LeaderboardUser, SertifikatItem) dipindah ke folder models/.
- Hilangkan duplikasi: logika Navigator antar tab footer yang berulang di tiap view dipusatkan di NavigasiBawah atau satu helper navigasi.
- Hapus magic number dan Color(0x...) yang hard-coded di view. Pindahkan ke WarnaAplikasi atau konstanta bernama. Nilai visualnya harus sama persis.
- Gunakan guard clause (early return) untuk mengganti nested if yang dalam.
- Hapus wrapper yang tidak berguna dan semua print atau kode debug.
- Komentar hanya untuk konteks atau alasan, bukan mengulang isi kode. Tulis dalam Bahasa Indonesia, dan gunakan /// untuk class dan fungsi publik. Komentar versi lama yang sudah ada dipertahankan (jika berbahasa Inggris, terjemahkan ke Indonesia tanpa mengubah maknanya).
- Gunakan const constructor dan final di mana memungkinkan.
- Format dengan dart format dan jaga flutter analyze tanpa warning baru.


8. LANGKAH KERJA (ikuti urutan, jangan loncat)

Langkah 1. Baca Standarisasi_Coding.md dan seluruh isi lib/. Baca nilai name di pubspec.yaml, lalu gunakan import berbentuk package:<nama_package>/... secara konsisten (tanpa relative import ../..).
Langkah 2. Cek apakah proyek memakai git. Jika ya, buat branch refactor/folder-structure. Jika tidak, buat salinan cadangan folder lib/ (misalnya lib_backup/ di luar lib/). Lalu jalankan flutter pub get dan flutter analyze dan catat hasilnya sebagai baseline di REFACTOR_PROGRESS.md.
Langkah 3. Buat struktur folder target, lalu pindahkan file sesuai daftar pemindahan (pakai git mv jika memakai git).
Langkah 4. Gabungkan file duplikat (pertahankan komentar versi lama), lalu integrasikan ulang import sesuai bagian 9.
Langkah 5. Rename identifier sesuai bagian 6. Gunakan fitur rename yang aman, lalu cari sisa nama lama dengan pencarian di seluruh workspace.
Langkah 6. Pecah file besar dan terapkan aturan clean code (bagian 7).
Langkah 7. Hapus file duplikat, file orphan, dan folder lama yang sudah kosong, hanya setelah verifikasi bagian 9 lolos.
Langkah 8. Jalankan dart format, flutter analyze (target: tidak ada error dan tidak ada warning baru dibanding baseline), lalu flutter run (atau flutter build apk --debug jika tidak ada device).
Langkah 9. Buat CODING_STANDARD.md dan README.md (bagian 10).

Setelah tiap langkah selesai: jalankan flutter analyze, lakukan commit (bagian 11), dan perbarui REFACTOR_PROGRESS.md.


9. INTEGRASI ULANG IMPORT SETELAH DUPLIKAT DIGABUNG

Setiap file duplikat yang dihapus harus diikuti pengalihan semua pemakainya ke file tunggal yang tersisa.

9.1 Satu sumber kebenaran per class. Setelah refactor hanya boleh ada satu definisi untuk Soal, WarnaAplikasi, MateriModel, dan semua widget tes. Tidak boleh ada dua file yang mendefinisikan class bernama sama.
9.2 Pengalihan import yang wajib:
- Semua import ke lib/models/question.dart atau common/models/question.dart diarahkan ke fitur/mesin_tes/models/soal.dart.
- Semua import ke lib/theme/app_colors.dart, common/theme/app_colors.dart, dan common/theme/auth_colors.dart diarahkan ke inti/konstanta/warna_aplikasi.dart.
- Semua import ke lib/widgets/custom_footer.dart diarahkan ke inti/widgets/navigasi_bawah.dart.
- Semua import ke lib/models/materi_model.dart dan lib/data/materi_data.dart diarahkan ke fitur/materi/.
- Semua import ke lib/data/pretest_data.dart dan lib/data/posttest_data.dart diarahkan ke fitur/pretest/ dan fitur/posttest/.
- Semua import ke lib/screens/test_page.dart dan lib/widgets/ (6 widget tes) diarahkan ke fitur/mesin_tes/.
9.3 Gunakan import berbentuk package:<nama_package>/... di semua file.
9.4 Hapus import yang tidak terpakai setelah pengalihan.
9.5 Verifikasi sebelum menghapus file lama:
- Cari setiap path lama di seluruh workspace (misalnya "models/question.dart", "theme/app_colors.dart", "widgets/custom_footer.dart", "auth_colors"). Hasilnya harus kosong.
- Cari juga nama class dan field lama (misalnya AppColors, CustomFooter, Question, correctAnswerIndex, TestPage). Hasilnya harus kosong.
- Jalankan flutter analyze. Tidak boleh ada error seperti uri_does_not_exist, undefined_class, undefined_identifier, atau ambiguous_import.
- Jalankan flutter run (atau flutter build apk --debug) dan buka setiap layar sesuai checklist bagian 12.
9.6 Jika ada error integrasi, perbaiki sampai bersih. Jangan menonaktifkan warning atau menyembunyikan error dengan ignore.


10. DOKUMENTASI YANG HARUS DIBUAT (di root proyek)

10.1 CODING_STANDARD.md
Ringkasan aturan di atas dengan format per aturan: Rule, Description, Example, Incorrect Example. Minimal 10 aturan yang mencakup: penamaan Bahasa Indonesia (beserta pengecualian istilah teknis), file naming, folder structure, formatting, komentar, error handling, clean code, konstanta dan warna, commit message, dan branch naming. Contoh kode di dokumen memakai penamaan Indonesia.

10.2 README.md
Deskripsi proyek, struktur folder final (pohon + fungsi tiap folder), cara menjalankan aplikasi, dan alur navigasi layar.


11. COMMIT PER TAHAP DAN FILE PROGRES (agar aman jika sesi terputus)

11.1 Jika memakai git, lakukan commit setiap satu langkah di bagian 8 selesai dan flutter analyze bersih. Format pesan commit: refactor: <deskripsi singkat>. Contoh: refactor: pindahkan file mesin tes ke fitur/mesin_tes.
11.2 Setelah setiap langkah, tulis atau perbarui file REFACTOR_PROGRESS.md di root proyek dengan isi:
- Langkah yang sudah selesai.
- Langkah yang sedang dikerjakan.
- File yang sudah dipindah, diubah, atau dihapus.
- Hasil flutter analyze terakhir.
- Masalah atau keputusan yang tertunda.
11.3 Jika pekerjaan dilanjutkan di sesi baru, mulailah dengan membaca REFACTOR_PROGRESS.md, menjalankan git status dan git diff, lalu menjalankan flutter analyze. Perbaiki dulu kondisi setengah jadi (import rusak, file sudah dipindah tapi belum terhubung) sebelum melanjutkan ke langkah berikutnya. Jangan memulai dari awal.


12. CHECKLIST VERIFIKASI (semua harus lolos)

- Aplikasi berjalan: Login lalu Beranda tampil normal.
- Beranda -> Pre-Test: 20 soal, navigasi soal, pilih jawaban, dan submit berfungsi seperti semula.
- Beranda -> Post-Test: berfungsi sama seperti Pre-Test.
- Beranda -> Buka Materi: halaman materi, tombol sebelumnya/berikutnya, dan tombol Selesai berfungsi.
- Footer berpindah antar Beranda, Papan Peringkat, Profil, dan Sertifikat dengan benar.
- Sertifikat -> Upload Sertifikat berfungsi. Profil -> Logout kembali ke Login.
- Tidak ada file duplikat dan tidak ada folder lama tersisa.
- Tidak ada import yang rusak. Tidak ada identifier berbahasa Inggris buatan sendiri yang tersisa (kecuali yang termasuk pengecualian bagian 6.2).
- Tampilan identik dengan sebelum refactor.

Jika tidak bisa menjalankan aplikasi secara interaktif di lingkunganmu, jalankan flutter analyze dan flutter build apk --debug, lalu nyatakan dengan jelas di laporan akhir bagian mana yang belum bisa diuji secara visual agar pengguna mengujinya sendiri.


13. FORMAT LAPORAN AKHIR

Tulis laporan akhir di chat dan simpan juga sebagai bagian akhir REFACTOR_PROGRESS.md. Isinya:
1. Pohon folder final.
2. Tabel pemindahan file lama ke baru.
3. Daftar file yang dihapus beserta alasannya.
4. Daftar rename identifier.
5. Hasil flutter analyze dan hasil run atau build.
6. Hal yang perlu keputusan dari pengguna (misalnya register_view yang belum punya jalur navigasi).
