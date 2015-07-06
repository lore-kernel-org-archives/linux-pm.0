From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v2 2/4] mfd: da9150: Update DT bindings for Fuel-Gauge
 support
Date: Mon, 6 Jul 2015 14:23:07 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB55C80C@SW-EX-MBX01.diasemi.com>
References: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
 <afbda3c9439f08cbf57c184ff6b96bdf7f5ca8b4.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
 <20150703151923.GB10500@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.143]:32980 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751009AbbGFOXM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 10:23:12 -0400
In-Reply-To: <20150703151923.GB10500@x1>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

T24gSnVseSAzLCAyMDE1IDE2OjE5LCBMZWUgSm9uZXMgd3JvdGU6DQoNCj4gPiBAQCAtMjIsNiAr
MjMsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICBTdWItZGV2aWNlczoNCj4gPiAgLSBk
YTkxNTAtZ3BhZGM6IFNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2Fk
Yy9kYTkxNTAtDQo+IGdwYWRjLnR4dA0KPiA+ICAtIGRhOTE1MC1jaGFyZ2VyOiBTZWUgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL2RhOTE1MC0NCj4gY2hhcmdlci50eHQN
Cj4gPiArLSBkYTkxNTAtZmc6IFNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cG93ZXIvZGE5MTUwLWZnLnR4dA0KPiANCj4gQ2FuIHlvdSBzZW5kIGEgc3Vic2VxdWVudCBwYXRj
aCBkb2luZzoNCj4gDQo+IHMtRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzLy0uLi8t
DQoNClllcCwgY2FuIGRvLg0KDQo+ID4NCj4gPg0KPiANCj4gU3VwZXJmbHVvdXMgJ1xuJyBoZXJl
Lg0KDQpXaWxsIHJlbW92ZS4NCg0KPiANCj4gPiAgRXhhbXBsZToNCj4gPiBAQCAtNDAsNCArNDIs
OCBAQCBFeGFtcGxlOg0KPiA+ICAJCWRhOTE1MC1jaGFyZ2VyIHsNCj4gPiAgCQkJLi4uDQo+ID4g
IAkJfTsNCj4gPiArDQo+ID4gKwkJZGE5MTUwLWZnIHsNCj4gPiArCQkJLi4uDQo+ID4gKwkJfTsN
Cj4gDQo+IFBlcmhhcHMgYSBsaXR0bGUgY29udGVudCB3b3VsZG4ndCBnbyBhbWlzcyBoZXJlIGZv
ciBxdWljayByZWZlcmVuY2UuDQo+IA0KPiBTYXZlcyBkaXBwaW5nIGluIGFuZCBvdXQgb2YgdGhl
IG90aGVyIGJpbmRpbmcgZmlsZXMuDQo+IA0KPiBUaGlzIHBhdGNoIGlzIGZpbmUgdGhvdWdoOg0K
PiAgIEFja2VkLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPg0KPiANCg0KVGhh
bmtzIGZvciB0aGUgYWNrLiBXaWxsIGFkZCBhIGxpdHRsZSBpbmZvIGluIHRoZSBleGFtcGxlLg0K
