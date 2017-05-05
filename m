From: "Li, Fei" <fei.li@intel.com>
Subject: RE: [PATCH V3] cpuidle: check dev before usage in
 cpuidle_use_deepest_state
Date: Fri, 5 May 2017 01:53:24 +0000
Message-ID: <BEC9F67575FA1E429CA7CF5AE9BE363432A46AF9@SHSMSX104.ccr.corp.intel.com>
References: <BEC9F67575FA1E429CA7CF5AE9BE363432A46913@SHSMSX104.ccr.corp.intel.com>
 <20170504101608.GA5252@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:60258 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752585AbdEEBxa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 May 2017 21:53:30 -0400
In-Reply-To: <20170504101608.GA5252@mai>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Shi, FengX" <fengx.shi@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>

T24gVGh1cnNkYXksIE1heSA0LCAyMDE3IDY6MTYgUE0gRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+
ID4NCj4gPiAgICAgcHJlZW1wdF9kaXNhYmxlKCk7DQo+ID4gICAgIGRldiA9IGNwdWlkbGVfZ2V0
X2RldmljZSgpOw0KPiA+IC0gICBkZXYtPnVzZV9kZWVwZXN0X3N0YXRlID0gZW5hYmxlOw0KPiA+
ICsgICBpZiAoZGV2KQ0KPiA+ICsgICAgICAgZGV2LT51c2VfZGVlcGVzdF9zdGF0ZSA9IGVuYWJs
ZTsNCj4gDQo+IA0KPiBUaGlzIGNoYW5nZSBpcyBhY2NlcHRhYmxlIGFzIGEgaG90IGZpeCBidXQg
dGhlIHF1ZXN0aW9uIGlzICd3aHkgaXMgdGhpcw0KPiBmdW5jdGlvbiBjYWxsZWQgaWYgdGhlcmUg
aXMgbm8gY3B1aWRsZSBkcml2ZXIgcmVnaXN0ZXJlZD8nDQoNCkl0J3MgY2FsbGVkIGFzIGJlbG93
Og0KY2xhbXBfaWRsZV9pbmplY3Rpb25fZnVuYw0KCS0+IHBsYXlfaWRsZQ0KCQktPiBjcHVpZGxl
X3VzZV9kZWVwZXN0X3N0YXRlDQpJbiBwbGF5X2lkbGUsIGlmIG5vIGNwdWlkbGUgZHJpdmVyIHJl
Z2lzdGVyZWQsIGNwdV9pZGxlX3BvbGwgY2FuIGJlIGNhbGxlZC4NCkl0IHNlZW1zIHRvIGdvIHRv
byBmYXIgaWYgbm90IGNhbGxpbmcgcGxheV9pZGxlIGluIGNhc2Ugb2Ygbm8gY3B1aWRsZSBkcml2
ZXINCnJlZ2lzdGVyZWQuDQpBdCBwcmVzZW50IG5vIG90aGVyIHN1aXRhYmxlIGFuZCBzaW1wbGUg
Zml4IHNlZW4uDQoNCj4gDQo+ID4gICAgIHByZWVtcHRfZW5hYmxlKCk7DQo+ID4gIH0NCj4gPg0K
PiA+IC0tDQo+ID4gMS45LjENCj4gPg0KPiA+IEJlc3QgUmVnYXJkcywNCj4gPiBGZWkNCj4gDQo+
IC0tDQo+IA0KPiAgPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4g
c291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiANCj4gRm9sbG93IExpbmFybzogIDxodHRw
Oi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwNCj4gPGh0dHA6Ly90
d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfA0KPiA8aHR0cDovL3d3dy5saW5hcm8u
b3JnL2xpbmFyby1ibG9nLz4gQmxvZw0KDQpCZXN0IFJlZ2FyZHMsDQpGZWkNCg==
