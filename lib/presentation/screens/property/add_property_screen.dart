import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../domain/models/property.dart';
import '../../providers/property_provider.dart';
import '../../widgets/nadhafti_button.dart';

class AddPropertyScreen extends StatefulHookConsumerWidget {
  const AddPropertyScreen({super.key});

  @override
  ConsumerState<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends ConsumerState<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController(text: 'بيتي بالمنستير');
  final _areaCtrl = TextEditingController(text: '90');
  final _notesCtrl = TextEditingController();

  PropertyType _selectedType = PropertyType.apartment;
  int _bedrooms = 2;
  int _bathrooms = 1;
  bool _hasPets = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _areaCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveProperty() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final area = double.tryParse(_areaCtrl.text.trim()) ?? 80.0;

    await ref.read(userPropertiesProvider.notifier).addProperty(
          name: _nameCtrl.text.trim(),
          type: _selectedType,
          bedrooms: _bedrooms,
          bathrooms: _bathrooms,
          areaSqm: area,
          hasPets: _hasPets,
          specialNotes: _notesCtrl.text.trim().isNotEmpty
              ? _notesCtrl.text.trim()
              : null,
        );

    setState(() => _isLoading = false);

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.property_add),
        elevation: 0,
        backgroundColor: AppColors.surface,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.containerMargin),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.outlineVariant, width: 0.8),
          ),
        ),
        child: SafeArea(
          child: NadhaftiButton(
            label: l10n.property_save,
            isLoading: _isLoading,
            onPressed: _saveProperty,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.containerMargin,
              vertical: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Property Name ───────────────────────────────────────────
                Text(
                  'اسم العقار',
                  style: AppTextStyles.labelLg.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    hintText: 'مثال: شقة صقانس، فيلا المنستير...',
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'يرجى إدخال اسم العقار' : null,
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Property Type ───────────────────────────────────────────
                Text(
                  'نوع العقار',
                  style: AppTextStyles.labelLg.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: PropertyType.values.map((type) {
                    final isSelected = type == _selectedType;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: ChoiceChip(
                          label: Text(type.labelAr),
                          selected: isSelected,
                          selectedColor: AppColors.primaryContainer,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.onSurface,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            fontSize: 12,
                          ),
                          onSelected: (_) =>
                              setState(() => _selectedType = type),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppSpacing.xl),

                // ── Steppers: Bedrooms & Bathrooms ──────────────────────────
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Column(
                    children: [
                      _CounterRow(
                        label: l10n.property_rooms,
                        icon: Icons.bed_rounded,
                        value: _bedrooms,
                        min: 1,
                        max: 8,
                        onChanged: (val) => setState(() => _bedrooms = val),
                      ),
                      const Divider(height: AppSpacing.xl),
                      _CounterRow(
                        label: l10n.property_bathrooms,
                        icon: Icons.bathtub_rounded,
                        value: _bathrooms,
                        min: 1,
                        max: 5,
                        onChanged: (val) => setState(() => _bathrooms = val),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Area in Sqm ─────────────────────────────────────────────
                Text(
                  'المساحة التقريبية (م²)',
                  style: AppTextStyles.labelLg.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TextFormField(
                  controller: _areaCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    suffixText: 'متر مربع (م²)',
                    hintText: '85',
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Pets toggle ─────────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'يوجد حيوانات أليفة في المنزل 🐾',
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    value: _hasPets,
                    activeThumbColor: AppColors.primary,
                    onChanged: (val) => setState(() => _hasPets = val),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Additional Notes ────────────────────────────────────────
                Text(
                  'ملاحظات إضافية للعاملات (اختياري)',
                  style: AppTextStyles.labelLg.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TextFormField(
                  controller: _notesCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText:
                        'مثال: التركيز على المطبخ، النوافذ تحتاج تنظيف خاص...',
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CounterRow extends StatelessWidget {
  const _CounterRow({
    required this.label,
    required this.icon,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMd.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            IconButton.filledTonal(
              onPressed: value > min ? () => onChanged(value - 1) : null,
              icon: const Icon(Icons.remove_rounded, size: 18),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.surfaceContainerHigh,
                foregroundColor: AppColors.onSurface,
              ),
            ),
            SizedBox(
              width: 36,
              child: Text(
                '$value',
                style: AppTextStyles.labelLg.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            IconButton.filledTonal(
              onPressed: value < max ? () => onChanged(value + 1) : null,
              icon: const Icon(Icons.add_rounded, size: 18),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
