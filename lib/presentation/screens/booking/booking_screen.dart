import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/constants.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/models/booking.dart';
import '../../../domain/models/cleaning_package.dart';
import '../../../domain/models/property.dart';
import '../../providers/booking_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/packages_provider.dart';
import '../../providers/property_provider.dart';
import '../../widgets/nadhafti_button.dart';

class BookingScreen extends StatefulHookConsumerWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  late DateTime _selectedDate;
  String _selectedTimeSlot = '08:30 ص';
  final Set<String> _selectedAddOnIds = {};
  final TextEditingController _notesCtrl = TextEditingController();
  bool _isLoading = false;

  static const List<String> _timeSlots = [
    '08:30 ص',
    '11:00 ص',
    '02:00 م',
    '04:30 م',
  ];

  @override
  void initState() {
    super.initState();
    // Default scheduled date: tomorrow
    _selectedDate = DateTime.now().add(const Duration(days: 1));
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  double _calculateTotal(double basePrice) {
    double total = basePrice;
    for (final addon in BookingAddOn.availableAddOns) {
      if (_selectedAddOnIds.contains(addon.id)) {
        total += addon.price;
      }
    }
    return total;
  }

  Future<void> _handleConfirmBooking({
    required CleaningPackage package,
    required Property property,
    required String addressText,
  }) async {
    setState(() => _isLoading = true);

    final total = _calculateTotal(package.basePrice);

    final booking = await ref
        .read(userBookingsProvider.notifier)
        .createBooking(
          packageId: package.id,
          packageName: package.nameAr,
          propertyId: property.id,
          propertyName: property.name,
          addressText: addressText,
          scheduledDate: _selectedDate,
          timeSlot: _selectedTimeSlot,
          basePrice: package.basePrice,
          addOns: _selectedAddOnIds.toList(),
          totalPrice: total,
          specialNotes: _notesCtrl.text.trim().isNotEmpty
              ? _notesCtrl.text.trim()
              : null,
        );

    setState(() => _isLoading = false);

    if (mounted) {
      _showSuccessDialog(booking);
    }
  }

  void _showSuccessDialog(Booking booking) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.xl),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'تم تأكيد حجزك بنجاح! 🎉',
              style: AppTextStyles.headlineSm.copyWith(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'رقم الحجز: #${booking.id.substring(booking.id.length - 6)}',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: Column(
                children: [
                  _SummaryRow(label: 'الباقة:', value: booking.packageName),
                  _SummaryRow(
                    label: 'الموعد:',
                    value:
                        '${DateFormat('yyyy/MM/dd').format(booking.scheduledDate)} - ${booking.timeSlot}',
                  ),
                  _SummaryRow(
                    label: 'العنوان:',
                    value: booking.addressText,
                  ),
                  _SummaryRow(
                    label: 'المجموع:',
                    value: '${booking.totalPrice.toStringAsFixed(0)} دت',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            NadhaftiButton(
              label: 'العودة إلى الرئيسية',
              onPressed: () {
                Navigator.of(ctx).pop();
                context.go(AppRoutes.home);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selectedPackage =
        ref.watch(selectedPackageProvider) ?? CleaningPackage.fallbackPackages.first;
    final selectedProperty =
        ref.watch(selectedPropertyProvider) ?? Property.sampleDefault;
    final selectedAddress = ref.watch(selectedAddressProvider);

    final addressText = selectedAddress?.fullAddress ?? 'المنستير، تونس';
    final totalPrice = _calculateTotal(selectedPackage.basePrice);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.booking_title),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'المبلغ الإجمالي:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '${totalPrice.toStringAsFixed(0)} دت',
                    style: AppTextStyles.headlineSm.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              NadhaftiButton(
                label: 'تأكيد الحجز الفوري',
                isLoading: _isLoading,
                onPressed: () => _handleConfirmBooking(
                  package: selectedPackage,
                  property: selectedProperty,
                  addressText: addressText,
                ),
              ),
            ],
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
              // ── Selected Summary Card ─────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.cleaning_services_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedPackage.nameAr,
                            style: AppTextStyles.labelLg.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '${selectedPackage.basePrice.toStringAsFixed(0)} دت',
                          style: AppTextStyles.labelLg.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: AppSpacing.md),
                    Row(
                      children: [
                        const Icon(
                          Icons.home_rounded,
                          color: AppColors.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${selectedProperty.name} (${selectedProperty.type.labelAr})',
                            style: AppTextStyles.bodyMd,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.push(AppRoutes.selectProperty),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('تغيير'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: AppColors.onSurfaceVariant,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            addressText,
                            style: AppTextStyles.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.push(AppRoutes.pickLocation),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('تغيير'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Date Selector ─────────────────────────────────────────────
              Text(
                'اختر التاريخ',
                style: AppTextStyles.labelLg.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 75,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 14,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final date = DateTime.now().add(Duration(days: index + 1));
                    final isSelected = DateUtils.isSameDay(date, _selectedDate);

                    final dayName = DateFormat('E', 'ar').format(date);
                    final dayNum = DateFormat('d').format(date);

                    return GestureDetector(
                      onTap: () => setState(() => _selectedDate = date),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 58,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadii.md),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.outlineVariant,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dayName,
                              style: TextStyle(
                                fontSize: 11,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              dayNum,
                              style: TextStyle(
                                fontSize: 18,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.onSurface,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Time Slots ────────────────────────────────────────────────
              Text(
                'اختر التوقيت المناسب',
                style: AppTextStyles.labelLg.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _timeSlots.map((slot) {
                  final isSelected = slot == _selectedTimeSlot;
                  return ChoiceChip(
                    label: Text(slot),
                    selected: isSelected,
                    selectedColor: AppColors.primaryContainer,
                    labelStyle: TextStyle(
                      color:
                          isSelected ? AppColors.primary : AppColors.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    onSelected: (_) => setState(() => _selectedTimeSlot = slot),
                  );
                }).toList(),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Optional Add-ons ──────────────────────────────────────────
              Text(
                'خدمات إضافية حسب الطلب',
                style: AppTextStyles.labelLg.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ...BookingAddOn.availableAddOns.map((addon) {
                final isChecked = _selectedAddOnIds.contains(addon.id);
                return Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadii.md),
                    border: Border.all(
                      color: isChecked
                          ? AppColors.primary
                          : AppColors.outlineVariant,
                    ),
                  ),
                  child: CheckboxListTile(
                    value: isChecked,
                    activeColor: AppColors.primary,
                    title: Text(
                      addon.nameAr,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    secondary: Text(
                      '+${addon.price.toStringAsFixed(0)} دت',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          _selectedAddOnIds.add(addon.id);
                        } else {
                          _selectedAddOnIds.remove(addon.id);
                        }
                      });
                    },
                  ),
                );
              }),

              const SizedBox(height: AppSpacing.lg),

              // ── Payment method ────────────────────────────────────────────
              Text(
                'طريقة الدفع',
                style: AppTextStyles.labelLg.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  border: Border.all(color: AppColors.primary, width: 1.5),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.payments_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الدفع نقدًا عند إتمام الخدمة (Espèces)',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'تدفع للعاملة مباشرة بعد فحص ومعاينة النظافة',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ],
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

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
