enum BookingStatus {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled;

  String get labelAr {
    switch (this) {
      case BookingStatus.pending:
        return 'قيد الانتظار';
      case BookingStatus.confirmed:
        return 'مؤكد';
      case BookingStatus.inProgress:
        return 'جاري التنفيذ';
      case BookingStatus.completed:
        return 'مكتمل';
      case BookingStatus.cancelled:
        return 'ملغي';
    }
  }

  static BookingStatus fromString(String val) {
    switch (val.toLowerCase()) {
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'in_progress':
      case 'inprogress':
        return BookingStatus.inProgress;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
      case 'canceled':
        return BookingStatus.cancelled;
      case 'pending':
      default:
        return BookingStatus.pending;
    }
  }
}

class BookingAddOn {
  const BookingAddOn({
    required this.id,
    required this.nameAr,
    required this.nameFr,
    required this.price,
    required this.iconName,
  });

  final String id;
  final String nameAr;
  final String nameFr;
  final double price;
  final String iconName;

  static const List<BookingAddOn> availableAddOns = [
    BookingAddOn(
      id: 'addon_oven_fridge',
      nameAr: 'تنظيف عميق للفرن والثلاجة',
      nameFr: 'Nettoyage four & réfrigérateur',
      price: 20.0,
      iconName: 'kitchen',
    ),
    BookingAddOn(
      id: 'addon_windows',
      nameAr: 'تلميع النوافذ والشرفة',
      nameFr: 'Lavage vitres et balcon',
      price: 15.0,
      iconName: 'window',
    ),
    BookingAddOn(
      id: 'addon_ironing',
      nameAr: 'كي الملابس وترتيب الخزانة',
      nameFr: 'Repassage & rangement linge',
      price: 25.0,
      iconName: 'iron',
    ),
  ];
}

class Booking {
  const Booking({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.packageName,
    required this.propertyId,
    required this.propertyName,
    required this.addressText,
    required this.scheduledDate,
    required this.timeSlot,
    required this.basePrice,
    required this.addOns,
    required this.totalPrice,
    this.status = BookingStatus.pending,
    this.paymentMethod = 'الدفع نقدًا عند الانتهاء (Espèces)',
    this.specialNotes,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final String packageId;
  final String packageName;
  final String propertyId;
  final String propertyName;
  final String addressText;
  final DateTime scheduledDate;
  final String timeSlot;
  final double basePrice;
  final List<String> addOns;
  final double totalPrice;
  final BookingStatus status;
  final String paymentMethod;
  final String? specialNotes;
  final DateTime createdAt;

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? '',
      packageId: json['package_id'] as String? ?? '',
      packageName: json['package_name'] as String? ?? 'تنظيف عادي',
      propertyId: json['property_id'] as String? ?? '',
      propertyName: json['property_name'] as String? ?? 'عقاري',
      addressText: json['address_text'] as String? ?? 'المنستير',
      scheduledDate: DateTime.tryParse(json['scheduled_date'] as String? ?? '') ??
          DateTime.now().add(const Duration(days: 1)),
      timeSlot: json['time_slot'] as String? ?? '09:00 ص',
      basePrice: (json['base_price'] as num?)?.toDouble() ?? 45.0,
      addOns: (json['add_ons'] as List<dynamic>?)?.cast<String>() ?? [],
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 45.0,
      status: BookingStatus.fromString(json['status'] as String? ?? 'pending'),
      paymentMethod: json['payment_method'] as String? ??
          'الدفع نقدًا عند الانتهاء (Espèces)',
      specialNotes: json['special_notes'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'package_id': packageId,
      'package_name': packageName,
      'property_id': propertyId,
      'property_name': propertyName,
      'address_text': addressText,
      'scheduled_date': scheduledDate.toIso8601String(),
      'time_slot': timeSlot,
      'base_price': basePrice,
      'add_ons': addOns,
      'total_price': totalPrice,
      'status': status.name,
      'payment_method': paymentMethod,
      if (specialNotes != null) 'special_notes': specialNotes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
