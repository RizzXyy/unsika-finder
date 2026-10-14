import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/page_header.dart';
import '../widgets/segmented_tabs.dart';

class ReportScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ReportScreen({super.key, this.onBack});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _type = 0; // 0 = Barang Hilang, 1 = Barang Temuan
  String? _category;

  final _nameC = TextEditingController();
  final _locationC = TextEditingController();
  final _dateC = TextEditingController();
  final _descC = TextEditingController();

  static const _categories = ['Elektronik', 'Dokumen', 'Tas', 'Kunci', 'Lainnya'];
  static const _months = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];

  @override
  void dispose() {
    _nameC.dispose();
    _locationC.dispose();
    _dateC.dispose();
    _descC.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    );
    if (picked != null) {
      _dateC.text = '${picked.day} ${_months[picked.month - 1]} ${picked.year}';
    }
  }

  void _submit() {
    final empty = _category == null ||
        _nameC.text.trim().isEmpty ||
        _locationC.text.trim().isEmpty ||
        _dateC.text.trim().isEmpty ||
        _descC.text.trim().isEmpty;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(empty
            ? 'Lengkapi semua data terlebih dahulu'
            : 'Laporan berhasil dikirim'),
      ),
    );

    if (!empty) {
      setState(() => _category = null);
      _nameC.clear();
      _locationC.clear();
      _dateC.clear();
      _descC.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel = _type == 0 ? 'Tanggal Kehilangan' : 'Tanggal Ditemukan';

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            PageHeader(title: 'Lapor Barang', onBack: widget.onBack),
            const SizedBox(height: 16),
            SegmentedTabs(
              labels: const ['Barang Hilang', 'Barang Temuan'],
              selected: _type,
              onChanged: (i) => setState(() => _type = i),
            ),
            const SizedBox(height: 16),

            _label('Kategori Barang'),
            DropdownButtonFormField<String>(
              value: _category,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              decoration: _decoration('Pilih Kategori'),
              items: _categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _category = v),
            ),
            const SizedBox(height: 14),

            _label('Nama Barang'),
            TextField(
              controller: _nameC,
              decoration: _decoration('Masukkan Nama Barang'),
            ),
            const SizedBox(height: 14),

            _label('Lokasi'),
            TextField(
              controller: _locationC,
              decoration: _decoration(
                'Pilih Lokasi',
                prefix: Icons.location_on,
              ),
            ),
            const SizedBox(height: 14),

            _label(dateLabel),
            TextField(
              controller: _dateC,
              readOnly: true,
              onTap: _pickDate,
              decoration: _decoration(
                'Pilih Tanggal',
                prefix: Icons.calendar_month_outlined,
              ),
            ),
            const SizedBox(height: 14),

            _label('Deskripsi'),
            TextField(
              controller: _descC,
              minLines: 1,
              maxLines: 4,
              decoration: _decoration('Jelaskan Detail Barang'),
            ),
            const SizedBox(height: 14),

            const Text('Upload Foto',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87)),
            const SizedBox(height: 8),
            _uploadBox(),
            const SizedBox(height: 16),

            SizedBox(
              height: 46,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.maroonDark,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Kirim Laporan',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppColors.maroon)),
  );

  InputDecoration _decoration(String hint, {IconData? prefix}) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.border, width: 1.5),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      prefixIcon: prefix != null
          ? Icon(prefix, color: AppColors.maroon, size: 22)
          : null,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: AppColors.maroon, width: 1.5),
      ),
    );
  }

  Widget _uploadBox() {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fitur pilih foto belum diaktifkan')),
      ),
      child: CustomPaint(
        foregroundPainter: _DashedBorderPainter(const Color(0xFFB06A80)),
        child: Container(
          height: 118,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFFBDCDC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo_camera_outlined,
                  size: 34, color: AppColors.maroonDark),
              SizedBox(height: 8),
              Text('Pilih foto atau tarik di sini',
                  style: TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Garis putus-putus untuk kotak upload foto
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  _DashedBorderPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Offset.zero & size, const Radius.circular(10)));
    for (final metric in path.computeMetrics()) {
      double d = 0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 6), paint);
        d += 10;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) => old.color != color;
}