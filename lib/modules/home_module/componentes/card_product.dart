import 'package:cresce_cuts/core/const/icons_svg.dart';
import 'package:cresce_cuts/core/models/discounts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CardProduct extends StatefulWidget {
  final DiscountsModel discountsModel;
  final Function onTap;
  final bool initialSwitchValue;
  final Function(bool value) onSwicthChanged;
  const CardProduct(
      {required this.onSwicthChanged,
      required this.initialSwitchValue,
      required this.discountsModel,
      required this.onTap,
      super.key});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  late bool activeSwitch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeSwitch=widget.initialSwitchValue;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCFD8DC), width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Switch(
                        value: activeSwitch,
                        activeColor: Color(0xFF007FBA),
                        onChanged: (c) {
                          setState(() {
                            activeSwitch = c;
                          });
                          widget.onSwicthChanged.call(c);
                        }),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFFCFD8DC), width: 0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Image.network(
                            widget.discountsModel.imageUrl!,
                            fit: BoxFit.scaleDown,
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.discountsModel.title!,
                                            style: GoogleFonts.rubik(
                                              fontSize: 14,
                                              color: const Color(0xFF455A64),
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Desconto: ",
                                      style: GoogleFonts.rubik(
                                        fontSize: 14,
                                        color: const Color(0xFF455A64),
                                        fontWeight: FontWeight.w500,
                                      )),
                                  Expanded(
                                    child: Text(
                                        widget.discountsModel.type!.stringValue,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.rubik(
                                          fontSize: 14,
                                          color: const Color(0xFF455A64),
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Data ativação",
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: const Color(0xFF455A64),
                          fontWeight: FontWeight.w500,
                        )),
                    Text(
                        DateFormat.yMMMd()
                            .format(widget.discountsModel.dateActivation!),
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: const Color(0xFF455A64),
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Data Inativação",
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: const Color(0xFF455A64),
                          fontWeight: FontWeight.w500,
                        )),
                    Text(
                        DateFormat.yMMMd()
                            .format(widget.discountsModel.dateInactivation!),
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: const Color(0xFF455A64),
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(
            height: 0,
            color: Color(0xFF455A64),
            thickness: 0.2,
          ),
          InkWell(
            onTap: () => widget.onTap(),
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ver Desconto",
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: const Color(0xFF455A64),
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.string(
                      eye,
                      height: 16,
                      width: 16,
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
