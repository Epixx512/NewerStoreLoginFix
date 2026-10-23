#import <Foundation/Foundation.h>

%hook ISURLBag

- (id)valueForKey:(NSString *)key {
	id value = %orig;
	if ([key isEqualToString:@"authenticateAccount"] && [value isKindOfClass:[NSString class]] && ![value hasSuffix:@"/"]) {
		return [value stringByAppendingString:@"/"];
	}
	return value;
}

- (NSURL *)urlForKey:(NSString *)key {
	if ([key isEqualToString:@"authenticateAccount"]) {
		id value = [(id)self valueForKey:key];
		return [value isKindOfClass:[NSString class]] ? [NSURL URLWithString:value] : nil;
	}
	return %orig;
}

%end