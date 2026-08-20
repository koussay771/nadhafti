import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/models/property.dart';
import '../../providers/property_provider.dart';
import '../../widgets/nadhafti_button.dart';

class SelectPropertyScreen extends HookConsumerWidget {
  const SelectPropertyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final propertiesAsync = ref.watch(userPropertiesProvider);
    final selectedProperty = ref.watch(selectedPropertyProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.property_title),
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
            label: 'متابعة إلى تفاصيل الحجز',
            onPressed: selectedProperty != null
                ? () => context.push(AppRoutes.booking)
                : null,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.containerMargin,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header title
              Text(
                'اختر العقار المراد تنظيفه',
                style: AppTextStyles.headlineSm.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'تساعدنا تفاصيل العقار في تجهيز المعدات المناسبة والوقت اللازم',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Properties list
              propertiesAsync.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
                error: (_, __) => const Text('حدث خطأ في تحميل العقارات'),
                data: (properties) {
                  if (properties.isEmpty) {
                    return _EmptyPropertyView(
                      onAdd: () => context.push(AppRoutes.addProperty),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: properties.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final property = properties[index];
                      final isSelected = selectedProperty?.id == property.id;

                      return _PropertyCard(
                        property: property,
                        isSelected: isSelected,
                        onTap: () {
                          ref
                              .read(selectedPropertyProvider.notifier)
                              .select(property);
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: AppSpacing.xl),

              // Add new property button
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.addProperty),
                icon: const Icon(Icons.add_home_rounded, color: AppColors.primary),
                label: Text(
                  l10n.property_add,
                  style: AppTextStyles.labelLg.copyWith(color: AppColors.primary),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, AppSpacing.touchTarget),
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.full),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({
    required this.property,
    required this.isSelected,
    required this.onTap,
  });

  final Property property;
  final bool isSelected;
  final VoidCallback onTap;

  IconData _getTypeIcon(PropertyType type) {
    switch (type) {
      case PropertyType.apartment:
        return Icons.apartment_rounded;
      case PropertyType.house:
        return Icons.home_rounded;
      case PropertyType.villa:
        return Icons.villa_rounded;
      case PropertyType.office:
        return Icons.business_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.outlineVariant,
              width: isSelected ? 2.0 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryContainer
                      : AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: Icon(
                  _getTypeIcon(property.type),
                  color: isSelected ? AppColors.primary : AppColors.onSurface,
                  size: 26,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          property.name,
                          style: AppTextStyles.labelLg.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(AppRadii.sm),
                          ),
                          child: Text(
                            property.type.labelAr,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _DetailChip(
                          icon: Icons.bed_rounded,
                          label: '${property.bedrooms} غرف',
                        ),
                        const SizedBox(width: 8),
                        _DetailChip(
                          icon: Icons.bathtub_rounded,
                          label: '${property.bathrooms} حمام',
                        ),
                        const SizedBox(width: 8),
                        _DetailChip(
                          icon: Icons.square_foot_rounded,
                          label: '${property.areaSqm.toInt()} م²',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.outlineVariant,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.onSurfaceVariant),
        const SizedBox(width: 3),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _EmptyPropertyView extends StatelessWidget {
  const _EmptyPropertyView({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            const Icon(
              Icons.home_work_outlined,
              size: 64,
              color: AppColors.primaryFixedDim,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'لا يوجد عقار محفوظ بعد',
              style: AppTextStyles.headlineSm,
            ),
            const SizedBox(height: 4),
            Text(
              'أضف عقارك الأول لتسهيل الحجز واحتساب الوقت بدقة',
              style: AppTextStyles.bodyMd,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: onAdd,
              child: const Text('إضافة عقار الآن'),
            ),
          ],
        ),
      ),
    );
  }
}
