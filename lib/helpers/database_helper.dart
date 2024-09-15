import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payuung_pribadi_duplicate/data/constants.dart';
import 'package:payuung_pribadi_duplicate/data/models/profile_model.dart';
import 'package:payuung_pribadi_duplicate/data/models/wellness_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'payung_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $TABLE_NAME_PROFILE (
         id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        profile_picture BLOB,
        birth_date TEXT,
        gender TEXT,
        phone_number TEXT,
        education TEXT,
        status TEXT,
        nik TEXT,
        address TEXT,
        province TEXT,
        city TEXT,
        sub_district TEXT,
        ward TEXT,
        postal_code TEXT,
        company TEXT,
        company_address TEXT,
        position TEXT,
        length_of_work INTEGER,
        source_income REAL,
        gross_income_per_year REAL,
        bank_name TEXT,
        bank_branch TEXT,
        bank_number TEXT,
        bank_account_owner_name TEXT
      )
      ''',
    );

    await db.execute(
      '''
      CREATE TABLE $TABLE_NAME_WELLNESS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL,
        discount_price REAL,
        discount REAL,
        image TEXT
      )
      ''',
    );
  }

  // * START WELLNESS
  Future<List<WellnessModel>> getWellness() async {
    final db = await database;
    final maps = await db.query(TABLE_NAME_WELLNESS);
    return List.generate(maps.length, (i) {
      return WellnessModel.fromJson(maps[i]);
    });
  }

  Future<int> insertWellness(WellnessModel wellness) async {
    final Database db = await database;
    return await db.insert(TABLE_NAME_WELLNESS, {
      'name': wellness.name,
      'price': wellness.price,
      'discount_price': wellness.discountPrice,
      'discount': wellness.discount,
      'image': wellness.image,
    });
  }

  // * END

  // * START PROFILE
  Future<int> insertInitProfile() async {
    final Database db = await database;
    return await db.insert(
      TABLE_NAME_PROFILE,
      {
        'id': ID_PROFILE,
      },
    );
  }

  Future<int> insertProfile(Profile profile, File? imageFile) async {
    final db = await database;
    List<int>? imageBytes;
    if (imageFile != null) {
      imageBytes = await imageFile.readAsBytes();
    }
    return await db.insert(TABLE_NAME_PROFILE, {
      'name': profile.name,
      'email': profile.email,
      'profile_picture': imageBytes,
      'birth_date': profile.birthDate?.toIso8601String(),
      'phone_number': profile.phoneNumber,
      'education': profile.education,
      'status': profile.status,
      'nik': profile.nik,
      'address': profile.address,
      'province': profile.province,
      'gender': profile.gender,
      'city': profile.city,
      'sub_district': profile.subDistrict,
      'ward': profile.ward,
      'postal_code': profile.postalCode,
      'company': profile.company,
      'company_address': profile.companyAddress,
      'position': profile.position,
      'length_of_work': profile.lengthOfWork,
      'source_income': profile.sourceIncome,
      'gross_income_per_year': profile.grossIncomePerYear,
      'bank_name': profile.bankName,
      'bank_branch': profile.bankBranch,
      'bank_number': profile.bankNumber,
      'bank_account_owner_name': profile.bankAccountOwnerName,
    });
  }

  Future<int> updateProfile(Profile profile, File? imageFile) async {
    final db = await database;
    List<int>? imageBytes;
    if (imageFile != null) {
      imageBytes = await imageFile.readAsBytes();
    }
    return await db.update(
      TABLE_NAME_PROFILE,
      {
        'name': profile.name,
        'email': profile.email,
        'profile_picture': imageBytes,
        'birth_date': profile.birthDate?.toIso8601String(),
        'phone_number': profile.phoneNumber,
        'education': profile.education,
        'status': profile.status,
        'nik': profile.nik,
        'address': profile.address,
        'province': profile.province,
        'city': profile.city,
        'gender': profile.gender,
        'sub_district': profile.subDistrict,
        'ward': profile.ward,
        'postal_code': profile.postalCode,
        'company': profile.company,
        'company_address': profile.companyAddress,
        'position': profile.position,
        'length_of_work': profile.lengthOfWork,
        'source_income': profile.sourceIncome,
        'gross_income_per_year': profile.grossIncomePerYear,
        'bank_name': profile.bankName,
        'bank_branch': profile.bankBranch,
        'bank_number': profile.bankNumber,
        'bank_account_owner_name': profile.bankAccountOwnerName,
      },
      where: 'id = ?',
      whereArgs: [ID_PROFILE],
    );
  }

  Future<List<Profile>> getProfiles() async {
    final db = await database;
    final maps = await db.query(TABLE_NAME_PROFILE);
    return List.generate(maps.length, (i) {
      return Profile.fromJson(maps[i]);
    });
  }

  Future<int> deleteProfile(int id) async {
    final db = await database;
    return await db
        .delete(TABLE_NAME_PROFILE, where: 'id = ?', whereArgs: [id]);
  }
  // * END
}
