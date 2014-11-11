From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: RE: [PATCH 2/3] power: core: Add variables related temperature to
 power_supply_info.
Date: Tue, 11 Nov 2014 04:56:31 +0000
Message-ID: <20ADAB092842284E95860F279283C5642EDB8431@BGSMSX104.gar.corp.intel.com>
References: <1412679518-21499-1-git-send-email-jonghwa3.lee@samsung.com>
 <1412679518-21499-3-git-send-email-jonghwa3.lee@samsung.com>
 <20ADAB092842284E95860F279283C5642ED9EDE3@BGSMSX104.gar.corp.intel.com>
 <546158A0.5000707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43505 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbaKKE4h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 10 Nov 2014 23:56:37 -0500
In-Reply-To: <546158A0.5000707@samsung.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "jonghwa3.lee@samsung.com" <jonghwa3.lee@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "anton@enomsg.org" <anton@enomsg.org>, "pavel@ucw.cz" <pavel@ucw.cz>

PiA+IFRoZSBDQyxDViBhbmQgcmVzdGFydCB0aHJlc2hvbGQgd291bGQgdmFyeSBiYXNlZCBvbiB0
aGUgYmF0dGVyeSB0ZW1wZXJhdHVyZQ0KPiA+IFNvIEkgd291bGQgc3VnZ2VzdCB0byBoYXZlIHRl
bXBlcmF0dXJlIHpvbmUgdGFibGUgYXMgcGFydCAgb2YgYmF0dGVyeSBpbmZvDQo+ID4gYWxvbmcg
d2l0aCBvdGhlciBhdHRyaWJ1dGVzLg0KPiA+DQo+ID4gaW50IGl0ZXJtOyAvL2NoYXJnZSB0ZXJt
aW5hdGlvbiBjdXJyZW50ICh1c2VkIHRvIHN0b3AgY2hhcmdpbmcpDQo+ID4gaW50IHRlbXBfem9u
ZV9jb3VudDsgLy8gbnVtYmVyIG9mIHRlbXBlcmF0dXJlIHpvbmUgdGFibGVzIHByZXNlbnQNCj4g
PiBzdHJ1Y3QgYmF0dF90ZW1wX21vbl90YWJsZSB0ZW1wX21vbl90YmxbTUFYX1RFTVBfTU9OX1RB
QkxFXTsNCj4gLy90ZW1wZXJhdHVyZSB6b25lIHRhYmxlIGFycmF5DQo+ID4NCj4gPiBzdHJ1Y3Qg
IGJhdHRfdGVtcF9tb25fdGFibGUgew0KPiA+IAkgc2hvcnQgaW50IHRlbXBfbWF4Ow0KPiA+IAkg
c2hvcnQgaW50IGNjOw0KPiA+IAkgc2hvcnQgaW50IGN2Ow0KPiA+IAkgc2hvcnQgaW50IHZiYXRf
dmNoa19kcm9wX3V2Ow0KPiA+IAkgc2hvcnQgaW50IHRlbXBfbWluOw0KPiA+IH07DQo+ID4NCj4g
DQo+IA0KPiBJTU8sIHRocm90dGxpbmcgY2MvY3YgYWNjb3JkaW5nIHRoZSB0ZW1wZXJhdHVyZSBj
YW4gYmUgZG9uZSB2aWEgdGhlcm1hbCBmdw0KPiBpbnRlcmZhY2UuIEhvd2V2ZXIgdm9sdGFnZSBk
cm9wIGFuZCBjaGFyZ2luZyB0ZXJtaW5hdGlvbiBjdXJyZW50IGNhbiBiZSBhZGRlZCBoZXJlLg0K
DQpUaGUgQ0MvQ1YgZm9yIGVhY2ggYmF0dGVyeSB0ZW1wZXJhdHVyZSB6b25lIGlzIGRlZmluZWQg
YXMgcGFydCBvZiBiYXR0ZXJ5IHNwZWMuIFRoaXMgaXMNCmFzIHBlciB0aGUgSkVJVEEvUFNFIHN0
YW5kYXJkcy4gU28gSU1PLCB0aGlzIGlzIGEgYmF0dGVyeSBjaGFyZ2luZyBpbmZvcm1hdGlvbg0K
KGNoYXJnaW5nIG9iamVjdCkgcmF0aGVyIHRoYW4gYSB0aGVybWFsIHRocm90dGxpbmcgaW5mb3Jt
YXRpb24uDQoNCkFsc28gdGhlIGJhdHRlcnkgaW5mb3JtYXRpb24gbWF5IG5vdCBmaXQgaW50byBh
IHN0YW5kYXJkIGZvcm1hdC4gRGlmZmVyZW50IHN0YW5kYXJkcyBoYXZlDQpkaWZmZXJlbnQgZm9y
bWF0IGZvciBjaGFyZ2luZyBvYmplY3QuIFNvIEkgd291bGQgc3VnZ2VzdCB0byBtYWtlIGl0IGZs
ZXhpYmxlIGVub3VnaCB0bw0Kc3VwcG9ydCBkaWZmZXJlbnQgY2hhcmdpbmcgb2JqZWN0IGZvcm1h
dC4gRm9yIGV4YW1wbGUgTUlQSSBCSUYgY2hhcmdpbmcgb2JqZWN0IGZvcm1hdA0KKGh0dHBzOi8v
bWVtYmVycy5taXBpLm9yZy93Zy9CSUYvZG9jdW1lbnQvMTE1MTgpIGFuZCBNSVBJIEJJRiBSdWxl
IGJhc2VkIGNoYXJnaW5nIGFsZ29yaXRobQ0KKGh0dHA6Ly9taXBpLm9yZy9zaXRlcy9kZWZhdWx0
L2ZpbGVzL21pcGlfQklGX3J1bGUtYmFzZWQtY2hhcmdpbmdfd2hpdGUtcGFwZXJfMS5wZGYpDQpo
YXMgZGlmZmVyZW50IGNoYXJnaW5nIG9iamVjdCBmb3JtYXQuIFRoaXMgaXMgd2h5IHRoZSBwYXRj
aCAgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTQvOC8xMy8zNTUNCmhhcyBvcHRpb24gdG8gc3Vw
cG9ydCBkaWZmZXJlbnQgY2hhcmdpbmcgb2JqZWN0cyBhbmQgZGlmZmVyZW50IGNoYXJnaW5nIGFs
Z29yaXRobXMuDQoNCi1KZW5ueQ0K
