//
//  EventsAPI+Result.swift
//  CocoaHeadsMobile
//
//  Created by Jesse Collis on 13/4/17.
//  Copyright © 2017 Melbourne CocoaHeads. All rights reserved.
//

import CocoaHeadsAPIClient

typealias EventsResponse = InlineResponse200
typealias EventResponse = InlineResponse2001

extension EventsAPI {
    class func getEvents(completion: @escaping ((_ result: Result<EventsResponse>) -> Void)) {
        getEvents { response, error in
            //FIXME: JC - there is one case where we can receive nil response and nil error
            completion(Result(response, failWith: error!))
        }
    }

    //TODO: Add the same for the getEvent endpoint
}
