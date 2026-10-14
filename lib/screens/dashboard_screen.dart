import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/lost_item.dart';
import '../widgets/unsika_logo.dart';
import '../widgets/item_image.dart';
import 'detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback? onReport; // dipanggil saat "Laporkan Sekarang" ditekan
  const DashboardScreen({super.key, this.onReport});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _category = 0; // 0 = Semua

  // (ikon, label). Label harus sama dengan LostItem.category
  final _categories = const [
    (Icons.grid_view_rounded, 'Semua'),
    (Icons.desktop_windows_outlined, 'Elektronik'),
    (Icons.description_outlined, 'Dokumen'),
    (Icons.backpack_outlined, 'Tas'),
    (Icons.vpn_key_outlined, 'Kunci'),
  ];

  // Data contoh.
  // Foto ada di assets/images/items/. Kalau file belum ada, otomatis
  // tampil kotak abu-abu (placeholder), jadi aman.
  final _items = const [
    LostItem(
      name: 'Dompet',
      category: 'Dokumen',
      date: '12 Oktober 2026',
      location: 'Depan Gedung Fasilkom',
      description:
      'Ditemukan dompet berwarna coklat di depan lobi gedung fakultas ilmu komputer. Kondisi masih bagus dan berisi beberapa kartu',
      found: true,
      contactName: 'Rizki Isma Ramadhani',
      contactPhone: '+62 81234567890',
      images: ['assets/images/dompet.jpeg'],
    ),
    LostItem(
      name: 'Kunci Motor',
      category: 'Kunci',
      date: '09 Oktober 2026',
      location: 'Parkiran Fakultas Teknik',
      description:
      'Kunci motor dengan gantungan kunci hitam hilang di area parkiran Fakultas Teknik.',
      found: false,
      contactName: 'Andi Pratama',
      contactPhone: '+62 81200000001',
      images: ['assets/images/kuncimotor.jpg'],
    ),
    LostItem(
      name: 'Charger Laptop',
      category: 'Elektronik',
      date: '05 Oktober 2026',
      location: 'Perpustakaan',
      description:
      'Ditemukan charger laptop warna hitam di meja baca lantai 2 perpustakaan.',
      found: true,
      contactName: 'Siti Rahma',
      contactPhone: '+62 81200000002',
      images: ['assets/images/chargerlaptop.png'],
    ),
    LostItem(
      name: 'Stand Holder',
      category: 'Elektronik',
      date: '03 Oktober 2026',
      location: 'Lab Lanjut 2',
      description: 'Stand holder HP warna hitam tertinggal di Lab Lanjut 2.',
      found: false,
      contactName: 'Budi Santoso',
      contactPhone: '+62 81200000003',
      images: ['assets/images/standholder.jpg'],
    ),
    LostItem(
      name: 'Tas Ransel',
      category: 'Tas',
      date: '02 Oktober 2026',
      location: 'Kantin Fakultas',
      description: 'Tas ransel hitam berisi buku catatan, hilang di kantin.',
      found: false,
      contactName: 'Dewi Lestari',
      contactPhone: '+62 81200000004',
      images: ['assets/images/tas.jpg'],
    ),
    LostItem(
      name: 'KTM Mahasiswa',
      category: 'Dokumen',
      date: '01 Oktober 2026',
      location: 'Gedung Rektorat',
      description: 'Ditemukan KTM mahasiswa di dekat pintu masuk rektorat.',
      found: true,
      contactName: 'Fajar Nugroho',
      contactPhone: '+62 81200000005',
      images: ['assets/images/ktm.jpg'],
    ),
  ];

  List<LostItem> get _filtered {
    if (_category == 0) return _items;
    final label = _categories[_category].$2;
    return _items.where((e) => e.category == label).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            _header(),
            const SizedBox(height: 18),
            _searchBar(),
            const SizedBox(height: 16),
            _banner(),
            const SizedBox(height: 18),
            _categoryRow(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Barang Terbaru',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.maroon)),
                GestureDetector(
                  onTap: () => setState(() => _category = 0),
                  child: const Row(
                    children: [
                      Text('Lihat Semua',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (list.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text('Belum ada barang di kategori ini',
                      style: TextStyle(color: AppColors.grey)),
                ),
              )
            else
              ...list.map(_itemCard),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        const UnsikaLogo(size: 36),
        const SizedBox(width: 10),
        const Text('Unsika Finder',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.maroon)),
        const Spacer(),
        const Icon(Icons.notifications_none_rounded,
            color: AppColors.maroon, size: 28),
        const SizedBox(width: 12),
        CircleAvatar(
          radius: 18,
          backgroundColor: const Color(0xFFD5DFEA),
          child: Icon(Icons.person, color: Colors.blueGrey.shade600),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF6E8A8A), width: 1.5),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: AppColors.grey),
          SizedBox(width: 10),
          Text('Cari laporan, ID lahan atau lokasi',
              style: TextStyle(fontSize: 13, color: AppColors.grey)),
        ],
      ),
    );
  }

  Widget _banner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pinkBanner,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Laporkan barang hilang atau temuan dengan mudah di Unsika Finder',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.maroon),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: widget.onReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.maroon,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Text('Laporkan Sekarang',
                      style: TextStyle(fontSize: 11)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            'assets/images/handphone.png',
            width: 110,
            height: 110,
            fit: BoxFit.contain,
            errorBuilder: (ctx, err, st) => const Icon(Icons.smartphone_rounded,
                size: 80, color: AppColors.maroon),
          ),
        ],
      ),
    );
  }

  Widget _categoryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_categories.length, (i) {
        final selected = i == _category;
        final (icon, label) = _categories[i];
        return GestureDetector(
          onTap: () => setState(() => _category = i),
          child: Column(
            children: [
              Container(
                width: 52,
                height: 48,
                decoration: BoxDecoration(
                  color: selected ? AppColors.maroon : const Color(0xFFEDEEF2),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Icon(icon,
                    color: selected ? Colors.white : AppColors.maroon),
              ),
              const SizedBox(height: 4),
              Text(label,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.maroon)),
            ],
          ),
        );
      }),
    );
  }

  Widget _itemCard(LostItem item) {
    final badgeBg =
    item.found ? const Color(0xFFD9F0E4) : const Color(0xFFFFD9D9);
    final badgeFg =
    item.found ? const Color(0xFF2E8B57) : const Color(0xFFE53935);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailScreen(item: item)),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black87, width: 1),
          ),
          child: Row(
            children: [
              // Foto barang: dari asset / internet, placeholder kalau kosong
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: ItemImage(
                  path: item.images.isNotEmpty ? item.images.first : null,
                  width: 66,
                  height: 66,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(item.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700)),
                        ),
                        Text(item.date,
                            style: const TextStyle(
                                fontSize: 11, color: AppColors.grey)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 3),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(item.statusLabel,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: badgeFg)),
                    ),
                    const SizedBox(height: 6),
                    Text(item.location,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}