import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:payuung_pribadi_duplicate/data/constants.dart';
import 'package:payuung_pribadi_duplicate/data/models/profile_model.dart';
import 'package:payuung_pribadi_duplicate/presentation/cubit/profile_cubit.dart';
import 'package:payuung_pribadi_duplicate/presentation/widgets/global_dropdown.dart';
import 'package:payuung_pribadi_duplicate/presentation/widgets/global_textformfield.dart';
import 'package:payuung_pribadi_duplicate/services/styles.dart';
import 'package:payuung_pribadi_duplicate/utils/file_utils.dart';
import 'package:payuung_pribadi_duplicate/utils/string_util.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker picker = ImagePicker();
  final List<String> _genders = ['Laki-laki', 'Perempuan'];
  final List<String> _educations = [
    'SD',
    'SMP',
    'SMA',
    'D1',
    'D2',
    'D3',
    'S1',
    'S2',
    'S3',
  ];
  final List<String> _statusMarried = [
    'Belum Kawin',
    'Kawin',
    'Janda',
    'Duda',
  ];
  final List<String> _provinces = [
    'Jawa Barat',
    'Jawa Timur',
    'Jawa Tengah',
    'DKI Jakarta'
  ];
  final List<String> _cities = [
    'Kota Bandung',
    'Kota Surabaya',
    'Kab Majalengka',
    'Kota Jakarta'
  ];
  final List<String> _subDisctircts = [
    'Bojongloa Kidul',
    'Bojongloa Tengah',
    'Kertajati',
    'Benhil'
  ];
  final List<String> _wards = [
    'Kebon Lega',
    'Kebon Sempit',
    'Bantarjati',
    'Sukawana'
  ];
  final List<String> _positions = [
    'Non-Staf',
    'Staf',
    'SPV',
    'Directur',
  ];
  final List<String> _lengthWork = [
    '< 6 Bulan',
    '6 Bulan - 1 Tahun',
    '1 - 2 Tahun',
    '> 2 Tahun',
  ];
  final List<String> _incomeSource = [
    'Gaji',
    'Keuntungan Bisnis',
  ];
  final List<String> _grossIncome = [
    '10 - 50 Juta',
    '100 - 500 Juta',
  ];
  final List<String> _bankNames = [
    'Bank BCA',
    'Bank Mandiri',
    'Bank BNI',
    'Bank BRI',
  ];
  final TextEditingController controllerFullName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPhoneNumber = TextEditingController();
  final TextEditingController controllerNik = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerPostalCode = TextEditingController();
  final TextEditingController controllerCompanyName = TextEditingController();
  final TextEditingController controllerCompanyAddress =
      TextEditingController();
  final TextEditingController controllerBankBranch = TextEditingController();
  final TextEditingController controllerBankAccountOwnerName =
      TextEditingController();
  final TextEditingController controllerBankAccountNumber =
      TextEditingController();
  String? _selectedPosition;
  String? _selectedHowLongHasWork;
  String? _selectedIncomeSource;
  String? _selectedGrossIncome;
  String? _selectedBankName;
  String? _selectedGender;
  String? _selectedEducation;
  String? _selectedStatus;
  String? _selectedProvice;
  String? _selectedCity;
  String? _selectedSubDisctrict;
  String? _selectedWard;

  DateTime? _selectedDate;
  File? _ktpPicture;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controllerFullName.dispose();
    controllerEmail.dispose();
    controllerPhoneNumber.dispose();
    controllerNik.dispose();
    controllerAddress.dispose();
    controllerPostalCode.dispose();
    controllerCompanyName.dispose();
    controllerCompanyAddress.dispose();
    controllerBankBranch.dispose();
    controllerBankAccountOwnerName.dispose();
    controllerBankAccountNumber.dispose();
  }

  void setIndex(int index) => setState(() {
        currentStep = index;
      });

  Future selectDate(BuildContext context) async => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1999),
        lastDate: DateTime(2050),
      ).then(
        (DateTime? selected) {
          if (selected != null && selected != _selectedDate) {
            setState(() => _selectedDate = selected);
          }
        },
      );
  Future<void> _pickImage(Profile profile, ProfileCubit profileCubit) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (pickedFile != null) {
      setState(() {
        _ktpPicture = File(pickedFile.path);
      });
    }
    profileCubit.updateProfile(profile, imageFile: _ktpPicture);
  }

  void setSelectedGender(String? value) => setState(() {
        _selectedGender = value;
      });
  void setSelectedEducation(String? value) => setState(() {
        _selectedEducation = value;
      });
  void setSelectedStatus(String? value) => setState(() {
        _selectedStatus = value;
      });

  void setSelectedProvince(String? value) => setState(() {
        _selectedProvice = value;
      });
  void setSelectedCity(String? value) => setState(() {
        _selectedCity = value;
      });

  void setSelectedSubDisctrict(String? value) => setState(() {
        _selectedSubDisctrict = value;
      });
  void setSelectedWard(String? value) => setState(() {
        _selectedWard = value;
      });
  void setSelectedPosition(String? value) => setState(() {
        _selectedPosition = value;
      });
  void setSelectedHowLongHasWork(String? value) => setState(() {
        _selectedHowLongHasWork = value;
      });
  void setSelectedIncomeSource(String? value) => setState(() {
        _selectedIncomeSource = value;
      });
  void setSelectedGrossIncome(String? value) => setState(() {
        _selectedGrossIncome = value;
      });
  void setSelectedBankName(String? value) => setState(() {
        _selectedBankName = value;
      });

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Informasi Pribadi',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
              color: Colors.black,
            )),
        elevation: 0,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) async {
          if (state is ProfileLoaded) {
            Profile profile = state.profiles.firstWhere(
              (element) => element.id == ID_PROFILE,
            );
            setInitialValueTextField(profile.name, controllerFullName);
            setInitialValueTextField(profile.email, controllerEmail);
            setInitialValueTextField(
              profile.phoneNumber,
              controllerPhoneNumber,
            );
            setInitialValueTextField(
              profile.nik,
              controllerNik,
            );
            setInitialValueTextField(
              profile.address,
              controllerAddress,
            );
            setInitialValueTextField(
              profile.postalCode,
              controllerPostalCode,
            );
            _selectedDate = profile.birthDate;
            _selectedGender = profile.gender;
            _selectedEducation = profile.education;
            _selectedStatus = profile.status;
            _selectedProvice = profile.province;
            _selectedCity = profile.city;
            _selectedSubDisctrict = profile.subDistrict;
            _selectedWard = profile.ward;
            if (profile.profilePicture != null) {
              _ktpPicture = await uint8ListToFile(
                profile.profilePicture!,
                'ktp${getRandomInt()}.jpg',
              );
            }
            setInitialValueTextField(
              profile.company,
              controllerCompanyName,
            );
            setInitialValueTextField(
              profile.companyAddress,
              controllerCompanyAddress,
            );
            setInitialValueTextField(
              profile.bankBranch,
              controllerBankBranch,
            );
            setInitialValueTextField(
              profile.bankAccountOwnerName,
              controllerBankAccountOwnerName,
            );
            setInitialValueTextField(
              profile.bankNumber,
              controllerBankAccountNumber,
            );
            _selectedPosition = profile.position;
            _selectedHowLongHasWork = profile.lengthOfWork;
            _selectedIncomeSource = profile.sourceIncome;
            _selectedGrossIncome = profile.grossIncomePerYear;
            _selectedBankName = profile.bankName;
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            var profile = state.profiles.firstWhere(
              (element) => element.id == ID_PROFILE,
            );
            return Theme(
              data: ThemeData(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: primaryColor,
                    ),
                canvasColor: Colors.white,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Stepper(
                margin: EdgeInsets.zero,
                controlsBuilder: (context, controller) {
                  return const SizedBox.shrink();
                },
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepTapped: (stepIndex) =>
                    setState(() => currentStep = stepIndex),
                elevation: 0,
                steps: <Step>[
                  // * STEP 1
                  firstStep(context, profile, profileCubit),
                  // * STEP 2
                  secondStep(profile, profileCubit),
                  // * STEP 3
                  thridStep(profile, profileCubit, context),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No profiles'));
        },
      ),
    );
  }

  Step thridStep(
      Profile profile, ProfileCubit profileCubit, BuildContext context) {
    return Step(
      isActive: currentStep >= 2,
      title: const SizedBox(),
      content: Column(
        children: [
          LabelWidget(
            label: 'Nama Usaha / perusahaan',
            widget: GlobalTextformfield(
              controller: controllerCompanyName,
              hint: 'Isi nama perusahaan / Usaha',
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Alamat Usaha / perusahaan',
            widget: GlobalTextformfield(
              controller: controllerCompanyAddress,
              hint: 'Isi Alamat Usaha / perusahaan',
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Jabatan',
            widget: GlobalDropdown(
              options: _positions,
              selectedValue: _selectedPosition,
              onChanged: (position) {
                setSelectedPosition(position);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Lama Bekerja',
            widget: GlobalDropdown(
              options: _lengthWork,
              selectedValue: _selectedHowLongHasWork,
              onChanged: (work) {
                setSelectedHowLongHasWork(work);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Sumber pendapatan',
            widget: GlobalDropdown(
              options: _incomeSource,
              selectedValue: _selectedIncomeSource,
              onChanged: (income) {
                setSelectedIncomeSource(income);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Pendapatan kotor pertahun',
            widget: GlobalDropdown(
              options: _grossIncome,
              selectedValue: _selectedGrossIncome,
              onChanged: (income) {
                setSelectedGrossIncome(income);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Nama bank',
            widget: GlobalDropdown(
              options: _bankNames,
              selectedValue: _selectedBankName,
              onChanged: (bankName) {
                setSelectedBankName(bankName);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Cabang Bank',
            widget: GlobalTextformfield(
              controller: controllerBankBranch,
              hint: 'Isi Cabang Bank',
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Nomor Rekening',
            widget: GlobalTextformfield(
              controller: controllerBankAccountNumber,
              hint: 'Isi Nomor Rekening',
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Nama pemilik rekening',
            widget: GlobalTextformfield(
              controller: controllerBankAccountOwnerName,
              hint: 'Isi Nama Pemilik rekening',
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      profile.company = controllerCompanyName.text;
                      profile.companyAddress = controllerCompanyAddress.text;
                      profile.bankBranch = controllerBankBranch.text;
                      profile.bankAccountOwnerName =
                          controllerBankAccountOwnerName.text;
                      profile.bankNumber = controllerBankAccountNumber.text;
                      controllerBankAccountOwnerName.text;
                      profile.position = _selectedPosition;
                      profile.lengthOfWork = _selectedHowLongHasWork;
                      profile.sourceIncome = _selectedIncomeSource;
                      profile.grossIncomePerYear = _selectedGrossIncome;
                      profile.bankName = _selectedBankName;
                      profileCubit.updateProfile(profile);
                      setIndex(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: primaryColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Sebelumnya',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      profile.company = controllerCompanyName.text;
                      profile.companyAddress = controllerCompanyAddress.text;
                      profile.bankBranch = controllerBankBranch.text;
                      profile.bankAccountOwnerName =
                          controllerBankAccountOwnerName.text;
                      profile.bankNumber = controllerBankAccountNumber.text;
                      controllerBankAccountOwnerName.text;
                      profile.position = _selectedPosition;
                      profile.lengthOfWork = _selectedHowLongHasWork;
                      profile.sourceIncome = _selectedIncomeSource;
                      profile.grossIncomePerYear = _selectedGrossIncome;
                      profile.bankName = _selectedBankName;
                      profileCubit.updateProfile(profile);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      label: const Text(
        'Informasi',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Step secondStep(Profile profile, ProfileCubit profileCubit) {
    return Step(
      isActive: currentStep >= 1,
      title: const SizedBox(),
      content: Column(
        children: [
          InkWell(
            onTap: () => _pickImage(profile, profileCubit),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12.0),
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.camera_front_rounded,
                    color: primaryColor,
                    size: 40,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Upload KTP'),
                    Visibility(
                      visible: _ktpPicture != null,
                      child: Text(
                        '${getFileName(_ktpPicture?.path ?? '')}.${getFileExtension(_ktpPicture?.path ?? '')}',
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Visibility(
                  visible: _ktpPicture != null,
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'NIK',
            widget: GlobalTextformfield(
              controller: controllerNik,
              hint: 'Isi NIK',
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Alamat Sesuai KTP',
            widget: GlobalTextformfield(
              controller: controllerAddress,
              hint: 'Isi Alamat',
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Provinsi',
            widget: GlobalDropdown(
              options: _provinces,
              selectedValue: _selectedProvice,
              onChanged: (province) {
                setSelectedProvince(province);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Kota/Kabupaten',
            widget: GlobalDropdown(
              options: _cities,
              selectedValue: _selectedCity,
              onChanged: (city) {
                setSelectedCity(city);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Kecamatan',
            widget: GlobalDropdown(
              options: _subDisctircts,
              selectedValue: _selectedSubDisctrict,
              onChanged: (subDistrict) {
                setSelectedSubDisctrict(subDistrict);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Kelurahan',
            widget: GlobalDropdown(
              options: _wards,
              selectedValue: _selectedWard,
              onChanged: (ward) {
                setSelectedWard(ward);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Kode POS',
            widget: GlobalTextformfield(
              controller: controllerPostalCode,
              hint: 'Isi dengan Kode Pos',
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      profile.nik = controllerNik.text;
                      profile.address = controllerAddress.text;
                      profile.province = _selectedProvice;
                      profile.city = _selectedCity;
                      profile.subDistrict = _selectedSubDisctrict;
                      profile.ward = _selectedWard;
                      profile.postalCode = controllerPostalCode.text;
                      profileCubit.updateProfile(
                        profile,
                        imageFile: _ktpPicture,
                      );
                      setIndex(0);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: primaryColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Sebelumnya',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      profile.nik = controllerNik.text;
                      profile.address = controllerAddress.text;
                      profile.province = _selectedProvice;
                      profile.city = _selectedCity;
                      profile.subDistrict = _selectedSubDisctrict;
                      profile.ward = _selectedWard;
                      profile.postalCode = controllerPostalCode.text;
                      profileCubit.updateProfile(
                        profile,
                        imageFile: _ktpPicture,
                      );
                      setIndex(2);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Selanjutnya',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      label: const Text(
        'Alamat Pribadi',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Step firstStep(
    BuildContext context,
    Profile profile,
    ProfileCubit profileCubit,
  ) {
    return Step(
      isActive: currentStep >= 0,
      title: const SizedBox(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LabelWidget(
            label: 'Nama Lengkap',
            widget: GlobalTextformfield(
              controller: controllerFullName,
              hint: 'Isi dengan nama lengkap',
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Tanggal Lahir',
            widget: InkWell(
              onTap: () {
                selectDate(context);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                child: Text(
                  _selectedDate != null
                      ? DateFormat('dd MMMM yyyy')
                          .format(_selectedDate ?? DateTime.now())
                      : 'Pilih',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Jenis Kelamin',
            widget: GlobalDropdown(
              options: _genders,
              selectedValue: _selectedGender,
              onChanged: (selectedGender) {
                setSelectedGender(selectedGender);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Alamat Email',
            widget: GlobalTextformfield(
              controller: controllerEmail,
              hint: 'Isi dengan email',
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'No HP',
            widget: GlobalTextformfield(
              controller: controllerPhoneNumber,
              hint: 'Isi dengan No HP',
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Pendidikan',
            widget: GlobalDropdown(
              options: _educations,
              selectedValue: _selectedEducation,
              onChanged: (education) {
                setSelectedEducation(education);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          LabelWidget(
            label: 'Status Pernikahan',
            widget: GlobalDropdown(
              options: _statusMarried,
              selectedValue: _selectedStatus,
              onChanged: (status) {
                setSelectedStatus(status);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                profile.email = controllerEmail.text;
                profile.name = controllerFullName.text;
                profile.birthDate = _selectedDate;
                profile.gender = _selectedGender;
                profile.phoneNumber = controllerPhoneNumber.text;
                profile.education = _selectedEducation;
                profile.status = _selectedStatus;
                await profileCubit.updateProfile(
                  profile,
                );
                setIndex(1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Selanjutnya',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      label: const Text(
        'Biodata Diri',
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}

class LabelWidget extends StatelessWidget {
  const LabelWidget({super.key, required this.label, required this.widget});
  final String label;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(label), const SizedBox(height: 8.0), widget],
    );
  }
}
