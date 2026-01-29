import 'package:flutter/material.dart';

abstract class Translations {
  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations)!;
  }

  // App Title
  String get appTitle;
  String get findYourPerfectMatch;

  // Common Buttons
  String get login;
  String get signUp;
  String get continueText;
  String get next;
  String get skip;
  String get send;
  String get back;

  // Auth Screen
  String get welcomeBack;
  String get welcomeToSoulMatch;
  String get pleaseEnterYourPhoneNumber;
  String get verifyYourPhoneNumber;
  String get enterVerificationCode;
  String get resendCode;
  String get alreadyHaveAccount;
  String get dontHaveAccount;
  String get phoneNumber;
  String get verificationCode;
  String get invalidPhoneNumber;
  String get invalidVerificationCode;
  String get continueWithGoogle;
  String get continueWithApple;
  String get usePhoneNumber;
  String get termsAndConditions;

  // Main Tabs
  String get match;
  String get explore;
  String get chat;
  String get profile;

  // Profile Screen
  String get editInfo;
  String get addMedia;
  String get soulMatchPremium;
  String get seeWhoLikesYou;
  String get upgrade;
  String get language;
  String get notifications;
  String get privacySecurity;
  String get faceVerified;
  String get helpSupport;
  
  // Edit Profile Screen
  String get editProfile;
  String get bio;
  String get tellUsAboutYourself;
  String get pleaseEnterBio;
  String get yourJobTitle;
  String get yourEducation;
  String get whatAreYouLookingFor;
  String get questionPrompts;
  String get favoriteFood;
  String get favoriteTravelDestination;
  String get favoriteHobby;
  String get saveProfile;

  // Settings
  String get settings;
  String get languageSettings;
  String get selectLanguage;
  String get notificationsSettings;
  String get privacySettings;
  String get securitySettings;

  // End Drawer
  String get matches;
  String get discover;
  String get messages;
  String get singlesEvents;
  String get subscriptionPlans;
  String get verificationSecurity;
  String get help;

  // Explore Screen
  String get discoverPeople;
  String get filter;
  String get distance;
  String get ageRange;
  String get sortBy;
  String get onlineNow;
  String get verifiedOnly;
  String get hobbies;
  String get datingPreference;
  String get height;
  String get gender;
  String get education;
  String get work;
  String get cm;
  String get reset;
  String get applyFilters;
  String get searchHint;
  String get viewAll;
  String get hiking;
  String get travel;
  String get coffee;
  String get fitness;
  String get art;
  String get music;
  String get dogs;
  String get photography;
  String get serious;
  String get casual;
  String get bff;
  String get male;
  String get female;
  String get nonBinary;
  String get highSchool;
  String get bachelors;
  String get masters;
  String get phd;
  String get technology;
  String get healthcare;
  String get media;
  String get retail;
  String get engineering;

  // Chat Screen
  String get messagesTab;
  String get unreadMessages;
  String get noMessagesYet;
  String get startChatting;
  String get newMatches;

  // Match Screen
  String get matchWith;
  String get itsAMatch;
  String get sendMessage;
  String get keepSwiping;

  // Events Screen
  String get events;
  String get upcomingEvents;
  String get eventDetails;
  String get date;
  String get time;
  String get location;
  String get participants;
  String get joinEvent;

  // Subscription Screen
  String get upgradeToPremium;
  String get getUnlimitedMatches;
  String get premiumFeatures;
  String get unlimitedSwipesAndMatches;
  String get advancedSearchFilters;
  String get seeWhoLikedYou;
  String get sendUnlimitedMessages;
  String get profileBoost;
  String get smartMatchesAlgorithm;
  String get verifiedProfilesOnly;
  String get noAds;
  String get subscribe;
  String get notNow;
  String get success;
  String get youAreNowSubscribed;
  String get error;
  String get subscriptionFailed;
  String get ok;
  String get unlimitedLikes;
  String get seeWhoLikesFeature;
  String get boostYourProfile;
  String get rewindMatches;
  String get incognitoMode;
  String get readReceipts;
  String get monthly;
  String get quarterly;
  String get yearly;
  String get bestValue;
  String get upgradeToUnlockMore;
  String get free;
  String get plus;
  String get premium;
  String get unlimitedSwipes;
  String get basicFilters;
  String get secureMessaging;
  String get advancedFilters;
  String get oneBoostPerMonth;
  String get unlimitedBoosts;
  String get prioritySupport;
  String get choosePlan;

  // Verification & Security
  String get safetyFirst;
  String get safetyDescription;
  String get faceVerification;
  String get faceVerificationDescription;
  String get phoneVerification;
  String get phoneVerificationDescription;
  String get aiScamPrevention;
  String get aiScamPreventionDescription;
  String get privateProfile;
  String get privateProfileDescription;
  String get firebaseNote;
  String get pleasePositionYourFace;
  String get verifying;
  String get verificationFailed;
  String get verificationSuccess;
  String get verified;
  String get selectCountry;
  String get enterYourPhoneNumber;
  String get sendVerificationCode;
}
