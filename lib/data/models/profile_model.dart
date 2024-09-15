import 'dart:typed_data';

class Profile {
  final int? id;
  String? name;
  String? email;
  Uint8List? profilePicture;
  DateTime? birthDate;
  String? gender;
  String? phoneNumber;
  String? education;
  String? status;
  String? nik;
  String? address;
  String? province;
  String? city;
  String? subDistrict;
  String? ward;
  String? postalCode;
  String? company;
  String? companyAddress;
  String? position;
  String? lengthOfWork;
  String? sourceIncome;
  String? grossIncomePerYear;
  String? bankName;
  String? bankBranch;
  String? bankNumber;
  String? bankAccountOwnerName;

  Profile({
    this.id,
    this.name,
    this.email,
    this.profilePicture,
    this.birthDate,
    this.phoneNumber,
    this.gender,
    this.education,
    this.status,
    this.nik,
    this.address,
    this.province,
    this.city,
    this.subDistrict,
    this.ward,
    this.postalCode,
    this.company,
    this.companyAddress,
    this.position,
    this.lengthOfWork,
    this.sourceIncome,
    this.grossIncomePerYear,
    this.bankName,
    this.bankBranch,
    this.bankNumber,
    this.bankAccountOwnerName,
  });

  // Convert Profile to Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_picture': profilePicture,
      'birth_date': birthDate?.toIso8601String(),
      'phone_number': phoneNumber,
      'education': education,
      'status': status,
      'nik': nik,
      'address': address,
      'province': province,
      'city': city,
      'sub_district': subDistrict,
      'gender': gender,
      'ward': ward,
      'postal_code': postalCode,
      'company': company,
      'company_address': companyAddress,
      'position': position,
      'length_of_work': lengthOfWork,
      'source_income': sourceIncome,
      'gross_income_per_year': grossIncomePerYear,
      'bank_name': bankName,
      'bank_branch': bankBranch,
      'bank_number': bankNumber,
      'bank_account_owner_name': bankAccountOwnerName,
    };
  }

  // Convert Map to Profile
  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profilePicture: map['profile_picture'] != null
          ? Uint8List.fromList(map['profile_picture'])
          : null,
      birthDate:
          map['birth_date'] != null ? DateTime.parse(map['birth_date']) : null,
      phoneNumber: map['phone_number'],
      education: map['education'],
      status: map['status'],
      nik: map['nik'],
      gender: map['gender'],
      address: map['address'],
      province: map['province'],
      city: map['city'],
      subDistrict: map['sub_district'],
      ward: map['ward'],
      postalCode: map['postal_code'],
      company: map['company'],
      companyAddress: map['company_address'],
      position: map['position'],
      lengthOfWork: map['length_of_work'],
      sourceIncome: map['source_income'],
      grossIncomePerYear: map['gross_income_per_year'],
      bankName: map['bank_name'],
      bankBranch: map['bank_branch'],
      bankNumber: map['bank_number'],
      bankAccountOwnerName: map['bank_account_owner_name'],
    );
  }
}
