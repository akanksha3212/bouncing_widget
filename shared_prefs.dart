// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:consumer_flutter_app/logger.dart';
import 'package:consumer_flutter_app/screens/catalog_screen/controller/inventory_controller.dart';
import 'package:consumer_flutter_app/screens/map_screen/model/LocationDetailsResponse.dart';
import 'package:consumer_flutter_app/screens/map_screen/model/current_address_model.dart';
import 'package:consumer_flutter_app/screens/sign_in_screen/model/login_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/address_listing_screen/model/receive_consumer_addresses_list.dart';

class SharedPref {
  static const String ACCESS_TOKEN = 'ACCESS_TOKEN';
  static const String COUNT_SLIDE_TO_PICK = 'Slide_To_Pick';
  static const String COUNT_DOWN_ARROW = 'count_down_arrow';
  static const String REFRESH_TOKEN = 'REFRESH_TOKEN';
  static const String CLIENT_ID = 'CLIENT_ID';
  static const String CLIENT_SECRET = 'CLIENT_SECRET';
  static const String ADDRESS = 'address_cart';
  static const String CURRENT_USER = 'CURRENT_USER';
  static const String LOCATION_DETAILS = 'LOCATION_DETAILS';
  static const String PLACE_ID = 'PLACE_ID';
  static const String baseUrl = 'base_url';
  static const String storyBaseUrl = 'story_base_url';
  static const String ADDRESS_DETAIL = 'ADDRESS_DETAIL';
  static const String CURRENT_ADDRESS_DETAIL = 'CURRENT_ADDRESS_DETAIL_1';
  static const String EDIT_ADDRESS_DETAIL = 'EDIT_ADDRESS_DETAIL';
  static const String CALL_TO_ORDER_NUMBER = 'CALL_TO_ORDER_NUMBER';
  static const String WHATSAPP_NUMBER = 'WHATSAPP_NUMBER';
  static const String HELP_NUMBER = 'HELP_NUMBER';
  static const String SORTING_DATA = 'SORTING_DATA';
  static const String TERMS_AND_CONDITION = 'Terms_and_Conditions';
  static const String PRIVACY_POLICY = 'Privacy_Policy';
  static const String GREETING = 'Greeting';

  static const String orderId = 'order_id';

  static Future<SharedPreferences> _getPref() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setTokens(String accessToken, String refreshToken) async {
    final pref = await _getPref();
    await pref.setString(ACCESS_TOKEN, accessToken);
    await pref.setString(REFRESH_TOKEN, refreshToken);
  }

  static Future<void> setCurrentOrderId(String OrderId) async {
    final pref = await _getPref();
    await pref.setString(orderId, OrderId);
  }

  static Future<void> setCountSlideToPick(int count) async {
    final pref = await _getPref();
    await pref.setInt(COUNT_SLIDE_TO_PICK, count);
  }

  static Future<void> clearTokens() async {
    final pref = await _getPref();
    await pref.remove(ACCESS_TOKEN);
    await pref.remove(REFRESH_TOKEN);
  }

  static Future<void> clearAddressForCart() async {
    final pref = await _getPref();
    await pref.remove(ADDRESS);
  }

  static Future<void> clearSharedPref() async {
    final pref = await _getPref();
    await pref.clear();
  }

  static Future<String?> getAccessToken() async {
    final pref = await _getPref();
    return pref.getString(ACCESS_TOKEN);
  }

  static Future<String?> getRefreshToken() async {
    final pref = await _getPref();
    return pref.getString(REFRESH_TOKEN);
  }

  static Future<String?> getBaseUrl() async {
    final pref = await _getPref();
    return pref.getString(baseUrl);
  }

  static Future<String?> getStoryUrl() async {
    final pref = await _getPref();
    return pref.getString(storyBaseUrl);
  }

  static Future<String?> getTermsAndConditionUrl() async {
    final pref = await _getPref();
    return pref.getString(TERMS_AND_CONDITION);
  }

  static Future<String?> getPrivacyPolicyUrl() async {
    final pref = await _getPref();
    return pref.getString(PRIVACY_POLICY);
  }

  static Future<String?> getCallToOrderNumber() async {
    final pref = await _getPref();
    return pref.getString(CALL_TO_ORDER_NUMBER)!;
  }

  static Future<String?> getWhatsAppNumber() async {
    final pref = await _getPref();
    return pref.getString(WHATSAPP_NUMBER);
  }

  static Future<String?> getHelpNumber() async {
    final pref = await _getPref();
    return pref.getString(HELP_NUMBER);
  }

  static Future<String?> getCurrentOrderId() async {
    final pref = await _getPref();
    return pref.getString(orderId);
  }

  static Future<int?> getCountSlideToPick() async {
    final pref = await _getPref();
    return pref.getInt(COUNT_SLIDE_TO_PICK);
  }

  static Future<void> setCountDownArrow(int count) async {
    final pref = await _getPref();
    await pref.setInt(COUNT_DOWN_ARROW, count);
  }

  static Future<int?> getCountDownArrow() async {
    final pref = await _getPref();
    return pref.getInt(COUNT_DOWN_ARROW);
  }

  static Future<void> setCurrentUser(User user) async {
    final pref = await _getPref();
    await pref.setString(CURRENT_USER, json.encode(user));
  }

  static Future<void> setAddress(
      ReceiveConsumerAddress receiveConsumerAddress) async {
    final pref = await _getPref();
    await pref.setString(
      ADDRESS_DETAIL,
      jsonEncode(receiveConsumerAddress),
    );
  }

  static Future<void> setGreeting(String greeting) async {
    final pref = await _getPref();
    await pref.setString(GREETING, greeting);
  }

  static Future<String> getGreeting() async {
    final pref = await _getPref();
    return pref.getString(GREETING) ?? "Hi";
  }

  static Future<ReceiveConsumerAddress?> getAddress() async {
    final pref = await _getPref();
    String address = pref.getString(ADDRESS_DETAIL) ?? "";
    if (address.isEmpty) {
      return null;
    }
    return receiveConsumerAddressFromJson(address);
  }

  static Future<void> setAddressForCart(
      ReceiveConsumerAddress receiveConsumerAddress) async {
    final pref = await _getPref();
    await pref.setString(
      ADDRESS,
      jsonEncode(receiveConsumerAddress),
    );
  }

  static Future<ReceiveConsumerAddress?> getAddressForCart() async {
    final pref = await _getPref();
    String address = pref.getString(ADDRESS) ?? "";
    if (address.isEmpty) {
      return null;
    }
    return receiveConsumerAddressFromJson(address);
  }

  static Future<void> setCurrentAddress(
      CurrentAddressModel currentAddressModel) async {
    // currentAddressModel.latitude = 28.4459228;
    // currentAddressModel.longitude = 77.0469134;
    final pref = await _getPref();
    await pref.setString(
        CURRENT_ADDRESS_DETAIL, currentAddressModelToJson(currentAddressModel));
    InventoryController inventoryController = Get.find();
    inventoryController.getInventory();
  }

  static Future<CurrentAddressModel?> getCurrentAddress() async {
    final pref = await _getPref();
    final addressString = pref.getString(CURRENT_ADDRESS_DETAIL);
    // if (addressString == null || addressString.isEmpty) {
    //   CurrentAddressModel currentAddressModel = CurrentAddressModel();
    //   currentAddressModel.latitude = 28.4459228;
    //   currentAddressModel.longitude = 77.0469134;
    //   currentAddressModel.placeName = "SET PLACE";
    //   return currentAddressModel;
    // }
    if (addressString != null && addressString.isNotEmpty) {
      CurrentAddressModel currentAddressModel =
          currentAddressModelFromJson(addressString);
      return currentAddressModel;
    }
    // currentAddressModel.latitude = 28.4459228;
    // currentAddressModel.longitude = 77.0469134;
    return CurrentAddressModel();
  }

  static Future<void> setEditAddress(
      ReceiveConsumerAddress receiveConsumerAddress) async {
    final pref = await _getPref();
    await pref.setString(EDIT_ADDRESS_DETAIL,
        receiveConsumerAddressToJson(receiveConsumerAddress));
  }

  static Future<ReceiveConsumerAddress?> getEditAddress() async {
    final pref = await _getPref();
    final addressString = pref.getString(EDIT_ADDRESS_DETAIL);
    if (addressString == null || addressString.isEmpty) {
      return null;
    }
    return receiveConsumerAddressFromJson(addressString);
  }

  static Future<void> setPlaceId(
      LocationDetailsResponse locationDetailsResponse) async {
    final pref = await _getPref();
    await pref.setString(
      PLACE_ID,
      jsonEncode(locationDetailsResponse),
    );
  }

  static Future<LocationDetailsResponse?> getPlaceID() async {
    final pref = await _getPref();
    // pref.getString(PLACE_ID);
    return LocationDetailsResponse.fromJson(
        await json.decode(pref.getString(PLACE_ID)!));
  }

  static Future<void> setLocationDetail(
      LocationDetailsResponse locationDetailsResponse) async {
    logger.d(" ===========  :   $locationDetailsResponse");
    final pref = await _getPref();
    await pref.setString(
      LOCATION_DETAILS,
      jsonEncode(locationDetailsResponse),
    );
  }

  static Future<LocationDetailsResponse?> getLocationDetail() async {
    final pref = await _getPref();
    pref.getString(LOCATION_DETAILS);
    return LocationDetailsResponse.fromJson(
        await json.decode(pref.getString(LOCATION_DETAILS)!));
  }

  static Future<User?> getCurrentUser() async {
    final pref = await _getPref();
    if (pref.getString(CURRENT_USER) == null ||
        !pref.containsKey(CURRENT_USER)) {
      return null;
    }
    return User.fromJson(await json.decode(pref.getString(CURRENT_USER)!));
  }

  static Future<String?> getStringWithKey(String key) async {
    final pref = await _getPref();
    return pref.getString(key);
  }

  static Future<void> setStringWithKey(String key, String value) async {
    final pref = await _getPref();
    await pref.setString(key, value);
  }
}
