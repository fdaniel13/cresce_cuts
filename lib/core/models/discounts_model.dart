import 'package:cresce_cuts/core/enums/type_discount_enum.dart';

class DiscountsModel {
  int? id;
  String? title;
  double? price;
  String? description;
  TypeDiscountEnum? type;
  String? imageUrl;

  double? priceOf;
  double? priceFor;
  double? percentageDiscount;
  int? takeQuantity;
  int? buyQuantity;
  DateTime? dateActivation;
  DateTime? dateInactivation;
  bool? actived;

  DiscountsModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.type,
      this.imageUrl,
      this.priceOf,
      this.priceFor,
      this.percentageDiscount,
      this.takeQuantity,
      this.buyQuantity,
      this.dateActivation,
      this.dateInactivation,
      this.actived});

  DiscountsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actived=json['actived']==1?true:false;
    title = json['title'];
    price = double.parse(json['price'].toString());
    description = json['description'];
    type = json['type']==null ? null: TypeDiscountEnum.values.firstWhere((element) => element.name.contains(json['type']));
    imageUrl = json['imageUrl'];
    priceOf = json['priceOf'] == null
        ? null
        : double.parse(json['priceOf'].toString());
    priceFor = json['priceFor'] == null
        ? null
        : double.parse(json['priceFor'].toString());
    percentageDiscount = json['percentageDiscount'] == null
        ? null
        : double.parse(json['percentageDiscount'].toString());
    takeQuantity = json['takeQuantity'] == null
        ? null
        : int.parse(json['takeQuantity'].toString());
    buyQuantity = json['buyQuantity'] == null
        ? null
        : int.parse(json['buyQuantity'].toString());
    dateActivation = json['dateActivation'] == null
        ? null
        : DateTime.parse(json['dateActivation']);
    dateInactivation = json['dateInactivation'] == null
        ? null
        : DateTime.parse(json['dateInactivation']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['type'] = this.type!.stringEnum;
    data['imageUrl'] = this.imageUrl;
    data['priceOf'] = this.priceOf;
    data['priceFor'] = this.priceFor;
    data['percentageDiscount'] = this.percentageDiscount;
    data['takeQuantity'] = this.takeQuantity;
    data['buyQuantity'] = this.buyQuantity;
    data['dateActivation'] = this.dateActivation.toString();
    data['dateInactivation'] = this.dateInactivation.toString();
    data['actived']=this.actived==true?1:0;

    return data;
  }
}
