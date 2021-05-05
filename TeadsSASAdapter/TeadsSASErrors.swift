//
//  TeadsSASErrors.swift
//  TeadsSASAdapter
//
//  Created by Jérémy Grosjean on 09/11/2020.
//

import UIKit

struct TeadsSASErrors {

    static let noPidError = NSError(domain: "noPidError", code: 400, userInfo: [ NSLocalizedDescriptionKey: NSLocalizedString("noPidError", value: "PlacementId needs to be provided in server parameters", comment: "") ,
                                                                          NSLocalizedFailureReasonErrorKey: NSLocalizedString("noPidError", value: "PlacementId needs to be provided in server parameters", comment: "")
                                                                  ])

    static let serverParameterError = NSError(domain: "JsonError", code: 401, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("JsonError", value: "serverParameterString is not a jSON", comment: "") ,
                                                                                               NSLocalizedFailureReasonErrorKey: NSLocalizedString("JsonError", value: "serverParameterString is not a jSON", comment: "")
                                                                                       ])

    static let noFillError = NSError(domain: "noFill", code: 402, userInfo: [ NSLocalizedDescriptionKey: NSLocalizedString("noFill", value: "Teads ad server did not return an ad", comment: "") ,
                                                                       NSLocalizedFailureReasonErrorKey: NSLocalizedString("noFill", value: "Teads ad server did not return an ad", comment: "")])
}
