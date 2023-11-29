import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchases_interface/in_app_purchases_interface.dart';
import 'package:in_app_purchases_paywall_ui/locale_text.dart';
import 'package:in_app_purchases_paywall_ui/paywall/inherit/subscription_callback_iw.dart';
import 'package:responsive_spacing/responsive_spacing.dart';

/// Price Box to show subscriptions
class SubscriptionPriceBox extends StatelessWidget {
  final SubscriptionData data;
  final bool shouldBreakText;
  final int mx;

  const SubscriptionPriceBox(this.data, this.shouldBreakText, {this.mx = 1, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Ink(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)), color: Theme.of(context).colorScheme.primary),
            child: InkWell(
                onTap: () {
                  SubscriptionCallbackIW.of(context)?.onPurchase(data);
                },
                child: Padding(
                    padding: EdgeInsets.all(1),
                    child: Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            color: Theme.of(context).colorScheme.primaryContainer),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, context.spacing.xl, 0, context.spacing.xl),
                                child: Column(
                                  children: [
                                    LocaleText(
                                      data.durationTitle,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(context.spacing.s),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: context.spacing.m, right: context.spacing.m),
                                      child: AutoSizeText(
                                        "${data.price}",
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: context.spacing.m, right: context.spacing.m),
                                      child: LocaleText(
                                        "per ${data.durationShort.replaceAll(" ", "\u{00A0}")}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            data.dealPercentage > 0
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                        color: Theme.of(context).colorScheme.tertiary),
                                    child: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: LocaleText(
                                        "-${data.dealPercentage}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.apply(color: Theme.of(context).colorScheme.onTertiary),
                                      ),
                                    ))
                                : Container(),
                          ],
                        ))))));
  }
}
