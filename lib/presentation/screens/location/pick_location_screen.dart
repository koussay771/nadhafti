import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/models/user_address.dart';
import '../../providers/location_provider.dart';
import '../../widgets/nadhafti_button.dart';

class PickLocationScreen extends StatefulHookConsumerWidget {
  const PickLocationScreen({super.key});

  @override
  ConsumerState<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends ConsumerState<PickLocationScreen> {
  GoogleMapController? _mapController;

  // Default initial position: Monastir, Tunisia
  static const LatLng _initialPosition = LatLng(35.7643, 10.8113);
  LatLng _currentPosition = _initialPosition;
  String _selectedHubName = 'المنستير المدينة (Centre-ville)';
  bool _isServiceable = true;

  final TextEditingController _streetCtrl = TextEditingController();
  final TextEditingController _buildingCtrl = TextEditingController();
  final TextEditingController _aptCtrl = TextEditingController();

  @override
  void dispose() {
    _mapController?.dispose();
    _streetCtrl.dispose();
    _buildingCtrl.dispose();
    _aptCtrl.dispose();
    super.dispose();
  }

  void _onCameraMove(CameraPosition position) {
    _currentPosition = position.target;
    final isWithin = UserAddress.isWithinServiceArea(
      _currentPosition.latitude,
      _currentPosition.longitude,
    );
    if (_isServiceable != isWithin) {
      setState(() {
        _isServiceable = isWithin;
      });
    }
  }

  void _moveToHub(Map<String, dynamic> hub) {
    final lat = hub['lat'] as double;
    final lng = hub['lng'] as double;
    final name = hub['name'] as String;

    setState(() {
      _selectedHubName = name;
      _currentPosition = LatLng(lat, lng);
      _isServiceable = true;
    });

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 14.5,
        ),
      ),
    );
  }

  void _confirmLocation() {
    if (!_isServiceable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.error,
          content: Text(
            'عذرًا، الموقع المحدد خارج منطقة التغطية الحالية بالمنستير.',
          ),
        ),
      );
      return;
    }

    final address = UserAddress(
      id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
      userId: '',
      title: _selectedHubName,
      fullAddress:
          '$_selectedHubName${_streetCtrl.text.isNotEmpty ? '، شارع ${_streetCtrl.text}' : ''}',
      latitude: _currentPosition.latitude,
      longitude: _currentPosition.longitude,
      street: _streetCtrl.text.trim(),
      building: _buildingCtrl.text.trim(),
      apartmentNumber: _aptCtrl.text.trim(),
    );

    ref.read(selectedAddressProvider.notifier).setAddress(address);

    if (context.canPop()) {
      context.pop();
    } else {
      context.push(AppRoutes.selectProperty);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.location_title),
        elevation: 0,
        backgroundColor: AppColors.surface,
      ),
      body: Stack(
        children: [
          // ── Google Map View ───────────────────────────────────────────────
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _initialPosition,
              zoom: 13.5,
            ),
            onMapCreated: (controller) => _mapController = controller,
            onCameraMove: _onCameraMove,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            mapToolbarEnabled: false,
          ),

          // ── Center Pin Indicator ─────────────────────────────────────────
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _isServiceable
                          ? AppColors.primary
                          : AppColors.error,
                      borderRadius: BorderRadius.circular(AppRadii.full),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Text(
                      _isServiceable ? 'الموقع المحدد 📍' : 'خارج التغطية ⚠️',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(
                    Icons.location_pin,
                    size: 44,
                    color: _isServiceable
                        ? AppColors.primary
                        : AppColors.error,
                  ),
                ],
              ),
            ),
          ),

          // ── Quick Service Hubs Selector (Top horizontal list) ─────────────
          Positioned(
            top: AppSpacing.sm,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.containerMargin,
                ),
                itemCount: UserAddress.serviceHubs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final hub = UserAddress.serviceHubs[index];
                  final isSelected = hub['name'] == _selectedHubName;
                  return ChoiceChip(
                    label: Text(hub['name'] as String),
                    selected: isSelected,
                    selectedColor: AppColors.primaryContainer,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 12,
                    ),
                    onSelected: (_) => _moveToHub(hub),
                  );
                },
              ),
            ),
          ),

          // ── Out-of-area Warning Alert Banner (if applicable) ──────────────
          if (!_isServiceable)
            Positioned(
              top: 56,
              left: AppSpacing.containerMargin,
              right: AppSpacing.containerMargin,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.errorContainer,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.onErrorContainer,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.location_unavailable_body,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.onErrorContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // ── Bottom Location Confirmation Sheet ────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.containerMargin),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppRadii.xxl),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.outlineVariant,
                          borderRadius: BorderRadius.circular(AppRadii.full),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    Row(
                      children: [
                        const Icon(
                          Icons.place_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _selectedHubName,
                            style: AppTextStyles.headlineSm.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Additional optional details (Street, Building, Apt)
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _streetCtrl,
                            decoration: const InputDecoration(
                              labelText: 'الشارع / الحي',
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: TextField(
                            controller: _buildingCtrl,
                            decoration: const InputDecoration(
                              labelText: 'العمارة / المنزل',
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Confirm CTA Button
                    NadhaftiButton(
                      label: _isServiceable
                          ? 'تأكيد هذا العنوان'
                          : 'الموقع غير مدعوم حاليًا',
                      onPressed: _isServiceable ? _confirmLocation : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
