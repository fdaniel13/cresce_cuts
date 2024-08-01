import 'package:cresce_cuts/core/const/icons_svg.dart';
import 'package:cresce_cuts/core/enums/action_enum.dart';
import 'package:cresce_cuts/core/models/args_model.dart';
import 'package:cresce_cuts/core/models/discounts_model.dart';
import 'package:cresce_cuts/modules/discount_detail_module/discount_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/enums/type_discount_enum.dart';

class DiscountDetailPage extends StatefulWidget {
  const DiscountDetailPage({super.key});

  @override
  State<DiscountDetailPage> createState() => _DiscountDetailPageState();
}

class _DiscountDetailPageState extends State<DiscountDetailPage> {
  late Future<DiscountsModel> data;
  final controller = Modular.get<DiscountDetailController>();
  late bool swicthValue;
late DiscountsModel _discountsModel;
  @override
  void initState() {
    super.initState();
    data = Modular.get<DiscountDetailController>()
        .getDescounts(id: Modular.args.data).then((value) {
          swicthValue=value.actived!;
          _discountsModel=value;
          return value;});
  }

  @override
  Widget build(BuildContext context) {
    return  PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        Modular.to.navigate('/');
      },
      child: Material(
        child: Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
              child: FilledButton(
                onPressed: () {
                  Modular.to.navigate("/addDiscounts",arguments: ArgsModel(ActionEnum.edit,discountsModel:  _discountsModel ));
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 16)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(const Color(0xFF007FBA)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                child: Text(
                  "Editar desconto",
                  style: GoogleFonts.rubik(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: InkWell(
                  child: SvgPicture.string(
                    arrow,
                  ),
                  onTap: () {
                    Modular.to.navigate("/");
                  },
                ),
              ),
              title: Text("Detalhe do desconto",
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    color: Color(0xFF403E43),
                    fontWeight: FontWeight.w700,
                  )),
              surfaceTintColor: Colors.white,
              elevation: 1,
              shadowColor: Color(0xFF007FBA),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                      future: data,
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Switch(
                                      value: swicthValue,
                                      activeColor: Color(0xFF007FBA),
                                      onChanged: (v) async{
                                        setState(() {
                                          swicthValue = v;
                                        });
                                        snapshot.data!.actived=v;
                                        await controller.updateDescountSwicthValue(discountsModel: snapshot.data!);
                                      })
                                
                              ],
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFCFD8DC), width: 0.5),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Image.network(
                                  snapshot.data!.imageUrl!,
                                  fit: BoxFit.scaleDown,
                                  height: MediaQuery.of(context).size.width * 0.5,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            snapshot.data!.type ==
                                    TypeDiscountEnum.levemaispaguemenos
                                ? textLevePague(
                                    takeQuant: snapshot.data!.takeQuantity!,
                                    buyQuant: snapshot.data!.buyQuantity!,
                                    price: snapshot.data!.price!)
                                : snapshot.data!.type ==
                                        TypeDiscountEnum.percentual
                                    ? textPercentual(
                                        percentageDiscount:
                                            snapshot.data!.percentageDiscount!,
                                        price: snapshot.data!.price!)
                                    : snapshot.data!.type ==
                                            TypeDiscountEnum.precodeprecopor
                                        ? textDePor(
                                            priceFor: snapshot.data!.priceFor!,
                                            priceOf: snapshot.data!.priceOf!)
                                        : Container(),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(snapshot.data!.title!,
                                style: GoogleFonts.rubik(
                                  fontSize: 16,
                                  color: const Color(0xFF403E43),
                                  fontWeight: FontWeight.w700,
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(snapshot.data!.description!,
                                style: GoogleFonts.rubik(
                                  fontSize: 14,
                                  color: const Color(0xFF565656),
                                  fontWeight: FontWeight.w400,
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        );
                      }),
                ),
              ),
            )),
      ),
    );
  }

  Widget textLevePague(
      {required int takeQuant, required int buyQuant, required double price}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(2.47),
          decoration: BoxDecoration(
              color: Color(0xFF007FBA),
              borderRadius: BorderRadius.circular(2.47)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Leve $takeQuant',
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                width: 4,
              ),
              Text('Pague $buyQuant',
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Color(0xff007FBA), borderRadius: BorderRadius.circular(2)),
          child: Text("R\$ $price",
              style: GoogleFonts.rubik(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              )),
        ),
      ],
    );
  }

  Widget textPercentual(
      {required double percentageDiscount, required double price}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(2.47),
          decoration: BoxDecoration(
              color: Color(0xFF007FBA),
              borderRadius: BorderRadius.circular(2.47)),
          child: Text('$percentageDiscount% Desconto',
              style: GoogleFonts.rubik(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              )),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(2.47),
              decoration: BoxDecoration(
                  color: Color(0xFF007FBA),
                  borderRadius: BorderRadius.circular(2.47)),
              child: Text(
                  "R\$ ${controller.percentCalcDescount(percent: percentageDiscount, number: price)}",
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            const SizedBox(
              width: 4,
            ),
            Text("R\$ $price",
                style: GoogleFonts.rubik(
                  fontSize: 14,
                  color: Color(0xff403E43),
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.lineThrough,
                )),
          ],
        ),
      ],
    );
  }

  Widget textDePor({required double priceOf, required double priceFor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(2.47),
          decoration: BoxDecoration(
              color: Color(0xFF007FBA),
              borderRadius: BorderRadius.circular(2.47)),
          child: Text(
              'Economize R\$ ${controller.diffCalcDescount(priceFor: priceFor, priceOf: priceOf)}',
              style: GoogleFonts.rubik(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              )),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(2.47),
              decoration: BoxDecoration(
                  color: Color(0xFF007FBA),
                  borderRadius: BorderRadius.circular(2.47)),
              child: Text("R\$ $priceFor",
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            const SizedBox(
              width: 4,
            ),
            Text("R\$ $priceOf",
                style: GoogleFonts.rubik(
                  fontSize: 14,
                  color: Color(0xff403E43),
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.lineThrough,
                )),
          ],
        ),
      ],
    );
  }
}
