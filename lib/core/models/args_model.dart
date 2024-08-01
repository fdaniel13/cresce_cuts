import 'package:cresce_cuts/core/enums/action_enum.dart';
import 'package:cresce_cuts/core/models/discounts_model.dart';

class ArgsModel{
  ActionEnum actionEnum;
  DiscountsModel? discountsModel;

  ArgsModel(this.actionEnum,{this.discountsModel});

}