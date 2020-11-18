//
//  TeadsSASBannerAdapter.swift
//  TeadsSASAdapter
//
//  Created by Jérémy Grosjean on 29/10/2020.
//

import UIKit
import SASDisplayKit
import TeadsSDK

@objc open class TeadsSASBannerAdapter: NSObject, SASMediationBannerAdapter {
    
    @objc public weak var delegate: SASMediationBannerAdapterDelegate?
    public var teadsAdView: TFACustomAdView?
    weak var controller: UIViewController?
    @objc required public init(delegate: SASMediationBannerAdapterDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    @objc public func requestBanner(withServerParameterString serverParameterString: String, clientParameters: [AnyHashable : Any], viewController: UIViewController) {
        controller = viewController
        guard let data = serverParameterString.data(using: .utf8), let parametersDict = try? JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any> else {
            
            delegate?.mediationBannerAdapter(self, didFailToLoadWithError: TeadsSASErrors.serverParameterError, noFill: false)

            return
        }
        
        guard let placementId = parametersDict["placementId"] as? Int else {
            delegate?.mediationBannerAdapter(self, didFailToLoadWithError: TeadsSASErrors.noPidError, noFill: false)
            return
        }
        
        let adSettings = TeadsSASAdapterHelper.stringToAdSettings(adSettingsString: parametersDict["teadsAdSettingsKey"] as? String)
        
        
         let SASVersion = Bundle.init(for: SASAdPlacement.self).infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
        
        let adViewSize = clientParameters["adViewSize"] as? CGSize ?? viewController.view.bounds.size
        teadsAdView = TFACustomAdView(withPid: placementId, andDelegate: self)
        teadsAdView?.addContextInfo(infoKey: TeadsAdSettings.integrationTypeKey, infoValue: TeadsAdSettings.integrationSAS)
        teadsAdView?.addContextInfo(infoKey: TeadsAdSettings.integrationVersionKey, infoValue: SASVersion)
      
        teadsAdView?.frame = CGRect(x: 0, y: 0, width: adViewSize.width, height: 250)

        teadsAdView?.load(teadsAdSettings: adSettings)
    }
}

extension TeadsSASBannerAdapter: TFAAdDelegate {
    
    public func didReceiveAd(_ ad: TFAAdView, adRatio: CGFloat) {
        delegate?.mediationBannerAdapter(self, didLoadBanner: ad)
        if let adView = teadsAdView {
            adView.frame.size = CGSize(width: adView.bounds.width, height: adView.bounds.width/adRatio)
        }
    }
    
    public func didFailToReceiveAd(_ ad: TFAAdView, adFailReason: AdFailReason) {
        delegate?.mediationBannerAdapter(self, didFailToLoadWithError: TeadsSASErrors.noFillError, noFill: true)
    }
    
    public func adClose(_ ad: TFAAdView, userAction: Bool) {
        teadsAdView?.frame.size.height = 0
    }
    
    public func adError(_ ad: TFAAdView, errorMessage: String) {
        teadsAdView?.frame.size.height = 0
    }
    
    public func didUpdateRatio(_ ad: TFAAdView, ratio: CGFloat) {
        if let adView = teadsAdView {
            adView.frame.size.height = adView.bounds.width/ratio
        }
    }
    
    public func adBrowserWillOpen(_ ad: TFAAdView) -> UIViewController? {
        return controller
    }
}
