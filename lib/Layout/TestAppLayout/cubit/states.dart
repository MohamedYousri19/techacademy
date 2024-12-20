abstract class TestStates {}

class TestInitialState extends TestStates {}

class TestChangeBottomNav extends TestStates {}

class SocialGetUserLoadingState extends TestStates {}

class SocialGetUserSuccessState extends TestStates {}

class SocialGetUserErrorState extends TestStates {
  final String error ;
  SocialGetUserErrorState(this.error);
}
//
class GetArabicLoadingState extends TestStates {}

class GetArabicSuccessState extends TestStates {}

class GetArabicErrorState extends TestStates {}
//
class GetScienceLoadingState extends TestStates {}

class GetScienceSuccessState extends TestStates {}

class GetScienceErrorState extends TestStates {}
//
class GetArabicLessonsLoadingState extends TestStates {}

class GetArabicLessonsSuccessState extends TestStates {}

class GetArabicLessonsErrorState extends TestStates {}
//
class GetScienceLessonsLoadingState extends TestStates {}

class GetScienceLessonsSuccessState extends TestStates {}

class GetScienceLessonsErrorState extends TestStates {}
//

class GetArabicExamLoadingState extends TestStates {}

class GetArabicExamSuccessState extends TestStates {}

class GetArabicExamErrorState extends TestStates {}
//

class GetScienceExamLoadingState extends TestStates {}

class GetScienceExamSuccessState extends TestStates {}

class GetScienceExamErrorState extends TestStates {}
//

class GetResultLoadingState extends TestStates {}

class GetResultSuccessState extends TestStates {}

class GetResultErrorState extends TestStates {}

class SocialPickedImageSuccessState extends TestStates {}

class SocialPickedImageErrorState extends TestStates {}

class SocialPickedImageCoverSuccessState extends TestStates {}

class SocialPickedImageCoverErrorState extends TestStates {}

class SocialUploadProfileImageLoadingState extends TestStates {}

class SocialUploadProfileImageErrorState extends TestStates {}

class SocialUploadProfileImageSuccessState extends TestStates {}

class SocialUploadImageCoverLoadingState extends TestStates {}

class SocialUploadImageCoverSuccessState extends TestStates {}

class SocialUploadImageCoverErrorState extends TestStates {}

class SocialUpdateDataLoadingState extends TestStates {}

class SocialUpdateDataErrorState extends TestStates {}

class ChangeListIndex extends TestStates {}

