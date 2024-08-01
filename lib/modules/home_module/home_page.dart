import 'package:cresce_cuts/core/enums/action_enum.dart';
import 'package:cresce_cuts/core/models/args_model.dart';
import 'package:cresce_cuts/core/models/discounts_model.dart';
import 'package:cresce_cuts/modules/home_module/componentes/card_product.dart';
import 'package:cresce_cuts/modules/home_module/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<DiscountsModel>> data;
  final controller =Modular.get<HomeController>();
  @override
  void initState() {
    super.initState();
    data = controller.getDescounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
          child: FilledButton(
            onPressed: () {
              Modular.to.navigate("/addDiscounts",arguments: ArgsModel(ActionEnum.create));
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
              "Cadastrar desconto",
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
          title: Text("Descontos",
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
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
                future: data,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  return ListView.separated(
                      itemBuilder: (_, i) {
                        return CardProduct(
                          discountsModel: snapshot.data![i],
                          onTap: () {
                            Modular.to.navigate("/discountDetail",
                                arguments: snapshot.data![i].id);
                          },
                          initialSwitchValue: snapshot.data![i].actived!,
                          onSwicthChanged: (value) async{
                            snapshot.data![i].actived=value;
                            await controller.updateDescountSwicthValue( discountsModel: snapshot.data![i], );
                          },
                        );
                      },
                      separatorBuilder: (_, i) {
                        return const SizedBox(
                          height: 16,
                        );
                      },
                      itemCount: snapshot.data!.length);
                }),
          ),
        ));
  }
}
