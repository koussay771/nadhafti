enum PropertyType {
  apartment,
  house,
  villa,
  office;

  String get labelAr {
    switch (this) {
      case PropertyType.apartment:
        return 'شقة';
      case PropertyType.house:
        return 'منزل';
      case PropertyType.villa:
        return 'فيلا';
      case PropertyType.office:
        return 'مكتب / محل';
    }
  }

  String get labelFr {
    switch (this) {
      case PropertyType.apartment:
        return 'Appartement';
      case PropertyType.house:
        return 'Maison';
      case PropertyType.villa:
        return 'Villa';
      case PropertyType.office:
        return 'Bureau';
    }
  }

  static PropertyType fromString(String val) {
    switch (val.toLowerCase()) {
      case 'house':
      case 'منزل':
        return PropertyType.house;
      case 'villa':
      case 'فيلا':
        return PropertyType.villa;
      case 'office':
      case 'مكتب':
        return PropertyType.office;
      case 'apartment':
      case 'شقة':
      default:
        return PropertyType.apartment;
    }
  }
}

class Property {
  const Property({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    this.bedrooms = 2,
    this.bathrooms = 1,
    this.areaSqm = 85.0,
    this.hasPets = false,
    this.specialNotes,
    this.addressId,
  });

  final String id;
  final String userId;
  final String name;
  final PropertyType type;
  final int bedrooms;
  final int bathrooms;
  final double areaSqm;
  final bool hasPets;
  final String? specialNotes;
  final String? addressId;

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? '',
      name: json['name'] as String? ?? 'عقاري',
      type: PropertyType.fromString(json['type'] as String? ?? 'apartment'),
      bedrooms: (json['bedrooms'] as num?)?.toInt() ?? 2,
      bathrooms: (json['bathrooms'] as num?)?.toInt() ?? 1,
      areaSqm: (json['area_sqm'] as num?)?.toDouble() ?? 85.0,
      hasPets: json['has_pets'] as bool? ?? false,
      specialNotes: json['special_notes'] as String?,
      addressId: json['address_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'type': type.name,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area_sqm': areaSqm,
      'has_pets': hasPets,
      if (specialNotes != null) 'special_notes': specialNotes,
      if (addressId != null) 'address_id': addressId,
    };
  }

  // Fallback initial sample property for quick testing
  static const Property sampleDefault = Property(
    id: 'prop_sample_1',
    userId: '',
    name: 'شقتي بالمنستير',
    type: PropertyType.apartment,
    bedrooms: 2,
    bathrooms: 1,
    areaSqm: 90,
  );
}
