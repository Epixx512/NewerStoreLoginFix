#import <Foundation/Foundation.h>

@interface NewerStoreLoginFixProtocol : NSURLProtocol
@end

@implementation NewerStoreLoginFixProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
	if ([NSURLProtocol propertyForKey:@"NewerStoreLoginFixHandled" inRequest:request]) return NO;
	if ([request.HTTPMethod isEqualToString:@"POST"] && [request.URL.host hasSuffix:@"buy.itunes.apple.com"] && [request.URL.path isEqualToString:@"/WebObjects/MZFinance.woa/wa/authenticate"]) return YES;
	return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
	return request;
}

- (void)startLoading {
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[queue addOperationWithBlock:^{
		NSURL *url = self.request.URL;
		NSMutableURLRequest *newReq = [self.request mutableCopy];
		if ([self.request.HTTPMethod isEqualToString:@"POST"] && [url.host hasSuffix:@"buy.itunes.apple.com"] && [url.path isEqualToString:@"/WebObjects/MZFinance.woa/wa/authenticate"]) {
			NSString *newURLString = [url.absoluteString stringByAppendingString:@"/"];
			newReq.URL = [NSURL URLWithString:newURLString];
		}
		NSURLResponse *response = nil;
		NSError *error = nil;
		[NSURLProtocol setProperty:[NSNumber numberWithBool:YES] forKey:@"NewerStoreLoginFixHandled" inRequest:newReq];
		NSData *data = [NSURLConnection sendSynchronousRequest:newReq returningResponse:&response error:&error];
		if (error) {
			[self.client URLProtocol:self didFailWithError:error];
			return;
		}
		[self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
		[self.client URLProtocol:self didLoadData:data];
		[self.client URLProtocolDidFinishLoading:self];
	}];
}

- (void)stopLoading {
}

@end

%ctor {
	[NSURLProtocol registerClass:[NewerStoreLoginFixProtocol class]];
}