class WellnessModel {
  WellnessModel({
    required this.id,
    required this.name,
    required this.price,
    this.discountPrice,
    this.discount,
    required this.image,
  });
  final int id;
  final String name;
  final double price;
  final double? discountPrice;
  final double? discount;
  final String image;

  factory WellnessModel.fromJson(Map<String, dynamic> json) {
    return WellnessModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      discountPrice: json['discount_price'],
      discount: json['discount'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'discount_price': discountPrice,
      'discount': discount,
      'image': image,
    };
  }
}

List<WellnessModel> dummyWellness = [
  WellnessModel.fromJson({
    'id': 1,
    'name': 'Voucher Digital Indomaret Rp 25.000',
    'price': 25000.0,
    'discount_price': null,
    'discount': null,
    'image':
        'https://upload.wikimedia.org/wikipedia/commons/9/9d/Logo_Indomaret.png'
  }),
  WellnessModel.fromJson({
    'id': 2,
    'name': 'Voucher Digital H%M Rp 100.000',
    'price': 100000.0,
    'discount_price': 97000.0,
    'discount': 3.0,
    'image':
        'https://brandslogos.com/wp-content/uploads/images/large/hm-logo-1.png'
  }),
  WellnessModel.fromJson({
    'id': 3,
    'name': 'Voucher Digital Grab Rp 20.000',
    'price': 20000.0,
    'discount_price': null,
    'discount': null,
    'image':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiisJU-YODn2lfo3mxMIKWuEyYcxZL3yDldBPIvOmVubwRmB8T6zJO4nZDP2GnWLaQiEo5D61U-nymK7c-8eQ7evMI_AusDl-odmPGyy3OStF5ABTt4lcfHbEdSLaBQCgrzqLkhdm5nA_U/s640/Grab+Logo+-+Free+Vector+Download+PNG.webp'
  }),
  WellnessModel.fromJson({
    'id': 4,
    'name': 'Voucher Digital Excelso Rp 50.000',
    'price': 50000.0,
    'discount_price': 48000.0,
    'discount': 4.0,
    'image': 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Excelso.png'
  }),
  WellnessModel.fromJson({
    'id': 5,
    'name': 'Voucher Digital Bakmi GM Rp 100.000',
    'price': 100000.0,
    'discount_price': 95000.0,
    'discount': 5.0,
    'image':
        'https://www.uob.co.id/web-resources/images/personal/kartu-kredit/promo/microsite/Logo-Bakmi-GM.jpg'
  }),
  WellnessModel.fromJson({
    'id': 6,
    'name': 'Voucher Digital AlfaMart Rp 25.000',
    'price': 25000.0,
    'discount_price': null,
    'discount': null,
    'image':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg4xa07aNw_lhyphenhyphen-GyZ4YSt5hReEG15IkXQd-MOShY_QYYOcIFLye3b1RKDOY1o9TLFjavoiRiq4g6azx_SqvukYftpz6C2qEONs4_MN-kIm60ijb7KcYiFt_cRD-yY9Tg-e329WfkpQHKA/s640/Logo+Alfamart+-+Free+Vector+Download+PNG.webp'
  }),
];
