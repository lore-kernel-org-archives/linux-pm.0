From: =?euc-kr?B?x9S47cHW?= <myungjoo.ham@samsung.com>
Subject: Re: Re: [PATCH] PM / devfreq: Fix out of bounds access of transition
 table array
Date: Wed, 26 Feb 2014 05:12:03 +0000 (GMT)
Message-ID: <19338058.266151393391521988.JavaMail.weblogic@epml02>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-arm-msm-owner@vger.kernel.org>
MIME-version: 1.0
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

PiBPbiAwMi8yMy8yMDE0IDExOjE1IFBNLCBTYXJhdmFuYSBLYW5uYW4gd3JvdGU6DQo+ID4gVGhl
IHByZXZpb3VzX2ZyZXEgdmFsdWUgZm9yIGEgZGV2aWNlIGNvdWxkIGJlIGFuIGludmFsaWQgZnJl
cXVlbmN5IHRoYXQNCj4gPiByZXN1bHRzIGluIGEgZXJyb3IgdmFsdWUgYmVpbmcgcmV0dXJuZWQg
ZnJvbSBkZXZmcmVxX2dldF9mcmVxX2xldmVsKCkuDQo+ID4gQ2hlY2sgZm9yIGFuIGVycm9yIHZh
bHVlIGJlZm9yZSB1c2luZyB0aGF0IHRvIGluZGV4IGludG8gdGhlIHRyYW5zaXRpb24NCj4gPiB0
YWJsZS4NCj4gPg0KPiA+IE5vdCBkb2luZyB0aGlzIGNoZWNrIHdpbGwgcmVzdWx0IGluIG1lbW9y
eSBjb3JydXB0aW9uIHdoZW4gcHJldmlvdXNfZnJlcSBpcw0KPiA+IG5vdCBhIHZhbGlkIGZyZXF1
ZW5jeS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhcmF2YW5hIEthbm5hbiA8c2thbm5hbkBj
b2RlYXVyb3JhLm9yZz4NCj4gDQo+IE15dW5nSm9vL0t5dW5nbWluLA0KPiANCj4gV291bGQgZWl0
aGVyIG9mIHlvdSBoYXZlIHNvbWUgdGltZSB0byByZXNwb25kIHRvIHRoaXM/DQo+IA0KPiBUaGFu
a3MsDQo+IFNhcmF2YW5hDQoNCkRlYXIgU2FyYXZhbmEsDQoNCj4gPiArCXByZXZfbGV2ID0gZGV2
ZnJlcV9nZXRfZnJlcV9sZXZlbChkZXZmcmVxLCBkZXZmcmVxLT5wcmV2aW91c19mcmVxKTsNCj4g
PiArCWlmIChwcmV2X2xldiA8IDApDQo+ID4gKwkJcmV0dXJuIDA7DQoNCklmIGRldmZyZXFfZ2V0
X2ZyZXFfbGV2ZWwgcmV0dXJuZWQgZXJyb3IsIHBsZWFzZSByZXR1cm4gdGhhdCBlcnJvcg0KdG8g
dGhlIGNhbGxlci4gWW91IGFyZSByZXR1bmluZyAwIGluIHRoYXQgY2FzZS4NCg0KUGx1cywgZG8g
eW91IHRoaW5rIHdlIGFyZSBnb2luZyB0byBjaGFuZ2UgcHJvZmlsZS0+ZnJlcV90YWJsZSBpbiBy
dW4tdGltZT8NCihieSBhY2NpZGVudGx5PyBvciBpbnRlbnRpb25hbGx5PykNCg0KQ2hlZXJzLA0K
TXl1bmdKb28uDQoNCj4gDQo+IA0KPiAtLSANCj4gVGhlIFF1YWxjb21tIElubm92YXRpb24gQ2Vu
dGVyLCBJbmMuIGlzIGEgbWVtYmVyIG9mIHRoZSBDb2RlIEF1cm9yYSBGb3J1bSwNCj4gaG9zdGVk
IGJ5IFRoZSBMaW51eCBGb3VuZGF0aW9uDQo+IA0KPiANCj4gDQo+ICAgICAgICANCj4gICANCj4g
ICAgICAgICAgDQo+IA0K
