import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicLinkController {
  void fetchLinkData(context) async {
    // FirebaseDynamicLinks.getInitialLInk does a call to firebase to get us the real link because we have shortened it.
    var link = await FirebaseDynamicLinks.instance.getInitialLink();

    // This link may exist if the app was opened fresh so we'll want to handle it the same way onLink will.
    handleLinkData(link);

    // This will handle incoming links if the application is already opened
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          handleLinkData(dynamicLink);
        },
        onError: (err) async {});

    await FirebaseDynamicLinks.instance.getInitialLink().then((value) {
      handleLinkData(value);
    });
  }

  void handleLinkData(PendingDynamicLinkData data) async {
    Uri uri = data?.link;
    if (uri != null) {
      final queryParams = uri.queryParameters;
      if (queryParams.length > 0) {
        ///-------> This is to check if user is logged in then direct them to the page else they will go to the default route which is the home page
        // await gShared("userID").then((value) async {
        ///-------> This is to check if user is logged in then direct them to the page else they will go to the default route which is the home page
        // if (value != null && value.isNotEmpty && value != '') {
        String routeN = uri.toString().split("/").last.split("?").first;
        Get.offNamed("/$routeN", arguments: queryParams);
        // navigateRoute("/$routeN", queryParams);
        // }
        // });
      }
    }
    uri = null;
  }

  Future<Uri> createDynamicLink(BuildContext context, String url,
      [String title, String desc, String imageUrl]) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // This should match firebase but without the username query param
      uriPrefix: 'https://qlb.page.link',
      // This can be whatever you want for the uri, https://yourapp.com/groupinvite?username=$userName
      link: Uri.parse('https://qlb.page.link/$url'),
      androidParameters: AndroidParameters(
        packageName: 'com.kcib.quelib',
        minimumVersion: 1,
      ),
      // Here is how you want it to appear on any site you put your generated link
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: desc,
        imageUrl: Uri.parse(imageUrl),
      ),
    );
    final link = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
      link,
      DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short),
    );
    return shortenedLink.shortUrl;
  }
}
