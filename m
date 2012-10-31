From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: Re: [for-next PATCH V2] PM / devfreq: Add sysfs node to expose
 available frequencies
Date: Wed, 31 Oct 2012 02:11:07 +0000 (GMT)
Message-ID: <3578820.552041351649466344.JavaMail.weblogic@epv6ml03>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14776 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2JaCLK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Oct 2012 22:11:10 -0400
Received: from epcpsbge2.samsung.com (epcpsbge2 [203.254.230.12])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCQ00L5HJDJYWB0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 31 Oct 2012 11:11:08 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nishanth Menon <nm@ti.com>, linux-pm <linux-pm@vger.kernel.org>, Rajagopal Venkat <rajagopal.venkat@linaro.org>, =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>, Kevin Hilman <khilman@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

PiBPbiBGcmlkYXksIE9jdG9iZXIgMjYsIDIwMTIgMDY6MTY6MzYgQU0gTXl1bmdKb28gSGFtIHdy
b3RlOg0KPiA+ID4gZGV2ZnJlcSBnb3Zlcm5vcnMgc3VjaCBhcyBvbmRlbWFuZCBhcmUgY29udHJv
bGxlZCBieSBhIG1pbiBhbmQNCj4gPiA+IG1heCBmcmVxdWVuY3ksIHdoaWxlIGdvdmVybm9ycyBs
aWtlIHVzZXJzcGFjZSBnb3Zlcm5vciBhbGxvdyB1cw0KPiA+ID4gdG8gc2V0IGEgc3BlY2lmaWMg
ZnJlcXVlbmN5Lg0KPiA+ID4gSG93ZXZlciwgZm9yIHRoZSBzYW1lIHNwZWNpZmljIGRldmljZSwg
ZGVwZW5kaW5nIG9uIHRoZSBTb0MsIHRoZQ0KPiA+ID4gYXZhaWxhYmxlIGZyZXF1ZW5jaWVzIGNh
biB2YXJ5Lg0KPiA+ID4gDQo+ID4gPiBTbyBleHBvc2UgdGhlIGF2YWlsYWJsZSBmcmVxdWVuY2ll
cyBhcyBhIHNuYXBzaG90IG92ZXIgc3lzZnMgdG8NCj4gPiA+IGFsbG93IGluZm9ybWVkIGRlY2lz
aW9ucy4NCj4gPiA+IA0KPiA+ID4gVGhpcyB3YXMgaW5zcGlyZWQgYnkgY3B1ZnJlcSBmcmFtZXdv
cmsncyBlcXVpdmFsZW50IGZvciBzaW1pbGFyDQo+ID4gPiB1c2FnZSBzeXNmcyBub2RlOiBzY2Fs
aW5nX2F2YWlsYWJsZV9mcmVxdWVuY2llcy4NCj4gPiA+IA0KPiA+ID4gQ2M6IFJhamFnb3BhbCBW
ZW5rYXQgPHJhamFnb3BhbC52ZW5rYXRAbGluYXJvLm9yZz4NCj4gPiA+IENjOiBNeXVuZ0pvbyBI
YW0gPG15dW5nam9vLmhhbUBzYW1zdW5nLmNvbT4NCj4gPiA+IENjOiBLeXVuZ21pbiBQYXJrIDxr
eXVuZ21pbi5wYXJrQHNhbXN1bmcuY29tPg0KPiA+ID4gQ2M6ICJSYWZhZWwgSi4gV3lzb2NraSIg
PHJqd0BzaXNrLnBsPg0KPiA+ID4gQ2M6IEtldmluIEhpbG1hbiA8a2hpbG1hbkB0aS5jb20+DQo+
ID4gPiBDYzogbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOaXNoYW50aCBN
ZW5vbiA8bm1AdGkuY29tPg0KPiA+IA0KPiA+IEFja2VkLWJ5OiBNeXVuZ0pvbyBIYW0gPG15dW5n
am9vLmhhbUBzYW1zdW5nLmNvbT4NCj4gDQo+IEFyZSB5b3UgZ29pbmcgdG8gaGFuZGxlIHRoaXMg
cGF0Y2g/DQoNClllcywgSSd2ZSBqdXN0IHNldHVwIHRoZSBnaXQgcmVwb3NpdG9yeSB0aGlzIHdl
ZWsNCmFuZCBJJ20gd2lsbGluZyB0byBoYW5kbGUgdGhpcyBvbmUuDQoNCkl0IGlzIGFwcGxpZWQg
YXQNCmh0dHA6Ly9naXQua2VybmVsLm9yZy8/cD1saW51eC9rZXJuZWwvZ2l0L216eC9kZXZmcmVx
LmdpdDthPXNob3J0bG9nO2g9cmVmcy9oZWFkcy9mb3ItcmFmYWVsDQoNClRoYW5rcywNCg0KTXl1
bmdKb28NCg0KPiANCj4gUmFmYWVsDQo+IA0KPiANCj4gLS0gDQo+IEkgc3BlYWsgb25seSBmb3Ig
bXlzZWxmLg0KPiBSYWZhZWwgSi4gV3lzb2NraSwgSW50ZWwgT3BlbiBTb3VyY2UgVGVjaG5vbG9n
eSBDZW50ZXIuDQo+IA0KPiANCj4gDQo+ICAgICAgICANCj4gICANCj4gICAgICAgICAgDQo+IA0K


