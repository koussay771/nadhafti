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
  int _selectedTimeIndex = 0;
  final Set<String> _selectedAddOnIds = {};
  final TextEditingController _notesCtrl = TextEditingController();
  bool _isLoading = false;

  static const List<Map<String, String>> _timeSlotOptions = [
    {'ar': '08:30 ص', 'fr': '08:30'},
    {'ar': '11:00 ص', 'fr': '11:00'},
    {'ar': '02:00 م', 'fr': '14:00'},
    {'ar': '04:30 م', 'fr': '16:30'},
  ];

  @override
  void initState() {
    super.initState();
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
    required String locale,
    required AppLocalizations l10n,
  }) async {
    setState(() => _isLoading = true);

    try {
      final total = _calculateTotal(package.basePrice);
      final timeSlot = locale == 'ar'
          ? _timeSlotOptions[_selectedTimeIndex]['ar']!
          : _timeSlotOptions[_selectedTimeIndex]['fr']!;

      final booking = await ref
          .read(userBookingsProvider.notifier)
          .createBooking(
            packageId: package.id,
            packageName: package.localizedName(locale),
            propertyId: property.id,
            propertyName: property.name,
            addressText: addressText,
            scheduledDate: _selectedDate,
            timeSlot: timeSlot,
            basePrice: package.basePrice,
            addOns: _selectedAddOnIds.toList(),
            totalPrice: total,
            specialNotes: _notesCtrl.text.trim().isNotEmpty
                ? _notesCtrl.text.trim()
                : null,
          );

      if (mounted) {
        _showSuccessDialog(booking, locale, l10n);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.error,
            content: Text(
              locale == 'ar'
                  ? 'حدث خطأ أثناء الحجز: $e'
                  : 'Une erreur est survenue lors de la réservation : $e',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessDialog(Booking booking, String locale, AppLocalizations l10n) {
    final currency = locale == 'ar' ? 'دت' : 'DT';
    final dateFormat = locale == 'ar' ? 'yyyy/MM/dd' : 'dd/MM/yyyy';

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
              l10n.booking_success_title,
              style: AppTextStyles.headlineSm.copyWith(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '${l10n.booking_num} #${booking.id.length > 6 ? booking.id.substring(booking.id.length - 6) : booking.id}',
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
                  _SummaryRow(label: l10n.booking_package_label, value: booking.packageName),
                  _SummaryRow(
                    label: l10n.booking_date_label,
                    value:
                        '${DateFormat(dateFormat).format(booking.scheduledDate)} - ${booking.timeSlot}',
                  ),
                  _SummaryRow(
                    label: l10n.booking_address_label,
                    value: booking.addressText,
                  ),
                  _SummaryRow(
                    label: l10n.booking_total_label,
                    value: '${booking.totalPrice.toStringAsFixed(0)} $currency',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            NadhaftiButton(
              label: l10n.booking_return_home,
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
    final locale = Localizations.localeOf(context).languageCode;
    final currency = locale == 'ar' ? 'دت' : 'DT';

    final packagesAsync = ref.watch(cleaningPackagesProvider);
    final allPackages = packagesAsync.asData?.value ?? CleaningPackage.fallbackPackages;

    // Use current selected package, or fallback to first
    final selectedPackage = ref.watch(selectedPackageProvider) ?? allPackages.first;
    final selectedProperty =
        ref.watch(selectedPropertyProvider) ?? Property.sampleDefault;
    final selectedAddress = ref.watch(selectedAddressProvider);

    final addressText = selectedAddress?.fullAddress ?? (locale == 'ar' ? 'المنستير، تونس' : 'Monastir, Tunisie');
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
                  Text(
                    l10n.booking_total,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '${totalPrice.toStringAsFixed(0)} $currency',
                    style: AppTextStyles.headlineSm.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              NadhaftiButton(
                label: l10n.booking_confirm_cta,
                isLoading: _isLoading,
                onPressed: () => _handleConfirmBooking(
                  package: selectedPackage,
                  property: selectedProperty,
                  addressText: addressText,
                  locale: locale,
                  l10n: l10n,
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
              // ── Package Horizontal Selector ──────────────────────────────
              Text(
                l10n.booking_select_package_title,
                style: AppTextStyles.labelLg.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: allPackages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final pkg = allPackages[index];
                    final isSelected = pkg.id == selectedPackage.id;

                    return GestureDetector(
                      onTap: () {
                        ref.read(selectedPackageProvider.notifier).select(pkg);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 150,
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryContainer.withValues(alpha: 0.5)
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(AppRadii.lg),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.outlineVariant,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.check_circle_rounded
                                      : Icons.cleaning_services_rounded,
                                  size: 18,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.onSurfaceVariant,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    pkg.localizedName(locale),
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.w800
                                          : FontWeight.w600,
                                      fontSize: 12,
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.onSurface,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${pkg.basePrice.toStringAsFixed(0)} $currency',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // ── Summary Card (Property & Location) ────────────────────────
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
                          Icons.home_rounded,
                          color: AppColors.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${selectedProperty.name} (${locale == 'ar' ? selectedProperty.type.labelAr : selectedProperty.type.name})',
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
                          child: Text(l10n.booking_change),
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
                          child: Text(l10n.booking_change),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Date Selector ─────────────────────────────────────────────
              Text(
                l10n.booking_choose_date,
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

                    final dayName = DateFormat('E', locale).format(date);
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
                l10n.booking_choose_time,
                style: AppTextStyles.labelLg.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(_timeSlotOptions.length, (idx) {
                  final isSelected = idx == _selectedTimeIndex;
                  final slotText = locale == 'ar'
                      ? _timeSlotOptions[idx]['ar']!
                      : _timeSlotOptions[idx]['fr']!;

                  return ChoiceChip(
                    label: Text(slotText),
                    selected: isSelected,
                    selectedColor: AppColors.primaryContainer,
                    labelStyle: TextStyle(
                      color:
                          isSelected ? AppColors.primary : AppColors.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                    onSelected: (_) => setState(() => _selectedTimeIndex = idx),
                  );
                }),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Optional Add-ons ──────────────────────────────────────────
              Text(
                l10n.booking_addons_title,
                style: AppTextStyles.labelLg.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ...BookingAddOn.availableAddOns.map((addon) {
                final isChecked = _selectedAddOnIds.contains(addon.id);
                final addonName = locale == 'ar' ? addon.nameAr : addon.nameFr;

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
                      addonName,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    secondary: Text(
                      '+${addon.price.toStringAsFixed(0)} $currency',
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
                l10n.booking_payment_title,
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
                child: Row(
                  children: [
                    const Icon(
                      Icons.payments_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.booking_payment_cash,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            l10n.booking_payment_cash_desc,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
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
