class UserAddress {
  const UserAddress({
    required this.id,
    required this.userId,
    required this.title,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    this.city = 'المنستير',
    this.street,
    this.building,
    this.floor,
    this.apartmentNumber,
    this.isDefault = false,
  });

  final String id;
  final String userId;
  final String title;
  final String fullAddress;
  final double latitude;
  final double longitude;
  final String city;
  final String? street;
  final String? building;
  final String? floor;
  final String? apartmentNumber;
  final bool isDefault;

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? '',
      title: json['title'] as String? ?? 'البيت',
      fullAddress: json['full_address'] as String? ?? json['address'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 35.7643,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 10.8113,
      city: json['city'] as String? ?? 'المنستير',
      street: json['street'] as String?,
      building: json['building'] as String?,
      floor: json['floor'] as String?,
      apartmentNumber: json['apartment_number'] as String?,
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'full_address': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      if (street != null) 'street': street,
      if (building != null) 'building': building,
      if (floor != null) 'floor': floor,
      if (apartmentNumber != null) 'apartment_number': apartmentNumber,
      'is_default': isDefault,
    };
  }

  // Predefined service hubs in Monastir Governorate
  static const List<Map<String, dynamic>> serviceHubs = [
    {
      'name': 'المنستير المدينة (Centre-ville)',
      'lat': 35.7643,
      'lng': 10.8113,
    },
    {
      'name': 'صقانس (Skanès)',
      'lat': 35.7760,
      'lng': 10.7850,
    },
    {
      'name': 'خنيس (Khenis)',
      'lat': 35.7190,
      'lng': 10.8180,
    },
    {
      'name': 'صيادة (Sayada)',
      'lat': 35.6690,
      'lng': 10.8920,
    },
    {
      'name': 'الوردانين (Ouerdanine)',
      'lat': 35.7100,
      'lng': 10.6700,
    },
    {
      'name': 'الساحلين (Sahline)',
      'lat': 35.7510,
      'lng': 10.7100,
    },
  ];

  /// Checks if coordinates lie within Monastir service boundaries
  static bool isWithinServiceArea(double lat, double lng) {
    // Monastir Governorate Approximate bounds: Lat (35.50 - 35.88), Lng (10.55 - 11.05)
    const minLat = 35.50;
    const maxLat = 35.88;
    const minLng = 10.55;
    const maxLng = 11.05;

    return lat >= minLat && lat <= maxLat && lng >= minLng && lng <= maxLng;
  }
}
