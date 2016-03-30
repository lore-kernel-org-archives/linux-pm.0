From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v2] thermal: add sysfs_notify on some attributes
Date: Wed, 30 Mar 2016 15:45:35 +0000
Message-ID: <1459352752.13525.51.camel@intel.com>
References: <1457979156-10972-1-git-send-email-srikars@nvidia.com>
	 <1458079520.4486.39.camel@intel.com>
	 <20160329013540.GA15615@localhost.localdomain>
	 <56FB3FB4.1010308@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63918 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753990AbcC3Ppj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Mar 2016 11:45:39 -0400
In-Reply-To: <56FB3FB4.1010308@nvidia.com>
Content-Language: en-US
Content-ID: <F3FDDD0AD377414FB3A263428AED6557@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "edubezval@gmail.com" <edubezval@gmail.com>, "srikars@nvidia.com" <srikars@nvidia.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "mlongnecker@nvidia.com" <mlongnecker@nvidia.com>

T24gVHVlLCAyMDE2LTAzLTI5IGF0IDE5OjUzIC0wNzAwLCBTcmlrYXIgU3JpbWF0aCBUaXJ1bWFs
YSB3cm90ZToNCj4gT24gMDMvMjgvMjAxNiAwNjozNSBQTSwgRWR1YXJkbyBWYWxlbnRpbiB3cm90
ZToNCj4gPiANCj4gPiBPbiBUdWUsIE1hciAxNSwgMjAxNiBhdCAxMTowODowMFBNICswMDAwLCBQ
YW5kcnV2YWRhLCBTcmluaXZhcw0KPiA+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBNb24sIDIw
MTYtMDMtMTQgYXQgMTE6MTIgLTA3MDAsIFNyaWthciBTcmltYXRoIFRpcnVtYWxhIHdyb3RlOg0K
Wy4uLl0NCj4gPiBJIGhhdmUgY3JlYXRlZCBhIHdpa2kgZm9yIExQQyAyMDE2DQo+ID4gaHR0cDov
L3dpa2kubGludXhwbHVtYmVyc2NvbmYub3JnLzIwMTY6dGhlcm1hbA0KPiA+IA0KPiA+IE92ZXJh
bGwgSSBiZWxpZXZlIHdlIG5lZWQgdG8gc29sdmUgdGhlICh0ZW1wZXJhdHVyZSkgc2Vuc2luZyBp
biBhDQo+ID4gbW9yZQ0KPiA+IHN0cnVjdHVyZWQgd2F5IHdpdGhpbiB0aGUga2VybmVsLiBXZSBo
YXZlIHRocmVlIHN1YnN5c3RlbSB0aGF0DQo+ID4gYWxsb3cNCj4gPiBwZXJmb3JtaW5nIHRlbXBl
cmF0dXJlIHNlbnNpbmcuIFRoZXkgYXJlIGRpZmZlcmVudCBpbiBkZXNpZ24gYW5kDQo+ID4gY29u
Y2VwdCwgYnV0IHN0aWxsIHNvbHZlIHNpbWlsYXIgcHJvYmxlbXMuDQo+ID4gDQo+IEkgd2VudCB0
aHJvdWdoIHRoZSBMUEMgcHJlc2VudGF0aW9uL3BhdGNoZXMgYW5kIGhhZCBhIGNvdXBsZSBvZg0K
PiBxdWVzdGlvbnMuDQo+IA0KPiBUaGUgdGhlcm1hbCBpaW8gZGV2aWNlIHNlZW1zIHBlcmZlY3Rs
eSBzdWl0ZWQgZm9yIHNlbmRpbmcgbGFyZ2UNCj4gYW1vdW50c8KgDQo+IG9mIHRoZXJtYWwgZGF0
YSBmcm9tIHRoZSBrZXJuZWwgZnJhbWV3b3JrIHRvIHVzZXIgc3BhY2UuIEFyZSB0aGVyZSBhDQo+
IGxvdMKgDQo+IG9mIHBsYXRmb3JtcyB3aGVyZSB0aGVybWFsIHRocm90dGxpbmcgaGFwcGVucyBp
biB1c2VyIHNwYWNlPw0KWWVzLsKgDQoNCj4gIElmIHNvLCBJc8KgDQo+IHRoaXMgYW4gaW5kaWNh
dGlvbiB0aGF0IHBhc3NpdmUgdGhlcm1hbCB0aHJvdHRsaW5nIGlzIGdvaW5nIGludG8gdGhlwqAN
Cj4gdXNlciBzcGFjZSBzb21lIHRpbWUgaW4gdGhlIGZ1dHVyZT8NCk5vdCByZWFsbHkuIEtlcm5l
bCB0YWtlcyBjYXJlIGFib3V0IG1vcmUgaW1tZWRpYXRlL3VyZ2VudCBuZWVkcy4gVXNlcg0Kc3Bh
Y2UgaXMgbW9yZSBhYm91dCBsb25nIHRlcm0gY29udHJvbCwgd2hlcmUgeW91IHdpbGwgcHJldmVu
dA0KYWdncmVzc2l2ZSBjb250cm9scyBmcm9tIGtlcm5lbC4NCg0KVGhhbmtzLA0KU3Jpbml2YXMN
Cg==
