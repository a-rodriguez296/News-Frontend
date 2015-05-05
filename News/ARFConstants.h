//
//  ARFConstants.h
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#ifndef News_ARFConstants_h
#define News_ARFConstants_h

//Macros
#define _ME_WEAK __weak typeof(self) me = self;


//Constante NSString
static NSString* const kBooksUrl                      = @"Hola";


//Constante integer
static const NSUInteger kAutoSave = 5;


//Constantes ARFNewsEntity
static NSString* const kNewsEntityName = @"NewsEntity";
static NSString* const kNewsEntityTitle = @"title";
static NSString* const kNewsEntityText = @"text";
static NSString* const kNewsEntityAuthor = @"user";
static NSString* const kNewsEntityPhoto = @"photo";
static NSString * const kNewsEntityGeopoint = @"geopoint";

//Constantes ARFScore
static NSString* const kScoreEntityName = @"Score";
static NSString* const kScoreEntityScore = @"score";
static NSString* const kScoreEntityNew = @"newsEntity";


//Constantes ARFUser
static NSString* const kUserEntityName = @"User";

//Enum para el estado de una noticia
typedef enum {
    kNewsEntityUnpublished,
    kNewsEntityPublished,
    
} kNewsEntityState;


//Enum para saber que tipo de feed quiere el usuario
typedef enum{
    kGlobalFeed,
    kMyPublishedNewsFeed,
    kMyUnpublishedNewsFeed,
}kFeedType;


#endif
