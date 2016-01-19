From: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Subject: RE: [PATCH 2/2] power: Add support for TI BQ24261 charger
Date: Tue, 19 Jan 2016 18:27:42 +0000
Message-ID: <D854C92F57B1B347B57E531E78D05EAD57A23CA0@BGSMSX104.gar.corp.intel.com>
References: <1446136455-20752-1-git-send-email-ramakrishna.pallala@intel.com>
	<1446136455-20752-3-git-send-email-ramakrishna.pallala@intel.com>
	<CAHp75Vde8ZFXZC9SzKSaXS8TThJd1u=+UMHPOiTWZvY1P4xKqw@mail.gmail.com>
	<D854C92F57B1B347B57E531E78D05EAD57A22F3D@BGSMSX104.gar.corp.intel.com>
 <CAHp75VcBAHg3trt45xVr6m9ppDyv+TSZEEVsWra3QVRWGKfC1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32672 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932862AbcASS1s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jan 2016 13:27:48 -0500
In-Reply-To: <CAHp75VcBAHg3trt45xVr6m9ppDyv+TSZEEVsWra3QVRWGKfC1g@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "Tc, Jenny" <jenny.tc@intel.com>, Andreas Dannenberg <dannenberg@ti.com>

PiBPbiBUdWUsIEphbiAxOSwgMjAxNiBhdCAzOjI2IEFNLCBQYWxsYWxhLCBSYW1ha3Jpc2huYQ0K
PiA8cmFtYWtyaXNobmEucGFsbGFsYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+PiBPbiBUaHUsIE9j
dCAyOSwgMjAxNSBhdCA2OjM0IFBNLCBSYW1ha3Jpc2huYSBQYWxsYWxhDQo+ID4+IDxyYW1ha3Jp
c2huYS5wYWxsYWxhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4+ID4gQWRkIG5ldyBjaGFyZ2VyIGRy
aXZlciBzdXBwb3J0IGZvciBUSSBCUTI0MjYxIGNoYXJnZXIgSUMuDQo+ID4+ID4NCj4gPj4gPiBU
SSBCUTI0MjYxIGNoYXJnZXIgZHJpdmVyIHJlbGllcyBvbiBleHRjb24gbm90aWZpY2F0aW9ucyB0
byBnZXQgdGhlDQo+ID4+ID4gY2hhcmdlciBjYWJsZSB0eXBlIGFuZCBiYXNlZCBvbiB0aGF0IGl0
IHdpbGwgc2V0IHRoZSBjaGFyZ2luZyBwYXJhbWV0ZXJzLg0KPiANCj4gPj4gPiArLyogQlEyNDI2
MSByZWdpc3RlcnMgKi8NCj4gPj4gPiArI2RlZmluZSBCUTI0MjYxX1NUQVRfQ1RSTDBfQUREUiAg
ICAgICAgICAgICAgICAweDAwDQo+ID4+ID4gKyNkZWZpbmUgQlEyNDI2MV9DVFJMX0FERFIgICAg
ICAgICAgICAgIDB4MDENCj4gPj4gPiArI2RlZmluZSBCUTI0MjYxX0JBVFRfVk9MX0NUUkxfQURE
UiAgICAgMHgwMg0KPiA+PiA+ICsjZGVmaW5lIEJRMjQyNjFfVkVORE9SX1JFVl9BRERSICAgICAg
ICAgICAgICAgIDB4MDMNCj4gPj4gPiArI2RlZmluZSBCUTI0MjYxX1RFUk1fRkNDX0FERFIgICAg
ICAgICAgMHgwNA0KPiA+PiA+ICsjZGVmaW5lIEJRMjQyNjFfVklORFBNX1NUQVRfQUREUiAgICAg
ICAweDA1DQo+ID4+ID4gKyNkZWZpbmUgQlEyNDI2MV9TVF9OVENfTU9OX0FERFIgICAgICAgICAg
ICAgICAgMHgwNg0KPiA+PiA+ICsNCj4gPj4gPiArI2RlZmluZSBCUTI0MjYxX1JFU0VUX0VOQUJM
RSAgICAgICAgICAgQklUKDcpDQo+ID4+ID4gKw0KPiA+Pg0KPiA+PiBNaWdodCBiZSBhIGdvb2Qg
aWRlYSB0byBwdXQgY29tbWVudCBsaW5lIHByZWNlZGVkIGVhY2ggZ3JvdXAgdG8gcmVmZXINCj4g
Pj4gd2hpY2ggcmVnaXN0ZXIgaXQgY292ZXJzLg0KPiA+IE9rLg0KPiA+DQo+ID4+DQo+ID4+ID4g
KyNkZWZpbmUgQlEyNDI2MV9GQVVMVF9NQVNLICAgICAgICAgICAgIEdFTk1BU0soMiwgMCkNCj4g
Pj4NCj4gPj4gRWl0aGVyIHVzZSBHRU5NQVNLIGluIGVhY2ggY2FzZSwgb3IgcHV0IHBsYWluIG51
bWJlci4NCj4gPj4NCj4gPiBPay4NCj4gDQo+IExvb2tpbmcgdG8geW91ciBkZWZpbml0aW9ucyBh
Z2FpbiBJIGNhbiBzYXkgdGhhdCBHRU5NQVNLIGlzIG1vcmUgcmVhZGFibGUuDQo+IFJlZ2FyZGlu
ZyB0byBCSVQoKSBtYWNybyB5b3UgaGF2ZSB0byBkbyBzbWFydCBjaG9pY2UgaW4gZWFjaCBjYXNl
IHNlcGFyYXRlbHkuDQoNCkkgZG9u4oCZdCBmZWVsIGNvbWZvcnRhYmxlIHRvIG1peCBHRU5NQVNL
IGFuZCBub3JtYWwgYml0IHNldHRpbmdzLiBJIHdpbGwganVzdCBzdGljayB0byBvbGQgZmFzaGlv
bmVkIHdheSA6LSkNCg0KVGhhbmtzLA0KUmFtDQo=
