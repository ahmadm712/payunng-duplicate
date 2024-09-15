import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payuung_pribadi_duplicate/data/models/profile_model.dart';
import 'package:payuung_pribadi_duplicate/helpers/database_helper.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  ProfileCubit() : super(ProfileInitial());

  Future<void> init() async {
    emit(ProfileLoading());
    try {
      final profiles = await _databaseHelper.getProfiles();
      if (profiles.isEmpty) {
        await _databaseHelper.insertInitProfile();
      }
      loadProfiles();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> loadProfiles() async {
    emit(ProfileLoading());
    try {
      final profiles = await _databaseHelper.getProfiles();
      emit(ProfileLoaded(profiles));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> addProfile(Profile profile, File? imageFile) async {
    try {
      await _databaseHelper.insertProfile(profile, imageFile);
      loadProfiles();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile(Profile profile, {File? imageFile}) async {
    try {
      await _databaseHelper.updateProfile(profile, imageFile);
      loadProfiles();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> deleteProfile(int id) async {
    emit(ProfileLoading());
    try {
      await _databaseHelper.deleteProfile(id);
      loadProfiles();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<Profile> profiles;

  const ProfileLoaded(this.profiles);

  @override
  List<Object> get props => [profiles];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
