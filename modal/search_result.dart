import 'dart:async';
import 'dart:convert';
import 'package:FreightBro/api/api_client.dart';
import 'package:FreightBro/src/models/cargo_types.dart';
import 'package:FreightBro/src/models/quantity.dart';
import 'package:FreightBro/src/models/schedule.dart';
import 'package:FreightBro/src/models/search_param.dart';
import 'package:async/async.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResult {
  @JsonKey(name: "result_data")
  ResultData resultData;

  @JsonKey(name: "result_meta")
  ResultMeta resultMeta;

  @JsonKey(name: "_id")
  String searchId;

  SearchResult(this.resultData, this.resultMeta, this.searchId);

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}

@JsonSerializable()
class ResultMeta {
  @JsonKey(name: 'search_param')
  SearchParam searchParam;

  @JsonKey(name: 'currency_conversion_rates')
  List<CurrencyConversionRate> currencyConversionRates;

  ResultMeta(this.searchParam, this.currencyConversionRates);

  factory ResultMeta.fromJson(Map<String, dynamic> json) =>
      _$ResultMetaFromJson(json);
  Map<String, dynamic> toJson() => _$ResultMetaToJson(this);
}

@JsonSerializable()
class LtlLoadDetails {
  LtlDetails origin;

  LtlDetails destination;

  LtlLoadDetails({this.origin, this.destination});

  factory LtlLoadDetails.fromJson(Map<String, dynamic> json) =>
      _$LtlLoadDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$LtlLoadDetailsToJson(this);
}

@JsonSerializable()
class LtlDetails {
  @JsonKey(name: 'dimensional_weight')
  num dimensionalWeight;

  @JsonKey(name: 'dimensional_unit')
  String dimensionalUnit;

  @JsonKey(name: 'chargeable_weight')
  num chargeableWeight;

  @JsonKey(name: 'chargeable_unit')
  String chargeableUnit;

  @JsonKey(name: 'dimensional_factor')
  num dimensionalFactor;

  @JsonKey(name: 'gross_weight')
  num grossWeight;

  @JsonKey(name: 'gross_weight_unit')
  String grossWeightUnit;

  @JsonKey(name: 'port_code')
  String portCode;

  LtlDetails(
      {this.chargeableUnit,
        this.chargeableWeight,
        this.dimensionalFactor,
        this.dimensionalUnit,
        this.dimensionalWeight,
        this.grossWeight,
        this.grossWeightUnit,
        this.portCode});

  factory LtlDetails.fromJson(Map<String, dynamic> json) =>
      _$LtlDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$LtlDetailsToJson(this);
}

@JsonSerializable()
class ResultData {
  @JsonKey(name: "msr_rates")
  final GeneralRates msrRates;

  @JsonKey(name: "network_rates")
  final GeneralRates networkRates;

  @JsonKey(name: "iata_rates")
  final GeneralRates iataRates;

  @JsonKey(name: "nearby_port_rates")
  final NearByRates nearByRates;

  ResultData(
      this.msrRates, this.networkRates, this.iataRates, this.nearByRates);

  factory ResultData.fromJson(Map<String, dynamic> json) =>
      _$ResultDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}

@JsonSerializable()
class NearByRates {
  @JsonKey(name: "msr_rates")
  final List<GeneralRates> msrRates;

  @JsonKey(name: "network_rates")
  final List<GeneralRates> networkRates;

  @JsonKey(name: "msr_spot")
  final List<dynamic> msrSpotList;

  @JsonKey(name: "network_spot")
  final List<dynamic> networkSpotList;

  NearByRates(
      this.msrRates, this.networkRates, this.msrSpotList, this.networkSpotList);

  factory NearByRates.fromJson(Map<String, dynamic> json) =>
      _$NearByRatesFromJson(json);
  Map<String, dynamic> toJson() => _$NearByRatesToJson(this);
}

@JsonSerializable()
class GeneralRates {
  final RatesData data;
  final String url;

  @JsonKey(name: "spot")
  final List<dynamic> spotDataList;

  @JsonKey(name: 'currency_conversion_rates')
  List<CurrencyConversionRate> currencyConversionRates;

  String message;

  GeneralRates(this.data, this.url, this.currencyConversionRates,
      this.spotDataList, this.message);

  factory GeneralRates.fromJson(Map<String, dynamic> json) =>
      _$GeneralRatesFromJson(json);
  Map<String, dynamic> toJson() => _$GeneralRatesToJson(this);
}

@JsonSerializable()
class RatesData {
  final List<Rate> rates;
  final List<RateCard> cards;

  @JsonKey(name: '_id', nullable: true)
  String id;

  RatesData({this.cards, this.rates});

  factory RatesData.fromJson(Map<String, dynamic> json) =>
      _$RatesDataFromJson(json);
  Map<String, dynamic> toJson() => _$RatesDataToJson(this);
}

@JsonSerializable()
class RateCard {
  CardData data;

  CardMeta meta;

  @JsonKey(name: '_id', nullable: true)
  String id;

  @JsonKey(ignore: true)
  bool hasMissingLegs = false;

  @JsonKey(ignore: true)
  Rate _l3RateBuy;

  @JsonKey(ignore: true)
  Rate _l3RateSell;

  RateCard(this.data, this.meta, this.id);

  Rate getL3Rate({bool fromSell = false}) {
    if (fromSell) {
      if (_l3RateSell == null) {
        _l3RateSell = data.sellRates.values
            .firstWhere((CardLeg leg) => leg.legCode.contains("l3"))
            .rateObj;
      }
      return _l3RateSell;
    } else {
      if (_l3RateBuy == null) {
        _l3RateBuy = data.buyRates.values
            .firstWhere((CardLeg leg) => leg.legCode.contains("l3"))
            .rateObj;
      }
      return _l3RateBuy;
    }
  }

//
//    if(mode == null) return null;
//    if (mode.toLowerCase().contains('fcl')){
//      return data.buyRates['l3_fcl']?.rateObj;
//    }
//    else if (mode.toLowerCase().contains('lcl')){
//      return data.buyRates['l3_lcl']?.rateObj;
//    }
//    else if (mode.toLowerCase().contains('air')){
//      return data.buyRates['l3_air']?.rateObj;
//    }
//  }

  Rate getLegRate(String leg, String mode) {
    if (mode == null) return null;
    if (mode.toLowerCase().contains('fcl')) {
      return data.buyRates['${leg}_fcl']?.rateObj;
    } else if (mode.toLowerCase().contains('lcl')) {
      return data.buyRates['${leg}_lcl']?.rateObj;
    } else if (mode.toLowerCase().contains('air')) {
      return data.buyRates['${leg}_air']?.rateObj;
    }
  }

  factory RateCard.fromJson(Map<String, dynamic> json) =>
      _$RateCardFromJson(json);
  Map<String, dynamic> toJson() => _$RateCardToJson(this);
}

@JsonSerializable()
class CardMeta {
  @JsonKey(name: 'is_selected')
  bool isSelected;

  @JsonKey(name: 'selected_schedule')
  Schedule selectedSchedule;

  @JsonKey(name: 'card_total_cost')
  dynamic cardTotalCost;

  @JsonKey(name: 'remarks')
  String remarks;

  @JsonKey(name: 'vendor_id')
  dynamic vendorId;

  @JsonKey(name: 'port_data')
  PortData portData;

  String inclusions;

  String type;

  String via_pol;

  String via_pod;

  String haulage;
  String destination_haulage;

  bool haulage_available;

  @JsonKey(name: 'ltl_load_details')
  LtlLoadDetails ltlLoadDetails;

  @JsonKey(name: "make_rates_global", defaultValue: [])
  List<MakeRatesGlobal> makeRatesGlobal;

  bool get hasRemarks =>
      ((remarks ?? "") + (inclusions ?? "")).trim().isNotEmpty;

  @JsonKey(name: 'additional_charges')
  AdditionalChargesSearchResult additionalCharges;

  @JsonKey(name: 'pickup_transport_mode')
  String pickupTransportMode;

  @JsonKey(name: 'delivery_transport_mode')
  String deliveryTransportMode;

  @JsonKey(name: 'pickup_service')
  String pickupService;

  @JsonKey(name: 'delivery_service')
  String deliveryService;

  @JsonKey(name: 'pickup_sub_vendor')
  SubVendor pickupSubVendor;

  @JsonKey(name: 'delivery_sub_vendor')
  SubVendor deliverySubVendor;

  CardMeta(
      {
        this.isSelected,
        this.selectedSchedule,
        this.cardTotalCost,
        this.remarks = "",
        this.vendorId,
        this.portData,
        this.via_pol,
        this.via_pod,
        this.haulage,
        this.inclusions = "",
        this.haulage_available,
        this.destination_haulage,
        this.type,
        this.additionalCharges,
        this.ltlLoadDetails,
        this.makeRatesGlobal,
        this.pickupTransportMode,
        this.deliveryTransportMode,
        this.pickupService,
        this.deliveryService,
        this.pickupSubVendor,
        this.deliverySubVendor
      });

  factory CardMeta.fromJson(Map<String, dynamic> json) =>
      _$CardMetaFromJson(json);
  Map<String, dynamic> toJson() => _$CardMetaToJson(this);
}

@JsonSerializable()
class MakeRatesGlobal {
  @JsonKey(name: "batch_code")
  String batchCode;

  String error;

  @JsonKey(name: "leg_code")
  String legCode;

  MakeRatesGlobal(this.legCode, this.error, this.batchCode);

  factory MakeRatesGlobal.fromJson(Map<String, dynamic> json) =>
      _$MakeRatesGlobalFromJson(json);
  Map<String, dynamic> toJson() => _$MakeRatesGlobalToJson(this);
}

class PortData {
  PortData({
    this.originPortCode,
    this.originPortname,
    this.destinationPortCode,
    this.destinationPortname,
    this.pickupLocation,
    this.deliveryLocation,
    this.isIcdPortOrigin,
    this.isIcdPortDestination,
    this.originCity,
    this.destinationCity,
    this.originRegion,
    this.destinationRegion,
    this.originState,
    this.destinationState,
    this.pickupPincodeUi,
    this.deliveryPincodeUi,
    this.pickupCountryName,
    this.deliveryCountryName,
  });

  String originPortCode;
  String originPortname;
  String destinationPortCode;
  String destinationPortname;
  String pickupLocation;
  String deliveryLocation;
  int isIcdPortOrigin;
  int isIcdPortDestination;
  String originCity;
  String destinationCity;
  String originRegion;
  String destinationRegion;
  String originState;
  String destinationState;
  String pickupPincodeUi;
  String deliveryPincodeUi;
  String pickupCountryName;
  String deliveryCountryName;

  factory PortData.fromRawJson(String str) =>
      PortData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PortData.fromJson(Map<String, dynamic> json) => PortData(
    originPortCode:
    json["origin_port_code"] == null ? null : json["origin_port_code"],
    originPortname:
    json["origin_portname"] == null ? null : json["origin_portname"],
    destinationPortCode: json["destination_port_code"] == null
        ? null
        : json["destination_port_code"],
    destinationPortname: json["destination_portname"] == null
        ? null
        : json["destination_portname"],
    pickupLocation:
    json["pickup_location"] == null ? null : json["pickup_location"],
    deliveryLocation: json["delivery_location"] == null
        ? null
        : json["delivery_location"],
    isIcdPortOrigin: json["is_icd_port_origin"] == null
        ? null
        : json["is_icd_port_origin"],
    isIcdPortDestination: json["is_icd_port_destination"] == null
        ? null
        : json["is_icd_port_destination"],
    originCity: json["origin_city"] == null ? null : json["origin_city"],
    destinationCity:
    json["destination_city"] == null ? null : json["destination_city"],
    originRegion:
    json["origin_region"] == null ? null : json["origin_region"],
    destinationRegion: json["destination_region"] == null
        ? null
        : json["destination_region"],
    originState: json["origin_state"] == null ? null : json["origin_state"],
    destinationState: json["destination_state"] == null
        ? null
        : json["destination_state"],
    pickupPincodeUi: json["pickup_pincode_ui"] == null
        ? null
        : json["pickup_pincode_ui"],
    deliveryPincodeUi: json["delivery_pincode_ui"] == null
        ? null
        : json["delivery_pincode_ui"],
    pickupCountryName: json["pickup_country_name"] == null
        ? null
        : json["pickup_country_name"],
    deliveryCountryName: json["delivery_country_name"] == null
        ? null
        : json["delivery_country_name"],
  );

  Map<String, dynamic> toJson() => {
    "origin_port_code": originPortCode == null ? null : originPortCode,
    "origin_portname": originPortname == null ? null : originPortname,
    "destination_port_code":
    destinationPortCode == null ? null : destinationPortCode,
    "destination_portname":
    destinationPortname == null ? null : destinationPortname,
    "pickup_location": pickupLocation == null ? null : pickupLocation,
    "delivery_location": deliveryLocation == null ? null : deliveryLocation,
    "is_icd_port_origin": isIcdPortOrigin == null ? null : isIcdPortOrigin,
    "is_icd_port_destination":
    isIcdPortDestination == null ? null : isIcdPortDestination,
    "origin_city": originCity == null ? null : originCity,
    "destination_city": destinationCity == null ? null : destinationCity,
    "origin_region": originRegion == null ? null : originRegion,
    "destination_region":
    destinationRegion == null ? null : destinationRegion,
    "origin_state": originState == null ? null : originState,
    "destination_state": destinationState == null ? null : destinationState,
    "pickup_pincode_ui": pickupPincodeUi == null ? null : pickupPincodeUi,
    "delivery_pincode_ui":
    deliveryPincodeUi == null ? null : deliveryPincodeUi,
    "pickup_country_name":
    pickupCountryName == null ? null : pickupCountryName,
    "delivery_country_name":
    deliveryCountryName == null ? null : deliveryCountryName,
  };
}

@JsonSerializable()
class CardData {
  @JsonKey(name: "buy_rates")
  Map<String, CardLeg> buyRates;

  @JsonKey(name: "sell_rates")
  Map<String, CardLeg> sellRates;

  CardData(this.buyRates, Map<String, CardLeg> sellRates) {
    Map<String, CardLeg> temp = Map<String, CardLeg>();
    try {
      Iterable<String> keys = buyRates.keys;
      Iterable<CardLeg> values = buyRates.values;

      for (int i = 0; i < keys.length; i++) {
        CardLeg value = CardLeg.fromJson(((values.elementAt(i).toJson())));
        value.buyRateId = value.rateId;
        value.rateId = null;
        temp[keys.elementAt(i)] = value;
      }
    } catch (e, s) {
      // FlutterCrashlytics().logException(e, StackTrace.current);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
    this.sellRates = sellRates ?? temp;
  }

  num get cardTotalCost {
    num cardTotalCost = 0;
    for (CardLeg leg in sellRates.values) {
      cardTotalCost += leg.rateObj?.legTotalCost ?? 0;
    }
    return cardTotalCost;
  }

  factory CardData.fromJson(Map<String, dynamic> json) =>
      _$CardDataFromJson(json);
  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}

@JsonSerializable()
class Rate {
  @JsonKey(name: '_id')
  String id;

  Airline airline;

  @JsonKey(name: 'airline_code')
  String airlineCode;

  DateTime expiry;

  @JsonKey(name: 'start_date')
  DateTime startDate;

  @JsonKey(name: "leg_total_cost")
  num legTotalCost;

  @JsonKey(name: "leg_total_currency")
  String legTotalCurrency;

  @JsonKey(name: 'vendor_id')
  dynamic vendorId;

  @JsonKey(name: 'sub_vendor_id')
  dynamic subVendorId;

  Vendor vendor;

  @JsonKey(name: "sub_vendor")
  SubVendor subVendor;

  List<Charge> charges;

  @JsonKey(name: 'slab_charges')
  dynamic slabCharges;

  @JsonKey(name: 'leg_code')
  String legCode;

  @JsonKey(name: 'leg_currency')
  String legCurrency;

  @JsonKey(name: 'leg_currency_cost')
  num legCurrencyCost;

  @JsonKey(name: 'leg_name')
  String legName;

  @JsonKey(name: 'leg_description')
  String legDescription;

  @JsonKey(name: 'global_leg_id')
  String globalLegId;

  @JsonKey(name: 'schedule')
  RateSchedule rateSchedule;

  @JsonKey(name: 'service_type')
  String serviceType;

  @JsonKey(name: 'is_special', defaultValue: false)
  bool isSpecial;

  @JsonKey(name: "special_meta")
  List<SpecialMetaItem> specialMetaList;

  @JsonKey(name: "promotions")
  List<PromotionsItem> promotionsList;

  @JsonKey(name: 'batchcode')
  dynamic batchCode;

  @JsonKey(name: 'via_route')
  String viaRoute;

  String inclusions;

  String remarks;

  List<Tag> tags;

  String price_id;

  //TODO check this value
  dynamic slab;

  @JsonKey(name: "slab_currency")
  String slabCurrency;

  List<FreeDaysData> demurrage;

  List<FreeDaysData> detention;

  Map<String, dynamic> value_of_good;

  @JsonKey(name: "terms_and_condition")
  TermsAndCondition tnc;

  @JsonKey(name: "slab_rate")
  Map<String, dynamic> slabRate;

  @JsonKey(defaultValue: false)
  bool haulage_available = false;

  String origin_haulage;

  String destination_haulage;

  @JsonKey(name: "transit_time")
  String transitTime;

  @JsonKey(name: "agent")
  AgentData agentData;
  @JsonKey(name: "penalty_details")
  PenaltyDetails penaltyDetails;

  @JsonKey(name: "rollable_available", defaultValue: false)
  bool rollableAvailable;

  @JsonKey(name: "demurrage_details")
  FreeDaysDetails demurrageDetails;

  @JsonKey(name: "detention_details")
  FreeDaysDetails detentionDetails;

  @JsonKey(name: "destination_free_days")
  int destinationFreeDays;

  @JsonKey(name: "origin_free_days")
  int originFreeDays;

  @JsonKey(name: "ltl_load_details")
  LtlDetails ltlLoadDetails;

  @JsonKey(name: "via_pol")
  String viaPol;

  @JsonKey(name: "via_pod")
  String viaPod;

  @JsonKey(name: "agent_id")
  dynamic agentId;

  @JsonKey(name: "sv_combination")
  List<dynamic> svCombination;

  @JsonKey(name: "commodity")
  String commodity;

  @JsonKey(name: "commodity_data")
  List<String> commodityData;

  @JsonKey(name: "cargo_type")
  String cargoType;

  @JsonKey(name: "cargo_type_data")
  CargoType cargoTypeData;

  @JsonKey(name: "dim")
  dynamic dim;

  @JsonKey(name: "dim_data")
  dynamic dimData;

  @JsonKey(name:"origin_combined_free_days")
  int originCombinedFreeDays;

  @JsonKey(name:"destination_combined_free_days")
  int destinationCombinedFreeDays;

  //TODO:add this key once backend converts key values to int from string
  //@JsonKey(name:"slab_rate")
  //SlabRate slabRate;

  bool get isL3Rate =>
      (legCode != null) && legCode.toLowerCase().contains("l3");

  Rate({
    this.id,
    this.expiry,
    this.startDate,
    this.airline,
    this.legTotalCost = 0,
    this.legTotalCurrency,
    this.vendorId,
    this.subVendorId,
    this.legCode,
    this.legCurrency,
    this.legName,
    this.globalLegId,
    this.serviceType,
    this.subVendor,
    this.rateSchedule,
    this.vendor,
    this.charges,
    this.slabCharges,
    this.tags,
    this.isSpecial = false,
    this.specialMetaList,
    this.viaRoute,
    this.remarks,
    this.inclusions,
    this.legCurrencyCost = 0,
    this.slab,
    this.slabCurrency,
    this.price_id,
    this.demurrage,
    this.detention,
    this.tnc,
    this.value_of_good,
    this.promotionsList,
    this.slabRate,
    this.haulage_available,
    this.destination_haulage,
    this.origin_haulage,
    this.transitTime,
    this.agentData,
    this.penaltyDetails,
    this.rollableAvailable,
    this.demurrageDetails,
    this.detentionDetails,
    this.legDescription,
    this.destinationFreeDays,
    this.originFreeDays,
    this.ltlLoadDetails,
    this.viaPod,
    this.viaPol,
    this.agentId,
    this.svCombination,
    this.cargoTypeData,
    this.commodityData = const [],
    this.cargoType = 'FAK',
    this.commodity = '',
    this.dim,
    this.dimData,
    this.originCombinedFreeDays,
    this.destinationCombinedFreeDays,
    this.airlineCode
  });

  Rate getCopy() {
    Rate rate = Rate();
    rate.id = this.id;
    rate.airline = this.airline?.getCopy();
    rate.expiry = this.expiry;
    rate.startDate = this.startDate;
    rate.vendor = this.vendor;
    rate.subVendor = this.subVendor;
    rate.rateSchedule = this.rateSchedule;
    rate.legTotalCost = this.legTotalCost;
    rate.legTotalCurrency = this.legTotalCurrency;
    rate.legCurrency = this.legCurrency;
    rate.legCurrencyCost = this.legCurrencyCost;
    rate.vendorId = this.vendorId;
    rate.subVendorId = this.subVendorId;
    rate.charges = this.charges?.map((charge) => charge.getCopy())?.toList();
    rate.slabCharges = this.slabCharges;
    rate.legCode = this.legCode;
    rate.legName = this.legName;
    rate.globalLegId = this.globalLegId;
    rate.batchCode = this.batchCode;
    rate.tags = this.tags;
    rate.isSpecial = this.isSpecial;
    rate.specialMetaList = this.specialMetaList;
    rate.viaRoute = this.viaRoute;
    rate.remarks = this.remarks;
    rate.inclusions = this.inclusions;
    rate.slab = this.slab;
    rate.slabCurrency = this.slabCurrency;
    rate.serviceType = this.serviceType;
    rate.slabRate = this.slabRate;
    rate.price_id = this.price_id;
    rate.demurrage = this.demurrage;
    rate.detention = this.detention;
    rate.tnc = this.tnc;
    rate.promotionsList = this.promotionsList;
    rate.value_of_good = this.value_of_good;
    rate.haulage_available = this.haulage_available;
    rate.origin_haulage = this.origin_haulage;
    rate.destination_haulage = this.destination_haulage;
    rate.transitTime = this.transitTime;
    rate.legDescription = this.legDescription;
    rate.agentData = this.agentData;
    rate.penaltyDetails = this.penaltyDetails;
    rate.rollableAvailable = this.rollableAvailable;
    rate.detentionDetails = this.detentionDetails;
    rate.demurrageDetails = this.demurrageDetails;
    rate.destinationFreeDays = this.destinationFreeDays;
    rate.originFreeDays = this.originFreeDays;
    rate.ltlLoadDetails = this.ltlLoadDetails;
    rate.viaPol = this.viaPol;
    rate.viaPod = this.viaPod;
    rate.agentId = this.agentId;
    rate.svCombination = this.svCombination;
    rate.commodity = this.commodity;
    rate.commodityData = this.commodityData;
    rate.cargoType = this.cargoType;
    rate.cargoTypeData = this.cargoTypeData;
    rate.dim = this.dim;
    rate.dimData = this.dimData;
    rate.originCombinedFreeDays = this.originCombinedFreeDays;
    rate.destinationCombinedFreeDays = this.destinationCombinedFreeDays;
    rate.airlineCode = this.airlineCode;
    return rate;
  }

  void copyWith(Rate rate) {
    this.id = rate.id;
    this.expiry = rate.expiry;
    this.startDate = rate.startDate;
    this.subVendorId = rate.subVendorId;
    this.vendorId = this.vendorId;
    this.legTotalCost = rate.legTotalCost;
    this.legTotalCurrency = rate.legTotalCurrency;
    this.legCurrency = rate.legCurrency;
    this.legCurrencyCost = rate.legCurrencyCost;
    this.charges = rate.charges;
    this.legCode = rate.legCode;
    this.legName = rate.legName;
    this.isSpecial = rate.isSpecial;
    this.specialMetaList = rate.specialMetaList;
    this.globalLegId = rate.globalLegId;
    this.batchCode = rate.batchCode;
    this.remarks = rate.remarks;
    this.inclusions = rate.inclusions;
    this.promotionsList = rate.promotionsList;
    this.slabRate = rate.slabRate;
    this.slab = rate.slab;
    this.slabCurrency = rate.slabCurrency;
    this.value_of_good = rate.value_of_good;
    this.haulage_available = rate.haulage_available;
    this.origin_haulage = rate.origin_haulage;
    this.destination_haulage = rate.destination_haulage;
    this.transitTime = rate.transitTime;
    this.agentData = rate.agentData;
    this.legDescription = rate.legDescription;
    this.penaltyDetails = rate.penaltyDetails;
    this.rollableAvailable = rate.rollableAvailable;
    this.demurrageDetails = rate.demurrageDetails;
    this.detentionDetails = rate.detentionDetails;
    this.originFreeDays = rate?.originFreeDays;
    this.destinationFreeDays = rate?.destinationFreeDays;
    this.ltlLoadDetails = rate?.ltlLoadDetails;
    this.viaPol = rate?.viaPol;
    this.viaPod = rate?.viaPod;
    this.agentId = rate?.agentId;
    this.svCombination = rate?.svCombination;
    this.commodity = rate?.commodity;
    this.commodityData = rate?.commodityData;
    this.cargoType = rate?.cargoType;
    this.cargoTypeData = rate?.cargoTypeData;
    this.dim = rate?.dim;
    this.dimData = rate?.dimData;
    this.originCombinedFreeDays = rate?.originCombinedFreeDays;
    this.destinationCombinedFreeDays = rate?.destinationCombinedFreeDays;
    this.airlineCode = rate?.airlineCode;
  }

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
  Map<String, dynamic> toJson() => _$RateToJson(this);
}

@JsonSerializable()
class SlabCharge {
  SlabCharge({
    this.legName,
    this.chargeName,
    this.chargeCode,
    this.loadType,
    this.currency,
    this.slabBasis,
    this.slab,
  });

  @JsonKey(name: "leg_name")
  String legName;
  @JsonKey(name: "charge_name")
  String chargeName;
  @JsonKey(name: "charge_code")
  String chargeCode;
  @JsonKey(name: "load_type")
  String loadType;
  String currency;
  @JsonKey(name: "slab_basis")
  String slabBasis;
  List<Slab> slab;

  factory SlabCharge.fromJson(Map<String, dynamic> json) =>
      _$SlabChargeFromJson(json);
  Map<String, dynamic> toJson() => _$SlabChargeToJson(this);

  SlabCharge getCopy() {
    SlabCharge slabCharge = SlabCharge();
    slabCharge.legName = this.legName;
    slabCharge.chargeName = this.chargeName;
    slabCharge.chargeCode = this.chargeCode;
    slabCharge.loadType = this.loadType;
    slabCharge.currency = this.currency;
    slabCharge.slabBasis = this.slabBasis;
    slabCharge.slab = this.slab?.map((slab) => slab.getCopy())?.toList();
    return slabCharge;
  }
}

@JsonSerializable()
class AgentData {
  @JsonKey(name: "agent_name")
  String agentName;

  AgentData({this.agentName});

  factory AgentData.fromJson(Map<String, dynamic> json) =>
      _$AgentDataFromJson(json);
  Map<String, dynamic> toJson() => _$AgentDataToJson(this);
}

@JsonSerializable()
class FreeDaysDetails {
  List<FreeDaysData> origin;

  List<FreeDaysData> destination;

  FreeDaysDetails({this.origin, this.destination}) {
    try {
      if (origin != null || destination != null) {
        if (origin.isNotEmpty && origin.length > 1) {
          this.origin.sort((FreeDaysData first, FreeDaysData last) =>
              first.freeDays.compareTo(last.freeDays));
        }
        if (destination.isNotEmpty && destination.length > 1) {
          this.destination.sort((FreeDaysData first, FreeDaysData last) =>
              first.freeDays.compareTo(last.freeDays));
        }
      }
    } catch (e, s) {
      //FlutterCrashlytics().logException(e, StackTrace.current);
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  factory FreeDaysDetails.fromJson(Map<String, dynamic> json) =>
      _$FreeDaysDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$FreeDaysDetailsToJson(this);
}

@JsonSerializable()
class PenaltyDetails {
  @JsonKey(name: "penalty_message")
  String penaltyMessage;

  @JsonKey(name: "penalty_fees")
  List<PenaltyData> penaltyFees;

  PenaltyDetails({this.penaltyFees, this.penaltyMessage});

  factory PenaltyDetails.fromJson(Map<String, dynamic> json) =>
      _$PenaltyDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PenaltyDetailsToJson(this);
}

@JsonSerializable()
class PenaltyData {
  @JsonKey(name: "charge_type")
  String chargeType;

  @JsonKey(name: "charge_name")
  String chargeName;

  @JsonKey(name: "load_type")
  String loadType;

  @JsonKey(name: "charge_currency")
  String chargeCurrency;

  @JsonKey(name: "buy_rate")
  num buyRate;

  @JsonKey(name: "sell_rate")
  num sellRate;

  PenaltyData(
      {this.chargeName,
        this.buyRate,
        this.chargeCurrency,
        this.chargeType,
        this.loadType,
        this.sellRate});

  factory PenaltyData.fromJson(Map<String, dynamic> json) =>
      _$PenaltyDataFromJson(json);
  Map<String, dynamic> toJson() => _$PenaltyDataToJson(this);
}

//Common data model for Demurrage and Detention
@JsonSerializable()
class FreeDaysData {
  String container_type;

  int value;

  @JsonKey(name: "free_days")
  int freeDays;

  FreeDaysData({this.container_type, this.value, this.freeDays});

  factory FreeDaysData.fromJson(Map<String, dynamic> json) =>
      _$FreeDaysDataFromJson(json);
  Map<String, dynamic> toJson() => _$FreeDaysDataToJson(this);
}

@JsonSerializable()
class TermsAndCondition {
  String url;

  String data;

  @JsonKey(name: "terms_and_condition_url")
  String tandcURL;

  TermsAndCondition({this.url, this.data, this.tandcURL});

  factory TermsAndCondition.fromJson(Map<String, dynamic> json) =>
      _$TermsAndConditionFromJson(json);
  Map<String, dynamic> toJson() => _$TermsAndConditionToJson(this);
}

@JsonSerializable()
class TermsAndConditionData {
  String terms_and_condition_data;

  String vendor_id;

  String sv_vendor;

  TermsAndConditionData(
      {this.terms_and_condition_data, this.vendor_id, this.sv_vendor});

  factory TermsAndConditionData.fromJson(Map<String, dynamic> json) =>
      _$TermsAndConditionDataFromJson(json);
  Map<String, dynamic> toJson() => _$TermsAndConditionDataToJson(this);
}

@JsonSerializable()
class Airline {
  @JsonKey(name: "air_line_name")
  String airlineName;

  @JsonKey(name: 'airline_code', defaultValue: "")
  String airlineCode;

  @JsonKey(name: 'airline_prefix')
  String airlinePrefix;

  String logo;

  Airline({this.airlineName, this.airlineCode, this.airlinePrefix, this.logo});

  Airline getCopy() {
    Airline airline = Airline();
    airline.airlineName = this.airlineName;
    airline.airlineCode = this.airlineCode;
    airlinePrefix = this.airlinePrefix;
    return airline;
  }

  factory Airline.fromJson(Map<String, dynamic> json) =>
      _$AirlineFromJson(json);
  Map<String, dynamic> toJson() => _$AirlineToJson(this);
}

@JsonSerializable()
class RateSchedule {
  @JsonKey(name: 'data')
  List<Schedule> data;

  @JsonKey(ignore: true)
  List<Schedule> copySchedules; //For filter purpose only
  String url;

  final AsyncMemoizer<List<Schedule>> _memoizer = AsyncMemoizer();

  Future<List<Schedule>> get scheduleList {
    return _memoizer.runOnce(() async => _fetchSchedule());
  }

  _fetchSchedule() => new Future<List<Schedule>>.value(data.isNotEmpty
      ? data
      : ApiClient.getInstance
      .getScheduleListFromUrl(url)
      .then((scheduleList) {
    data = scheduleList;
    copySchedules = List.from(scheduleList);
    return data;
  }))
      .catchError((error) {
    return data = List();
  });

  RateSchedule(this.data, this.url) {
    if (url != null && url.isNotEmpty)
      _memoizer.runOnce(() async => _fetchSchedule());
  }

  factory RateSchedule.fromJson(Map<String, dynamic> json) =>
      _$RateScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$RateScheduleToJson(this);
}

@JsonSerializable()
class Vendor {
  @JsonKey(name: "vendor_name")
  final String vendorName;

  Vendor(this.vendorName);

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);
  Map<String, dynamic> toJson() => _$VendorToJson(this);
}

@JsonSerializable()
class SubVendor {
  @JsonKey(name: "sub_vendor_name")
  final String subVendorName;

  @JsonKey(name: "carrier_code")
  final String carrierCode;

  final String logo;

  @JsonKey(name: "sv_id")
  final int svId;

  SubVendor(this.subVendorName, this.carrierCode, this.logo, this.svId);

  factory SubVendor.fromJson(Map<String, dynamic> json) =>
      _$SubVendorFromJson(json);
  Map<String, dynamic> toJson() => _$SubVendorToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Charge {
  @JsonKey(name: 'charge_cost')
  dynamic chargeCost;

  num get chargeCostNumValue => num.tryParse(chargeCost.toString()) ?? 0;

  String charge_name;

  String get chargeName => '$charge_name';

  @JsonKey(name: 'charge_description', nullable: true, includeIfNull: true)
  String chargeDescription;

  @JsonKey(name: 'charge_currency', nullable: true, includeIfNull: true)
  String chargeCurrency;

  @JsonKey(name: 'customer_currency_cost', nullable: true, includeIfNull: true)
  num customerCurrencyCost;

  @JsonKey(name: 'global_charge_id', nullable: true, includeIfNull: true)
  String globalChargeId;

  @JsonKey(name: 'leg_currency_cost', nullable: true, includeIfNull: true)
  num legCurrencyCost;

  @JsonKey(name: 'per_unit_rate', nullable: true, includeIfNull: true)
  dynamic perUnitRate;

  num get perUnitRateNumvalue => num.tryParse(perUnitRate.toString()) ?? 0;

  @JsonKey(name: 'total_units', nullable: true, includeIfNull: true)
  dynamic totalUnits;

  @JsonKey(name: 'charge_basis', nullable: true, includeIfNull: true)
  String chargeBasis;

  @JsonKey(name: 'container_type', nullable: true, includeIfNull: true)
  String containerType;

  @JsonKey(name: "charge_source", nullable: true, includeIfNull: true)
  String chargeSource;

  @JsonKey(name: "charge_type", nullable: true, includeIfNull: true)
  String chargeType;

  @JsonKey(name: "created_at", nullable: true, includeIfNull: true)
  String createdAt;

  @JsonKey(name: "charge_id", nullable: true, includeIfNull: true)
  String chargeId;

  @JsonKey(name: "minimum_charge_cost", nullable: true, includeIfNull: true)
  dynamic minimumChargeCost;

  num get minChargeCostNum => num.tryParse(minimumChargeCost?.toString()) ?? 0;

  @JsonKey(name: "slab", includeIfNull: true)
  dynamic slab;

  @JsonKey(name: "slab_type", includeIfNull: true)
  String slabType;

  @JsonKey(name: "slab_basis", includeIfNull: true)
  String slabBasis;

  @JsonKey(name: "calculated_slab", includeIfNull: true)
  List<Slab> calculatedSlab;

  @JsonKey(name: "updated_at", nullable: true, includeIfNull: true)
  String updatedAt;

  dynamic id;

  @JsonKey(name: "min_flag", nullable: true, includeIfNull: true)
  num minFlag;

  @JsonKey(name: "is_minimum", nullable: true, includeIfNull: true)
  bool isMinimum;

  @JsonKey(name: "leg_currency", nullable: true, includeIfNull: true)
  String legCurrency;

  @JsonKey(defaultValue: false)
  bool manual;

  @JsonKey(name: "charge_category", nullable: true, includeIfNull: true)
  String chargeCategory;

  @JsonKey(name: "charge_code", nullable: true, includeIfNull: true)
  String chargeCode;

  @JsonKey(name: "is_qty_editable", defaultValue: false)
  bool isQtyEditable;

  @JsonKey(name: "result_sequence")
  int resultSequence;

  Charge getCopy() {
    Charge charge = Charge();
    charge.chargeCost = this.chargeCost;
    charge.charge_name = this.charge_name;
    charge.chargeDescription = this.chargeDescription;
    charge.chargeCurrency = this.chargeCurrency;
    charge.customerCurrencyCost = this.customerCurrencyCost;
    charge.globalChargeId = this.globalChargeId;
    charge.legCurrencyCost = this.legCurrencyCost;
    charge.perUnitRate = this.perUnitRate;
    charge.totalUnits = this.totalUnits;
    charge.chargeBasis = this.chargeBasis;
    charge.id = this.id;
    charge.containerType = this.containerType;
    charge.chargeId = this.chargeId;
    charge.chargeSource = this.chargeSource;
    charge.chargeType = this.chargeType;
    charge.createdAt = this.createdAt;
    charge.minimumChargeCost = this.minimumChargeCost;
    charge.slab = this.slab;
    charge.slabBasis = this.slabBasis;
    charge.slabType = this.slabType;
    charge.calculatedSlab = this.calculatedSlab;
    charge.updatedAt = this.updatedAt;
    charge.minFlag = this.minFlag;
    charge.minimumChargeCost = charge?.minimumChargeCost ?? 0;
    charge.isMinimum = this.isMinimum;
    charge.legCurrency = this.legCurrency;
    charge.manual = this.manual;
    charge.chargeCategory = this.chargeCategory;
    charge.chargeCode = this.chargeCode;
    charge.isQtyEditable = this.isQtyEditable;
    charge.resultSequence = this.resultSequence;
    return charge;
  }

  void copyWith(Charge charge) {
    this.chargeCost = charge.chargeCost;
    this.charge_name = charge.charge_name;
    this.chargeDescription = charge.chargeDescription;
    this.chargeCurrency = charge.chargeCurrency;
    this.customerCurrencyCost = charge.customerCurrencyCost;
    this.globalChargeId = charge.globalChargeId;
    this.legCurrencyCost = charge.legCurrencyCost;
    this.perUnitRate = charge.perUnitRate;
    this.chargeBasis = charge.chargeBasis;
    this.containerType = charge.containerType;
    this.id = charge.id;
    this.chargeId = charge.chargeId;
    this.chargeSource = charge.chargeSource;
    this.chargeType = charge.chargeType;
    this.createdAt = charge.createdAt;
    this.minimumChargeCost = charge.minimumChargeCost;
    this.slab = charge.slab;
    this.slabType = charge.slabType;
    this.updatedAt = charge.updatedAt;
    this.minFlag = charge.minFlag;
    this.minimumChargeCost = charge?.minimumChargeCost ?? 0;
    this.isMinimum = charge.isMinimum;
    this.legCurrency = charge.legCurrency;
    this.manual = charge.manual;
    this.chargeCategory = charge.chargeCategory;
    this.chargeCode = charge.chargeCode;
    this.isQtyEditable = charge.isQtyEditable;
    this.resultSequence = charge.resultSequence;
  }

  Charge(
      {this.chargeCost = 0,
        this.charge_name = "",
        this.chargeDescription = "",
        this.chargeCurrency = "",
        this.customerCurrencyCost = 0,
        this.globalChargeId,
        this.legCurrencyCost = 0,
        this.perUnitRate = 0,
        this.totalUnits = 0,
        this.chargeBasis,
        this.id,
        this.chargeId,
        this.chargeSource,
        this.chargeType,
        this.containerType,
        this.createdAt,
        this.minimumChargeCost = 0,
        this.slab,
        this.slabType,
        this.slabBasis,
        this.calculatedSlab,
        this.updatedAt,
        this.minFlag = 0,
        this.legCurrency,
        this.isMinimum = false,
        this.manual = true,
        this.chargeCategory,
        this.chargeCode,
        this.isQtyEditable = false,
        this.resultSequence});

  factory Charge.fromJson(Map<String, dynamic> json) => _$ChargeFromJson(json);
  Map<String, dynamic> toJson() => _$ChargeToJson(this);
}

@JsonSerializable()
class Slab {
  Slab({
    this.id,
    this.from,
    this.to,
    this.cost,
  });

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'from')
  int from;
  @JsonKey(name: 'to')
  int to;
  @JsonKey(name: 'cost')
  int cost;

  factory Slab.fromJson(Map<String, dynamic> json) => _$SlabFromJson(json);
  Map<String, dynamic> toJson() => _$SlabToJson(this);

  Slab getCopy() {
    Slab slab = Slab();
    slab.id = this.id;
    slab.from = this.from;
    slab.to = this.to;
    slab.cost = this.cost;
    return slab;
  }
}

@JsonSerializable()
class CardLeg {
  @JsonKey(name: 'leg_name')
  String name;

  @JsonKey(name: 'rate_id', nullable: true)
  dynamic rateId;

  @JsonKey(name: 'rate_obj', nullable: true)
  Rate rateObj;

  @JsonKey(name: 'leg_code')
  String legCode;

  @JsonKey(name: 'buy_rate_id', nullable: true)
  String buyRateId;

  @JsonKey(name: 'sub_vendor_id')
  dynamic subVendorId;

  @JsonKey(name: 'vendor_id')
  dynamic vendorId;

  @JsonKey(name: 'airline_code', nullable: true)
  String airlineCode;

  CardLeg(
      {this.name,
        this.rateId,
        this.rateObj,
        this.legCode,
        this.buyRateId,
        this.subVendorId,
        this.vendorId,
        this.airlineCode});

  static CardLeg fromRate(Rate rate, String legCode) {
    CardLeg cardLeg = CardLeg();
    cardLeg.name = rate.legName;
    cardLeg.vendorId = rate.vendorId;
    cardLeg.rateObj = rate;
    cardLeg.legCode = legCode;
    cardLeg.rateId = rate.id;
    cardLeg.subVendorId = rate.subVendorId;
    cardLeg.airlineCode = rate.airlineCode;
    return cardLeg;
  }

  factory CardLeg.fromJson(Map<String, dynamic> json) =>
      _$CardLegFromJson(json);
  Map<String, dynamic> toJson() => _$CardLegToJson(this);
}

@JsonSerializable()
class CurrencyConversionRate {
  @JsonKey(name: 'curr_data')
  Map<String, num> conversionRate;

  @JsonKey(name: 'vendor_id')
  dynamic vendorId;

  @JsonKey(name: '_id')
  dynamic id;

  String baseCurrency;

  String conversionTrailId;

  num markup;

  List<DirectCurrencyMapping> directCurrencyMapping;

  CurrencyConversionRate(
      this.conversionRate,
      this.vendorId,
      this.id,
      this.baseCurrency,
      this.conversionTrailId,
      this.directCurrencyMapping,
      this.markup);

  factory CurrencyConversionRate.fromJson(Map<String, dynamic> json) =>
      _$CurrencyConversionRateFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyConversionRateToJson(this);
}

@JsonSerializable()
class DirectCurrencyMapping {
  CurrencyMapping sourceCurrency;

  CurrencyMapping targetCurrency;

  DirectCurrencyMapping(this.sourceCurrency, this.targetCurrency);

  factory DirectCurrencyMapping.fromJson(Map<String, dynamic> json) =>
      _$DirectCurrencyMappingFromJson(json);
  Map<String, dynamic> toJson() => _$DirectCurrencyMappingToJson(this);
}

@JsonSerializable()
class CurrencyMapping {
  String code;

  String symbol;

  String name;

  num value;

  CurrencyMapping(this.code, this.symbol, this.value, this.name);

  factory CurrencyMapping.fromJson(Map<String, dynamic> json) =>
      _$CurrencyMappingFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyMappingToJson(this);
}

@JsonSerializable()
class Tag {
  @JsonKey(name: 'tag_name')
  String tagName;

  @JsonKey(name: 'tag_ribbon_url')
  String tagRibbonUrl;

  @JsonKey(name: 'show_tag')
  bool showTag;

  @JsonKey(name: 'tag_type')
  String tagType;

  Tag({this.tagName, this.tagRibbonUrl, this.showTag, this.tagType});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}

@JsonSerializable()
class SpecialMetaItem {
  String container_type;
  String special_qty_basis;

  Quantity special_total_qty;

  Quantity special_qty_rem;

  Quantity max_qty_per_shipment;

  int market_rate;
  String market_rate_currency;
  dynamic allow_unlimited; //TODO set appropriate data type
  String batchcode;

  SpecialMetaItem(
      this.container_type,
      this.special_qty_basis,
      this.special_total_qty,
      this.special_qty_rem,
      this.max_qty_per_shipment,
      this.market_rate,
      this.market_rate_currency,
      this.allow_unlimited,
      this.batchcode);

  factory SpecialMetaItem.fromJson(Map<String, dynamic> json) =>
      _$SpecialMetaItemFromJson(json);
  Map<String, dynamic> toJson() => _$SpecialMetaItemToJson(this);
}

@JsonSerializable()
class PromotionsItem {
  String name;
  String ribbon_url;
  String container_type;

  PromotionsItem(this.name, this.ribbon_url, this.container_type);

  factory PromotionsItem.fromJson(Map<String, dynamic> json) =>
      _$PromotionsItemFromJson(json);
  Map<String, dynamic> toJson() => _$PromotionsItemToJson(this);
}

@JsonSerializable()
class AdditionalChargesSearchResult {
  String url;

  @JsonKey(name: 'data')
  Rate rate;

  AdditionalChargesSearchResult(this.url, this.rate);

  factory AdditionalChargesSearchResult.fromJson(Map<String, dynamic> json) =>
      _$AdditionalChargesSearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$AdditionalChargesSearchResultToJson(this);
}

@JsonSerializable()
class AdditionLegs {
  @JsonKey(name: "currency_conversion_rates")
  List<CurrencyConversionRate> currencyConversionRates;

  LegsData data;

  AdditionLegs(this.data, this.currencyConversionRates);

  factory AdditionLegs.fromJson(Map<String, dynamic> json) =>
      _$AdditionLegsFromJson(json);
  Map<String, dynamic> toJson() => _$AdditionLegsToJson(this);
}

@JsonSerializable()
class LegsData {
  List<Rate> rates;

  LegsData(this.rates);

  factory LegsData.fromJson(Map<String, dynamic> json) =>
      _$LegsDataFromJson(json);
  Map<String, dynamic> toJson() => _$LegsDataToJson(this);
}
