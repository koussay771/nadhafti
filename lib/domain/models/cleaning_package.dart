class CleaningPackage {
  const CleaningPackage({
    required this.id,
    required this.nameAr,
    required this.nameFr,
    required this.descriptionAr,
    required this.descriptionFr,
    required this.basePrice,
    required this.durationHours,
    required this.iconName,
    this.isPopular = false,
  });

  final String id;
  final String nameAr;
  final String nameFr;
  final String descriptionAr;
  final String descriptionFr;
  final double basePrice;
  final int durationHours;
  final String iconName;
  final bool isPopular;

  String localizedName(String locale) => locale.startsWith('fr') ? nameFr : nameAr;
  String localizedDescription(String locale) =>
      locale.startsWith('fr') ? descriptionFr : descriptionAr;

  factory CleaningPackage.fromJson(Map<String, dynamic> json) {
    return CleaningPackage(
      id: json['id'] as String,
      nameAr: json['name_ar'] as String? ?? json['name'] as String? ?? '',
      nameFr: json['name_fr'] as String? ?? '',
      descriptionAr: json['description_ar'] as String? ??
          json['description'] as String? ??
          '',
      descriptionFr: json['description_fr'] as String? ?? '',
      basePrice: (json['base_price'] as num?)?.toDouble() ?? 0.0,
      durationHours: (json['duration_hours'] as num?)?.toInt() ?? 2,
      iconName: json['icon_name'] as String? ?? 'cleaning_services',
      isPopular: json['is_popular'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_fr': nameFr,
      'description_ar': descriptionAr,
      'description_fr': descriptionFr,
      'base_price': basePrice,
      'duration_hours': durationHours,
      'icon_name': iconName,
      'is_popular': isPopular,
    };
  }

  // Fallback / Initial Seed Data (as confirmed by user: 45 DT / 75 DT / 110 DT / 60 DT)
  static const List<CleaningPackage> fallbackPackages = [
    CleaningPackage(
      id: 'pkg_standard',
      nameAr: 'تنظيف عادي',
      nameFr: 'Nettoyage Standard',
      descriptionAr: 'تنظيف شامل للغرف، كنس ومسح الأرضيات، ومسح الغبار',
      descriptionFr: 'Nettoyage des pièces, balayage, dépoussiérage',
      basePrice: 45.0,
      durationHours: 2,
      iconName: 'sparkles',
      isPopular: true,
    ),
    CleaningPackage(
      id: 'pkg_deep',
      nameAr: 'تنظيف عميق',
      nameFr: 'Nettoyage Profond',
      descriptionAr: 'تنظيف دقيق ومفصل للمطابخ، الحمامات، والزوايا الصعبة',
      descriptionFr: 'Désinfection cuisine, salle de bain, recoins',
      basePrice: 75.0,
      durationHours: 4,
      iconName: 'health_and_safety',
      isPopular: false,
    ),
    CleaningPackage(
      id: 'pkg_move_in_out',
      nameAr: 'تنظيف عند الانتقال',
      nameFr: 'Nettoyage Déménagement',
      descriptionAr: 'تجهيز البيت للسكن أو بعد الرحيل مع إزالة كافة البقع والأوساخ',
      descriptionFr: 'Préparation du logement avant ou après déménagement',
      basePrice: 110.0,
      durationHours: 6,
      iconName: 'home_work',
      isPopular: false,
    ),
    CleaningPackage(
      id: 'pkg_office',
      nameAr: 'تنظيف مكاتب ومحلات',
      nameFr: 'Nettoyage Bureau',
      descriptionAr: 'ترتيب وتنظيف فضاءات العمل، المكاتب، والأرضيات المهنية',
      descriptionFr: 'Entretien des espaces de travail et bureaux',
      basePrice: 60.0,
      durationHours: 3,
      iconName: 'business',
      isPopular: false,
    ),
  ];
}
