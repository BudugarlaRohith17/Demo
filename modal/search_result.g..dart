// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return SearchResult(
    json['result_data'] == null
        ? null
        : ResultData.fromJson(json['result_data'] as Map<String, dynamic>),
    json['result_meta'] == null
        ? null
        : ResultMeta.fromJson(json['result_meta'] as Map<String, dynamic>),
    json['_id'] as String,
  );
}

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'result_data': instance.resultData?.toJson(),
      'result_meta': instance.resultMeta?.toJson(),
      '_id': instance.searchId,
    };

ResultMeta _$ResultMetaFromJson(Map<String, dynamic> json) {
  return ResultMeta(
    json['search_param'] == null
        ? null
        : SearchParam.fromJson(json['search_param'] as Map<String, dynamic>),
    (json['currency_conversion_rates'] as List)
        ?.map((e) => e == null
        ? null
        : CurrencyConversionRate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultMetaToJson(ResultMeta instance) =>
    <String, dynamic>{
      'search_param': instance.searchParam?.toJson(),
      'currency_conversion_rates':
      instance.currencyConversionRates?.map((e) => e?.toJson())?.toList(),
    };

LtlLoadDetails _$LtlLoadDetailsFromJson(Map<String, dynamic> json) {
  return LtlLoadDetails(
    origin: json['origin'] == null
        ? null
        : LtlDetails.fromJson(json['origin'] as Map<String, dynamic>),
    destination: json['destination'] == null
        ? null
        : LtlDetails.fromJson(json['destination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LtlLoadDetailsToJson(LtlLoadDetails instance) =>
    <String, dynamic>{
      'origin': instance.origin?.toJson(),
      'destination': instance.destination?.toJson(),
    };

LtlDetails _$LtlDetailsFromJson(Map<String, dynamic> json) {
  return LtlDetails(
    chargeableUnit: json['chargeable_unit'] as String,
    chargeableWeight: json['chargeable_weight'] as num,
    dimensionalFactor: json['dimensional_factor'] as num,
    dimensionalUnit: json['dimensional_unit'] as String,
    dimensionalWeight: json['dimensional_weight'] as num,
    grossWeight: json['gross_weight'] as num,
    grossWeightUnit: json['gross_weight_unit'] as String,
    portCode: json['port_code'] as String,
  );
}

Map<String, dynamic> _$LtlDetailsToJson(LtlDetails instance) =>
    <String, dynamic>{
      'dimensional_weight': instance.dimensionalWeight,
      'dimensional_unit': instance.dimensionalUnit,
      'chargeable_weight': instance.chargeableWeight,
      'chargeable_unit': instance.chargeableUnit,
      'dimensional_factor': instance.dimensionalFactor,
      'gross_weight': instance.grossWeight,
      'gross_weight_unit': instance.grossWeightUnit,
      'port_code': instance.portCode,
    };

ResultData _$ResultDataFromJson(Map<String, dynamic> json) {
  return ResultData(
    json['msr_rates'] == null
        ? null
        : GeneralRates.fromJson(json['msr_rates'] as Map<String, dynamic>),
    json['network_rates'] == null
        ? null
        : GeneralRates.fromJson(json['network_rates'] as Map<String, dynamic>),
    json['iata_rates'] == null
        ? null
        : GeneralRates.fromJson(json['iata_rates'] as Map<String, dynamic>),
    json['nearby_port_rates'] == null
        ? null
        : NearByRates.fromJson(
        json['nearby_port_rates'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'msr_rates': instance.msrRates?.toJson(),
      'network_rates': instance.networkRates?.toJson(),
      'iata_rates': instance.iataRates?.toJson(),
      'nearby_port_rates': instance.nearByRates?.toJson(),
    };

NearByRates _$NearByRatesFromJson(Map<String, dynamic> json) {
  return NearByRates(
    (json['msr_rates'] as List)
        ?.map((e) =>
    e == null ? null : GeneralRates.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['network_rates'] as List)
        ?.map((e) =>
    e == null ? null : GeneralRates.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['msr_spot'] as List,
    json['network_spot'] as List,
  );
}

Map<String, dynamic> _$NearByRatesToJson(NearByRates instance) =>
    <String, dynamic>{
      'msr_rates': instance.msrRates?.map((e) => e?.toJson())?.toList(),
      'network_rates': instance.networkRates?.map((e) => e?.toJson())?.toList(),
      'msr_spot': instance.msrSpotList,
      'network_spot': instance.networkSpotList,
    };

GeneralRates _$GeneralRatesFromJson(Map<String, dynamic> json) {
  return GeneralRates(
    json['data'] == null
        ? null
        : RatesData.fromJson(json['data'] as Map<String, dynamic>),
    json['url'] as String,
    (json['currency_conversion_rates'] as List)
        ?.map((e) => e == null
        ? null
        : CurrencyConversionRate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['spot'] as List,
    json['message'] as String,
  );
}

Map<String, dynamic> _$GeneralRatesToJson(GeneralRates instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'url': instance.url,
      'spot': instance.spotDataList,
      'currency_conversion_rates':
      instance.currencyConversionRates?.map((e) => e?.toJson())?.toList(),
      'message': instance.message,
    };

RatesData _$RatesDataFromJson(Map<String, dynamic> json) {
  return RatesData(
    cards: (json['cards'] as List)
        ?.map((e) =>
    e == null ? null : RateCard.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    rates: (json['rates'] as List)
        ?.map(
            (e) => e == null ? null : Rate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..id = json['_id'] as String;
}

Map<String, dynamic> _$RatesDataToJson(RatesData instance) => <String, dynamic>{
  'rates': instance.rates?.map((e) => e?.toJson())?.toList(),
  'cards': instance.cards?.map((e) => e?.toJson())?.toList(),
  '_id': instance.id,
};

RateCard _$RateCardFromJson(Map<String, dynamic> json) {
  return RateCard(
    json['data'] == null
        ? null
        : CardData.fromJson(json['data'] as Map<String, dynamic>),
    json['meta'] == null
        ? null
        : CardMeta.fromJson(json['meta'] as Map<String, dynamic>),
    json['_id'] as String,
  );
}

Map<String, dynamic> _$RateCardToJson(RateCard instance) => <String, dynamic>{
  'data': instance.data?.toJson(),
  'meta': instance.meta?.toJson(),
  '_id': instance.id,
};

CardMeta _$CardMetaFromJson(Map<String, dynamic> json) {
  return CardMeta(
    isSelected: json['is_selected'] as bool,
    selectedSchedule: json['selected_schedule'] == null
        ? null
        : Schedule.fromJson(json['selected_schedule'] as Map<String, dynamic>),
    cardTotalCost: json['card_total_cost'],
    remarks: json['remarks'] as String,
    vendorId: json['vendor_id'],
    portData: json['port_data'] == null
        ? null
        : PortData.fromJson(json['port_data'] as Map<String, dynamic>),
    via_pol: json['via_pol'] as String,
    via_pod: json['via_pod'] as String,
    haulage: json['haulage'] as String,
    inclusions: json['inclusions'] as String,
    haulage_available: json['haulage_available'] as bool,
    destination_haulage: json['destination_haulage'] as String,
    type: json['type'] as String,
    additionalCharges: json['additional_charges'] == null
        ? null
        : AdditionalChargesSearchResult.fromJson(
        json['additional_charges'] as Map<String, dynamic>),
    ltlLoadDetails: json['ltl_load_details'] == null
        ? null
        : LtlLoadDetails.fromJson(
        json['ltl_load_details'] as Map<String, dynamic>),
    makeRatesGlobal: (json['make_rates_global'] as List)
        ?.map((e) => e == null
        ? null
        : MakeRatesGlobal.fromJson(e as Map<String, dynamic>))
        ?.toList() ??
        [],
    pickupTransportMode: json['pickup_transport_mode'] as String,
    deliveryTransportMode: json['delivery_transport_mode'] as String,
    pickupService: json['pickup_service'] as String,
    deliveryService: json['delivery_service'] as String,
    pickupSubVendor: json['pickup_sub_vendor'] == null ? null : SubVendor.fromJson(json['pickup_sub_vendor'] as Map<String, dynamic>),
    deliverySubVendor: json['delivery_sub_vendor'] == null ? null : SubVendor.fromJson(json['delivery_sub_vendor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CardMetaToJson(CardMeta instance) => <String, dynamic>{
  'is_selected': instance.isSelected,
  'selected_schedule': instance.selectedSchedule?.toJson(),
  'card_total_cost': instance.cardTotalCost,
  'remarks': instance.remarks,
  'vendor_id': instance.vendorId,
  'port_data': instance.portData?.toJson(),
  'inclusions': instance.inclusions,
  'type': instance.type,
  'via_pol': instance.via_pol,
  'via_pod': instance.via_pod,
  'haulage': instance.haulage,
  'destination_haulage': instance.destination_haulage,
  'haulage_available': instance.haulage_available,
  'ltl_load_details': instance.ltlLoadDetails?.toJson(),
  'make_rates_global':
  instance.makeRatesGlobal?.map((e) => e?.toJson())?.toList(),
  'additional_charges': instance.additionalCharges?.toJson(),
  'pickup_transport_mode': instance.pickupTransportMode,
  'delivery_transport_mode': instance.deliveryTransportMode,
  'pickup_service' : instance.pickupService,
  'delivery_service': instance.deliveryService,
  'pickup_sub_vendor' : instance.pickupSubVendor?.toJson(),
  'delivery_sub_vendor' : instance.deliverySubVendor?.toJson(),
};

MakeRatesGlobal _$MakeRatesGlobalFromJson(Map<String, dynamic> json) {
  return MakeRatesGlobal(
    json['leg_code'] as String,
    json['error'] as String,
    json['batch_code'] as String,
  );
}

Map<String, dynamic> _$MakeRatesGlobalToJson(MakeRatesGlobal instance) =>
    <String, dynamic>{
      'batch_code': instance.batchCode,
      'error': instance.error,
      'leg_code': instance.legCode,
    };

CardData _$CardDataFromJson(Map<String, dynamic> json) {
  return CardData(
    (json['buy_rates'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(
          k, e == null ? null : CardLeg.fromJson(e as Map<String, dynamic>)),
    ),
    (json['sell_rates'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(
          k, e == null ? null : CardLeg.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
  'buy_rates': instance.buyRates?.map((k, e) => MapEntry(k, e?.toJson())),
  'sell_rates': instance.sellRates?.map((k, e) => MapEntry(k, e?.toJson())),
};

Rate _$RateFromJson(Map<String, dynamic> json) {
  return Rate(
    id: json['_id'] as String,
    expiry: json['expiry'] == null
        ? null
        : DateTime.parse(json['expiry'] as String),
    startDate: json['start_date'] == null
        ? null
        : DateTime.parse(json['start_date'] as String),
    airline: json['airline'] == null
        ? null
        : Airline.fromJson(json['airline'] as Map<String, dynamic>),
    legTotalCost: json['leg_total_cost'] as num,
    legTotalCurrency: json['leg_total_currency'] as String,
    vendorId: json['vendor_id'],
    subVendorId: json['sub_vendor_id'],
    legCode: json['leg_code'] as String,
    legCurrency: json['leg_currency'] as String,
    legName: json['leg_name'] as String,
    globalLegId: json['global_leg_id'] as String,
    serviceType: json['service_type'] as String,
    subVendor: json['sub_vendor'] == null
        ? null
        : SubVendor.fromJson(json['sub_vendor'] as Map<String, dynamic>),
    rateSchedule: json['schedule'] == null
        ? null
        : RateSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
    vendor: json['vendor'] == null
        ? null
        : Vendor.fromJson(json['vendor'] as Map<String, dynamic>),
    charges: (json['charges'] as List)
        ?.map((e) =>
    e == null ? null : Charge.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    slabCharges: json['slab_charges'],
    tags: (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isSpecial: json['is_special'] as bool ?? false,
    specialMetaList: (json['special_meta'] as List)
        ?.map((e) => e == null
        ? null
        : SpecialMetaItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    viaRoute: json['via_route'] as String,
    remarks: json['remarks'] as String,
    inclusions: json['inclusions'] as String,
    legCurrencyCost: json['leg_currency_cost'] as num,
    slab: json['slab'],
    slabCurrency: json['slab_currency'] as String,
    price_id: json['price_id'] as String,
    demurrage: (json['demurrage'] as List)
        ?.map((e) =>
    e == null ? null : FreeDaysData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    detention: (json['detention'] as List)
        ?.map((e) =>
    e == null ? null : FreeDaysData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    tnc: json['terms_and_condition'] == null
        ? null
        : TermsAndCondition.fromJson(
        json['terms_and_condition'] as Map<String, dynamic>),
    value_of_good: json['value_of_good'] as Map<String, dynamic>,
    promotionsList: (json['promotions'] as List)
        ?.map((e) => e == null
        ? null
        : PromotionsItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    slabRate: json['slab_rate'] as Map<String, dynamic>,
    haulage_available: json['haulage_available'] as bool ?? false,
    destination_haulage: json['destination_haulage'] as String,
    origin_haulage: json['origin_haulage'] as String,
    transitTime: json['transit_time'] as String,
    agentData: json['agent'] == null
        ? null
        : AgentData.fromJson(json['agent'] as Map<String, dynamic>),
    penaltyDetails: json['penalty_details'] == null
        ? null
        : PenaltyDetails.fromJson(
        json['penalty_details'] as Map<String, dynamic>),
    rollableAvailable: json['rollable_available'] as bool ?? false,
    demurrageDetails: json['demurrage_details'] == null
        ? null
        : FreeDaysDetails.fromJson(
        json['demurrage_details'] as Map<String, dynamic>),
    detentionDetails: json['detention_details'] == null
        ? null
        : FreeDaysDetails.fromJson(
        json['detention_details'] as Map<String, dynamic>),
    legDescription: json['leg_description'] as String,
    destinationFreeDays: json['destination_free_days'] as int,
    originFreeDays: json['origin_free_days'] as int,
    ltlLoadDetails: json['ltl_load_details'] == null
        ? null
        : LtlDetails.fromJson(json['ltl_load_details'] as Map<String, dynamic>),
    viaPod: json['via_pod'] as String,
    viaPol: json['via_pol'] as String,
    agentId: json['agent_id'],
    svCombination: json['sv_combination'] as List,
    cargoTypeData: json['cargo_type_data'] == null
        ? null
        : CargoType.fromJson(json['cargo_type_data'] as Map<String, dynamic>),
    commodityData:
    (json['commodity_data'] as List)?.map((e) => e as String)?.toList(),
    cargoType: json['cargo_type'] as String,
    commodity: json['commodity'] as String,
    dim: json['dim'],
    dimData: json['dim_data'],
    originCombinedFreeDays: json['origin_combined_free_days'] as int,
    destinationCombinedFreeDays: json['destination_combined_free_days'] as int,
  )
    ..airlineCode = json['airline_code'] as String
    ..batchCode = json['batchcode'];
}

Map<String, dynamic> _$RateToJson(Rate instance) => <String, dynamic>{
  '_id': instance.id,
  'airline': instance.airline?.toJson(),
  'airline_code': instance.airlineCode,
  'expiry': instance.expiry?.toIso8601String(),
  'start_date': instance.startDate?.toIso8601String(),
  'leg_total_cost': instance.legTotalCost,
  'leg_total_currency': instance.legTotalCurrency,
  'vendor_id': instance.vendorId,
  'sub_vendor_id': instance.subVendorId,
  'vendor': instance.vendor?.toJson(),
  'sub_vendor': instance.subVendor?.toJson(),
  'charges': instance.charges?.map((e) => e?.toJson())?.toList(),
  'slab_charges': instance.slabCharges,
  'leg_code': instance.legCode,
  'leg_currency': instance.legCurrency,
  'leg_currency_cost': instance.legCurrencyCost,
  'leg_name': instance.legName,
  'leg_description': instance.legDescription,
  'global_leg_id': instance.globalLegId,
  'schedule': instance.rateSchedule?.toJson(),
  'service_type': instance.serviceType,
  'is_special': instance.isSpecial,
  'special_meta':
  instance.specialMetaList?.map((e) => e?.toJson())?.toList(),
  'promotions': instance.promotionsList?.map((e) => e?.toJson())?.toList(),
  'batchcode': instance.batchCode,
  'via_route': instance.viaRoute,
  'inclusions': instance.inclusions,
  'remarks': instance.remarks,
  'tags': instance.tags?.map((e) => e?.toJson())?.toList(),
  'price_id': instance.price_id,
  'slab': instance.slab,
  'slab_currency': instance.slabCurrency,
  'demurrage': instance.demurrage?.map((e) => e?.toJson())?.toList(),
  'detention': instance.detention?.map((e) => e?.toJson())?.toList(),
  'value_of_good': instance.value_of_good,
  'terms_and_condition': instance.tnc?.toJson(),
  'slab_rate': instance.slabRate,
  'haulage_available': instance.haulage_available,
  'origin_haulage': instance.origin_haulage,
  'destination_haulage': instance.destination_haulage,
  'transit_time': instance.transitTime,
  'agent': instance.agentData?.toJson(),
  'penalty_details': instance.penaltyDetails?.toJson(),
  'rollable_available': instance.rollableAvailable,
  'demurrage_details': instance.demurrageDetails?.toJson(),
  'detention_details': instance.detentionDetails?.toJson(),
  'destination_free_days': instance.destinationFreeDays,
  'origin_free_days': instance.originFreeDays,
  'ltl_load_details': instance.ltlLoadDetails?.toJson(),
  'via_pol': instance.viaPol,
  'via_pod': instance.viaPod,
  'agent_id': instance.agentId,
  'sv_combination': instance.svCombination,
  'commodity': instance.commodity,
  'commodity_data': instance.commodityData,
  'cargo_type': instance.cargoType,
  'cargo_type_data': instance.cargoTypeData?.toJson(),
  'dim': instance.dim,
  'dim_data': instance.dimData,
  'origin_combined_free_days': instance.originCombinedFreeDays,
  'destination_combined_free_days': instance.destinationCombinedFreeDays,
};

SlabCharge _$SlabChargeFromJson(Map<String, dynamic> json) {
  return SlabCharge(
    legName: json['leg_name'] as String,
    chargeName: json['charge_name'] as String,
    chargeCode: json['charge_code'] as String,
    loadType: json['load_type'] as String,
    currency: json['currency'] as String,
    slabBasis: json['slab_basis'] as String,
    slab: (json['slab'] as List)
        ?.map(
            (e) => e == null ? null : Slab.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SlabChargeToJson(SlabCharge instance) =>
    <String, dynamic>{
      'leg_name': instance.legName,
      'charge_name': instance.chargeName,
      'charge_code': instance.chargeCode,
      'load_type': instance.loadType,
      'currency': instance.currency,
      'slab_basis': instance.slabBasis,
      'slab': instance.slab?.map((e) => e?.toJson())?.toList(),
    };

AgentData _$AgentDataFromJson(Map<String, dynamic> json) {
  return AgentData(
    agentName: json['agent_name'] as String,
  );
}

Map<String, dynamic> _$AgentDataToJson(AgentData instance) => <String, dynamic>{
  'agent_name': instance.agentName,
};

FreeDaysDetails _$FreeDaysDetailsFromJson(Map<String, dynamic> json) {
  return FreeDaysDetails(
    origin: (json['origin'] as List)
        ?.map((e) =>
    e == null ? null : FreeDaysData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    destination: (json['destination'] as List)
        ?.map((e) =>
    e == null ? null : FreeDaysData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FreeDaysDetailsToJson(FreeDaysDetails instance) =>
    <String, dynamic>{
      'origin': instance.origin?.map((e) => e?.toJson())?.toList(),
      'destination': instance.destination?.map((e) => e?.toJson())?.toList(),
    };

PenaltyDetails _$PenaltyDetailsFromJson(Map<String, dynamic> json) {
  return PenaltyDetails(
    penaltyFees: (json['penalty_fees'] as List)
        ?.map((e) =>
    e == null ? null : PenaltyData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    penaltyMessage: json['penalty_message'] as String,
  );
}

Map<String, dynamic> _$PenaltyDetailsToJson(PenaltyDetails instance) =>
    <String, dynamic>{
      'penalty_message': instance.penaltyMessage,
      'penalty_fees': instance.penaltyFees?.map((e) => e?.toJson())?.toList(),
    };

PenaltyData _$PenaltyDataFromJson(Map<String, dynamic> json) {
  return PenaltyData(
    chargeName: json['charge_name'] as String,
    buyRate: json['buy_rate'] as num,
    chargeCurrency: json['charge_currency'] as String,
    chargeType: json['charge_type'] as String,
    loadType: json['load_type'] as String,
    sellRate: json['sell_rate'] as num,
  );
}

Map<String, dynamic> _$PenaltyDataToJson(PenaltyData instance) =>
    <String, dynamic>{
      'charge_type': instance.chargeType,
      'charge_name': instance.chargeName,
      'load_type': instance.loadType,
      'charge_currency': instance.chargeCurrency,
      'buy_rate': instance.buyRate,
      'sell_rate': instance.sellRate,
    };

FreeDaysData _$FreeDaysDataFromJson(Map<String, dynamic> json) {
  return FreeDaysData(
    container_type: json['container_type'] as String,
    value: json['value'] as int,
    freeDays: json['free_days'] as int,
  );
}

Map<String, dynamic> _$FreeDaysDataToJson(FreeDaysData instance) =>
    <String, dynamic>{
      'container_type': instance.container_type,
      'value': instance.value,
      'free_days': instance.freeDays,
    };

TermsAndCondition _$TermsAndConditionFromJson(Map<String, dynamic> json) {
  return TermsAndCondition(
    url: json['url'] as String,
    data: json['data'] as String,
    tandcURL: json['terms_and_condition_url'] as String,
  );
}

Map<String, dynamic> _$TermsAndConditionToJson(TermsAndCondition instance) =>
    <String, dynamic>{
      'url': instance.url,
      'data': instance.data,
      'terms_and_condition_url': instance.tandcURL,
    };

TermsAndConditionData _$TermsAndConditionDataFromJson(
    Map<String, dynamic> json) {
  return TermsAndConditionData(
    terms_and_condition_data: json['terms_and_condition_data'] as String,
    vendor_id: json['vendor_id'] as String,
    sv_vendor: json['sv_vendor'] as String,
  );
}

Map<String, dynamic> _$TermsAndConditionDataToJson(
    TermsAndConditionData instance) =>
    <String, dynamic>{
      'terms_and_condition_data': instance.terms_and_condition_data,
      'vendor_id': instance.vendor_id,
      'sv_vendor': instance.sv_vendor,
    };

Airline _$AirlineFromJson(Map<String, dynamic> json) {
  return Airline(
    airlineName: json['air_line_name'] as String,
    airlineCode: json['airline_code'] as String ?? '',
    airlinePrefix: json['airline_prefix'] as String,
    logo: json['logo'] as String,
  );
}

Map<String, dynamic> _$AirlineToJson(Airline instance) => <String, dynamic>{
  'air_line_name': instance.airlineName,
  'airline_code': instance.airlineCode,
  'airline_prefix': instance.airlinePrefix,
  'logo': instance.logo,
};

RateSchedule _$RateScheduleFromJson(Map<String, dynamic> json) {
  return RateSchedule(
    (json['data'] as List)
        ?.map((e) =>
    e == null ? null : Schedule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['url'] as String,
  );
}

Map<String, dynamic> _$RateScheduleToJson(RateSchedule instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
      'url': instance.url,
    };

Vendor _$VendorFromJson(Map<String, dynamic> json) {
  return Vendor(
    json['vendor_name'] as String,
  );
}

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
  'vendor_name': instance.vendorName,
};

SubVendor _$SubVendorFromJson(Map<String, dynamic> json) {
  return SubVendor(
    json['sub_vendor_name'] as String,
    json['carrier_code'] as String,
    json['logo'] as String,
    json['sv_id'] as int,
  );
}

Map<String, dynamic> _$SubVendorToJson(SubVendor instance) => <String, dynamic>{
  'sub_vendor_name': instance.subVendorName,
  'carrier_code': instance.carrierCode,
  'logo': instance.logo,
  'sv_id': instance.svId,
};

Charge _$ChargeFromJson(Map<String, dynamic> json) {
  return Charge(
    chargeCost: json['charge_cost'],
    charge_name: json['charge_name'] as String,
    chargeDescription: json['charge_description'] as String,
    chargeCurrency: json['charge_currency'] as String,
    customerCurrencyCost: json['customer_currency_cost'] as num,
    globalChargeId: json['global_charge_id'] as String,
    legCurrencyCost: json['leg_currency_cost'] as num,
    perUnitRate: json['per_unit_rate'],
    totalUnits: json['total_units'],
    chargeBasis: json['charge_basis'] as String,
    id: json['id'],
    chargeId: json['charge_id'] as String,
    chargeSource: json['charge_source'] as String,
    chargeType: json['charge_type'] as String,
    containerType: json['container_type'] as String,
    createdAt: json['created_at'] as String,
    minimumChargeCost: json['minimum_charge_cost'],
    slab: json['slab'],
    slabType: json['slab_type'] as String,
    slabBasis: json['slab_basis'] as String,
    calculatedSlab: (json['calculated_slab'] as List)
        ?.map(
            (e) => e == null ? null : Slab.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    updatedAt: json['updated_at'] as String,
    minFlag: json['min_flag'] as num,
    legCurrency: json['leg_currency'] as String,
    isMinimum: json['is_minimum'] as bool,
    manual: json['manual'] as bool ?? false,
    chargeCategory: json['charge_category'] as String,
    chargeCode: json['charge_code'] as String,
    isQtyEditable: json['is_qty_editable'] as bool ?? false,
    resultSequence: json['result_sequence'] as int,
  );
}

Map<String, dynamic> _$ChargeToJson(Charge instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('charge_cost', instance.chargeCost);
  writeNotNull('charge_name', instance.charge_name);
  val['charge_description'] = instance.chargeDescription;
  val['charge_currency'] = instance.chargeCurrency;
  val['customer_currency_cost'] = instance.customerCurrencyCost;
  val['global_charge_id'] = instance.globalChargeId;
  val['leg_currency_cost'] = instance.legCurrencyCost;
  val['per_unit_rate'] = instance.perUnitRate;
  val['total_units'] = instance.totalUnits;
  val['charge_basis'] = instance.chargeBasis;
  val['container_type'] = instance.containerType;
  val['charge_source'] = instance.chargeSource;
  val['charge_type'] = instance.chargeType;
  val['created_at'] = instance.createdAt;
  val['charge_id'] = instance.chargeId;
  val['minimum_charge_cost'] = instance.minimumChargeCost;
  val['slab'] = instance.slab;
  val['slab_type'] = instance.slabType;
  val['slab_basis'] = instance.slabBasis;
  val['calculated_slab'] =
      instance.calculatedSlab?.map((e) => e?.toJson())?.toList();
  val['updated_at'] = instance.updatedAt;
  writeNotNull('id', instance.id);
  val['min_flag'] = instance.minFlag;
  val['is_minimum'] = instance.isMinimum;
  val['leg_currency'] = instance.legCurrency;
  writeNotNull('manual', instance.manual);
  val['charge_category'] = instance.chargeCategory;
  val['charge_code'] = instance.chargeCode;
  writeNotNull('is_qty_editable', instance.isQtyEditable);
  writeNotNull('result_sequence', instance.resultSequence);
  return val;
}

Slab _$SlabFromJson(Map<String, dynamic> json) {
  return Slab(
    id: json['id'] as String,
    from: json['from'] as int,
    to: json['to'] as int,
    cost: json['cost'] as int,
  );
}

Map<String, dynamic> _$SlabToJson(Slab instance) => <String, dynamic>{
  'id': instance.id,
  'from': instance.from,
  'to': instance.to,
  'cost': instance.cost,
};

CardLeg _$CardLegFromJson(Map<String, dynamic> json) {
  return CardLeg(
    name: json['leg_name'] as String,
    rateId: json['rate_id'],
    rateObj: json['rate_obj'] == null
        ? null
        : Rate.fromJson(json['rate_obj'] as Map<String, dynamic>),
    legCode: json['leg_code'] as String,
    buyRateId: json['buy_rate_id'] as String,
    subVendorId: json['sub_vendor_id'],
    vendorId: json['vendor_id'],
    airlineCode: json['airline_code'] as String,
  );
}

Map<String, dynamic> _$CardLegToJson(CardLeg instance) => <String, dynamic>{
  'leg_name': instance.name,
  'rate_id': instance.rateId,
  'rate_obj': instance.rateObj?.toJson(),
  'leg_code': instance.legCode,
  'buy_rate_id': instance.buyRateId,
  'sub_vendor_id': instance.subVendorId,
  'vendor_id': instance.vendorId,
  'airline_code': instance.airlineCode,
};

CurrencyConversionRate _$CurrencyConversionRateFromJson(
    Map<String, dynamic> json) {
  return CurrencyConversionRate(
    (json['curr_data'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(k, e as num),
    ),
    json['vendor_id'],
    json['_id'],
    json['baseCurrency'] as String,
    json['conversionTrailId'] as String,
    (json['directCurrencyMapping'] as List)
        ?.map((e) => e == null
        ? null
        : DirectCurrencyMapping.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['markup'] as num,
  );
}

Map<String, dynamic> _$CurrencyConversionRateToJson(
    CurrencyConversionRate instance) =>
    <String, dynamic>{
      'curr_data': instance.conversionRate,
      'vendor_id': instance.vendorId,
      '_id': instance.id,
      'baseCurrency': instance.baseCurrency,
      'conversionTrailId': instance.conversionTrailId,
      'markup': instance.markup,
      'directCurrencyMapping':
      instance.directCurrencyMapping?.map((e) => e?.toJson())?.toList(),
    };

DirectCurrencyMapping _$DirectCurrencyMappingFromJson(
    Map<String, dynamic> json) {
  return DirectCurrencyMapping(
    json['sourceCurrency'] == null
        ? null
        : CurrencyMapping.fromJson(
        json['sourceCurrency'] as Map<String, dynamic>),
    json['targetCurrency'] == null
        ? null
        : CurrencyMapping.fromJson(
        json['targetCurrency'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DirectCurrencyMappingToJson(
    DirectCurrencyMapping instance) =>
    <String, dynamic>{
      'sourceCurrency': instance.sourceCurrency?.toJson(),
      'targetCurrency': instance.targetCurrency?.toJson(),
    };

CurrencyMapping _$CurrencyMappingFromJson(Map<String, dynamic> json) {
  return CurrencyMapping(
    json['code'] as String,
    json['symbol'] as String,
    json['value'] as num,
    json['name'] as String,
  );
}

Map<String, dynamic> _$CurrencyMappingToJson(CurrencyMapping instance) =>
    <String, dynamic>{
      'code': instance.code,
      'symbol': instance.symbol,
      'name': instance.name,
      'value': instance.value,
    };

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    tagName: json['tag_name'] as String,
    tagRibbonUrl: json['tag_ribbon_url'] as String,
    showTag: json['show_tag'] as bool,
    tagType: json['tag_type'] as String,
  );
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
  'tag_name': instance.tagName,
  'tag_ribbon_url': instance.tagRibbonUrl,
  'show_tag': instance.showTag,
  'tag_type': instance.tagType,
};

SpecialMetaItem _$SpecialMetaItemFromJson(Map<String, dynamic> json) {
  return SpecialMetaItem(
    json['container_type'] as String,
    json['special_qty_basis'] as String,
    json['special_total_qty'] == null
        ? null
        : Quantity.fromJson(json['special_total_qty'] as Map<String, dynamic>),
    json['special_qty_rem'] == null
        ? null
        : Quantity.fromJson(json['special_qty_rem'] as Map<String, dynamic>),
    json['max_qty_per_shipment'] == null
        ? null
        : Quantity.fromJson(
        json['max_qty_per_shipment'] as Map<String, dynamic>),
    json['market_rate'] as int,
    json['market_rate_currency'] as String,
    json['allow_unlimited'],
    json['batchcode'] as String,
  );
}

Map<String, dynamic> _$SpecialMetaItemToJson(SpecialMetaItem instance) =>
    <String, dynamic>{
      'container_type': instance.container_type,
      'special_qty_basis': instance.special_qty_basis,
      'special_total_qty': instance.special_total_qty?.toJson(),
      'special_qty_rem': instance.special_qty_rem?.toJson(),
      'max_qty_per_shipment': instance.max_qty_per_shipment?.toJson(),
      'market_rate': instance.market_rate,
      'market_rate_currency': instance.market_rate_currency,
      'allow_unlimited': instance.allow_unlimited,
      'batchcode': instance.batchcode,
    };

PromotionsItem _$PromotionsItemFromJson(Map<String, dynamic> json) {
  return PromotionsItem(
    json['name'] as String,
    json['ribbon_url'] as String,
    json['container_type'] as String,
  );
}

Map<String, dynamic> _$PromotionsItemToJson(PromotionsItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ribbon_url': instance.ribbon_url,
      'container_type': instance.container_type,
    };

AdditionalChargesSearchResult _$AdditionalChargesSearchResultFromJson(
    Map<String, dynamic> json) {
  return AdditionalChargesSearchResult(
    json['url'] as String,
    json['data'] == null
        ? null
        : Rate.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AdditionalChargesSearchResultToJson(
    AdditionalChargesSearchResult instance) =>
    <String, dynamic>{
      'url': instance.url,
      'data': instance.rate?.toJson(),
    };

AdditionLegs _$AdditionLegsFromJson(Map<String, dynamic> json) {
  return AdditionLegs(
    json['data'] == null
        ? null
        : LegsData.fromJson(json['data'] as Map<String, dynamic>),
    (json['currency_conversion_rates'] as List)
        ?.map((e) => e == null
        ? null
        : CurrencyConversionRate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AdditionLegsToJson(AdditionLegs instance) =>
    <String, dynamic>{
      'currency_conversion_rates':
      instance.currencyConversionRates?.map((e) => e?.toJson())?.toList(),
      'data': instance.data?.toJson(),
    };

LegsData _$LegsDataFromJson(Map<String, dynamic> json) {
  return LegsData(
    (json['rates'] as List)
        ?.map(
            (e) => e == null ? null : Rate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LegsDataToJson(LegsData instance) => <String, dynamic>{
  'rates': instance.rates?.map((e) => e?.toJson())?.toList(),
};
