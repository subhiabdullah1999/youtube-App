import 'package:google_mobile_ads/google_mobile_ads.dart';

InterstitialAd? interstitialAd;
RewardedAd? rewardedAd;

//////////InterstitialAd/////////////////
Future<void> createInterstitialAd() async {
  // await InterstitialAd.load(
  //     adUnitId: 'ca-app-pub-4605716348832015/2729303176',
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (InterstitialAd ad) {
  //         print('$ad loaded');
  //         interstitialAd = ad;
  //         // _numInterstitialLoadAttempts = 0;
  //         interstitialAd!.setImmersiveMode(true);
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         print('InterstitialAd failed to load: $error.');
  //         // _numInterstitialLoadAttempts += 1;
  //         interstitialAd = null;
  //         // if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
  //         //   _createInterstitialAd();
  //         // }
  //       },
  //     ));
}

////////////////InterstitialAd///////////////////
void showInterstitialAd() {
  // if (interstitialAd == null) {
  //   print('Warning: attempt to show interstitial before loaded.');
  //   return;
  // }

  // interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //   onAdShowedFullScreenContent: (InterstitialAd ad) =>
  //       print('ad onAdShowedFullScreenContent.'),
  //   onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //     print('$ad onAdDismissedFullScreenContent.');
  //     ad.dispose();
  //     createInterstitialAd();
  //   },
  //   onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //     print('$ad onAdFailedToShowFullScreenContent: $error');
  //     ad.dispose();
  //     createInterstitialAd();
  //   },
  // );
  // interstitialAd!.show();
  // interstitialAd = null;
}

///
//////////////////////createRewardedAd/////////////////////////
Future<void> createRewardedAd() async {
  // RewardedAd.load(
  //     adUnitId: 'ca-app-pub-4605716348832015/6957959274',
  //     request: const AdRequest(),
  //     rewardedAdLoadCallback: RewardedAdLoadCallback(
  //       onAdLoaded: (RewardedAd ad) {
  //         print('$ad loaded.');
  //         rewardedAd = ad;
  //         // _numRewardedLoadAttempts = 0;
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         print('RewardedAd failed to load: $error');
  //         rewardedAd = null;
  //         // _numRewardedLoadAttempts += 1;
  //         // if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
  //         //   _createRewardedAd();
  //         // }
  //       },
  //     ));
}

void showRewardedAd() {
  // if (rewardedAd == null) {
  //   print('Warning: attempt to show rewarded before loaded.');
  //   return;
  // }
  // rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
  //   onAdShowedFullScreenContent: (RewardedAd ad) =>
  //       print('ad onAdShowedFullScreenContent.'),
  //   onAdDismissedFullScreenContent: (RewardedAd ad) {
  //     print('$ad onAdDismissedFullScreenContent.');
  //     ad.dispose();
  //     createRewardedAd();
  //   },
  //   onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
  //     print('$ad onAdFailedToShowFullScreenContent: $error');
  //     ad.dispose();
  //     createRewardedAd();
  //   },
  // );

  // rewardedAd!.setImmersiveMode(true);
  // rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
  //   print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
  // });
  // rewardedAd = null;
}

  ///
  /////////////////////////////////////////////
