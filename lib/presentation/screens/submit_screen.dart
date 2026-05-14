import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/services/api_service.dart';
import '../../core/theme/app_theme.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _githubController = TextEditingController();
  bool _isLoading = false;
  bool _submitted = false;
  String _submittedAt = '';

  @override
  void initState() {
    super.initState();
    _githubController.text = 'https://github.com/';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // Confirm dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Konfirmasi Submit',
          style: GoogleFonts.rajdhani(
            color: AppTheme.onSurface,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pastikan data sudah benar. Tugas tidak dapat diubah setelah submit.',
              style: GoogleFonts.spaceGrotesk(color: AppTheme.onSurfaceMuted),
            ),
            const SizedBox(height: 16),
            _confirmRow('Produk', _nameController.text),
            _confirmRow('Harga', 'Rp ${_priceController.text}'),
            _confirmRow('GitHub', _githubController.text),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Batal',
              style: GoogleFonts.spaceGrotesk(color: AppTheme.onSurfaceMuted),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              minimumSize: const Size(80, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'SUBMIT',
              style: GoogleFonts.spaceGrotesk(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.submitTask(
        name: _nameController.text.trim(),
        price: int.parse(_priceController.text.trim()),
        description: _descController.text.trim(),
        githubUrl: _githubController.text.trim(),
      );

      final submittedAt =
          result['data']?['submission']?['submitted_at'] ?? 'Berhasil';

      setState(() {
        _submitted = true;
        _submittedAt = submittedAt;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: AppTheme.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _confirmRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                color: AppTheme.onSurfaceMuted,
                fontSize: 12,
              ),
            ),
          ),
          const Text(': ', style: TextStyle(color: AppTheme.onSurfaceMuted)),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                color: AppTheme.onSurface,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Tugas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _submitted ? _buildSuccessView() : _buildFormView(),
    );
  }

  Widget _buildSuccessView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.success.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.success.withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppTheme.success,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'TUGAS TERSUBMIT!',
              style: GoogleFonts.rajdhani(
                color: AppTheme.success,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Data kamu berhasil dikirim ke asisten praktikum.',
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                color: AppTheme.onSurfaceMuted,
                fontSize: 13,
              ),
            ),
            if (_submittedAt.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Waktu: $_submittedAt',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppTheme.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('KEMBALI KE KATALOG'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Warning Banner ────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.error.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.error.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: AppTheme.error,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Pastikan data sudah benar. Tugas tidak dapat diubah setelah submit!',
                      style: GoogleFonts.spaceGrotesk(
                        color: AppTheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            _buildLabel('NAMA PRODUK'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              style: GoogleFonts.spaceGrotesk(color: AppTheme.onSurface),
              decoration: const InputDecoration(
                hintText: 'Nama produk yang akan disubmit',
                prefixIcon: Icon(Icons.label_outline_rounded),
              ),
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? 'Wajib diisi' : null,
            ),

            const SizedBox(height: 20),

            _buildLabel('HARGA (Rp)'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.spaceGrotesk(color: AppTheme.onSurface),
              decoration: const InputDecoration(
                hintText: '32450000',
                prefixIcon: Icon(Icons.attach_money_rounded),
                prefixText: 'Rp ',
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) return 'Wajib diisi';
                if (int.tryParse(val) == null) return 'Harus berupa angka';
                return null;
              },
            ),

            const SizedBox(height: 20),

            _buildLabel('DESKRIPSI'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descController,
              maxLines: 3,
              style: GoogleFonts.spaceGrotesk(color: AppTheme.onSurface),
              decoration: const InputDecoration(
                hintText: 'Deskripsi produk...',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 48),
                  child: Icon(Icons.description_outlined),
                ),
                alignLabelWithHint: true,
              ),
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? 'Wajib diisi' : null,
            ),

            const SizedBox(height: 20),

            _buildLabel('LINK GITHUB REPOSITORY'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _githubController,
              keyboardType: TextInputType.url,
              style: GoogleFonts.spaceGrotesk(color: AppTheme.onSurface),
              decoration: const InputDecoration(
                hintText: 'https://github.com/username/repo',
                prefixIcon: Icon(Icons.link_rounded),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) return 'Wajib diisi';
                if (!val.startsWith('https://github.com/')) {
                  return 'URL harus dimulai dengan https://github.com/';
                }
                return null;
              },
            ),

            const SizedBox(height: 36),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _submit,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      )
                    : const Icon(Icons.upload_rounded, size: 20),
                label: Text(_isLoading ? 'MENGIRIM...' : 'SUBMIT TUGAS'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.spaceGrotesk(
        color: AppTheme.onSurfaceMuted,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
      ),
    );
  }
}