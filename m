From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v6 0/7] Add initial support for DA9150 Charger &
 Fuel-Gauge IC
Date: Mon, 16 Feb 2015 21:45:59 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB52D71F@SW-EX-MBX01.diasemi.com>
References: <cover.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
 <20150121165250.GG13715@earth.universe>
 <C1079F30-5D1D-45AA-A129-FE1E68EA5DC5@jic23.retrosnub.co.uk>
 <20150122075811.GO22024@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.164]:32143 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751108AbbBPVqH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 16:46:07 -0500
In-Reply-To: <20150122075811.GO22024@x1>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Jonathan Cameron <jic23@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Hartmut Knaack <knaack.h@gmx.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@>

T24gSmFudWFyeSAyMiwgMjAxNSAwNzo1OCwgTGVlIEpvbmVzIHdyb3RlOg0KDQo+IE9uIFdlZCwg
MjEgSmFuIDIwMTUsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IA0KPiA+DQo+ID4NCj4gPiBP
biAyMSBKYW51YXJ5IDIwMTUgMTY6NTI6NTAgR01UKzAwOjAwLCBTZWJhc3RpYW4gUmVpY2hlbCA8
c3JlQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0KPiA+ID5IaSwNCj4gPiA+DQo+ID4gPk9uIFdlZCwg
SmFuIDIxLCAyMDE1IGF0IDAzOjQ2OjI1UE0gKzAwMDAsIEFkYW0gVGhvbXNvbiB3cm90ZToNCj4g
PiA+PiBUaGlzIHBhdGNoIHNldCBhZGRzIGluaXRpYWwgc3VwcG9ydCBmb3IgdGhlIERpYWxvZyBE
QTkxNTAgSW50ZWdyYXRlZA0KPiA+ID5DaGFyZ2VyICYNCj4gPiA+PiBGdWVsLUdhdWdlIElDLiBU
aGUgZGV2aWNlIGFsc28gcHJvdmlkZXMgR1BJTyBhbmQgR1BBREMgZnVuY3Rpb25hbGl0eS4NCj4g
PiA+Pg0KPiA+ID4+IEluIHRoaXMgcGF0Y2ggc2V0IHRoZSBmb2xsb3dpbmcgaXMgcHJvdmlkZWQ6
DQo+ID4gPj4gIC0gTUZEIENvcmUgc3VwcG9ydCBhbmQgRFQgYmluZGluZ3MgZG9jdW1lbnRhdGlv
bi4NCj4gPiA+PiAgLSBJSU8gR1BBREMgc3VwcG9ydCBhbmQgRFQgYmluZGluZ3MgZG9jdW1lbnRh
dGlvbi4NCj4gPiA+PiAgLSBQb3dlciBTdXBwbHkgQ2hhcmdlciBzdXBwb3J0IGFuZCBEVCBiaW5k
aW5ncyBkb2N1bWVudGF0aW9uLg0KPiA+ID4+ICAtIFVwZGF0ZSB0byBNQUlOVEFJTkVSUyBmaWxl
IHRvIGFkZCBEQTkxNTAgZmlsZXMgdG8gRGlhbG9nIHN1cHBvcnQNCj4gPiA+bGlzdC4NCj4gPiA+
Pg0KPiA+ID4+IFRvIGtlZXAgcGF0Y2ggc3VibWlzc2lvbiBmcm9tIGJlaW5nIHRvbyBsYXJnZSwg
c3VwcG9ydCBmb3IgR1BJTyBhbmQNCj4gPiA+RnVlbC1HYXVnZQ0KPiA+ID4+IHdpbGwgY29tZSBh
ZnRlciBpbml0aWFsIHN1cHBvcnQgcGF0Y2hlcyBhcmUgYWNjZXB0ZWQuDQo+ID4gPj4NCj4gPiA+
PiBUaGlzIHBhdGNoIHNldCBpcyBiYXNlbGluZWQgYWdhaW5zdCB0aGUgdjMuMTktcmM1IGtlcm5l
bCB2ZXJzaW9uLg0KPiA+ID4+DQo+ID4gPj4gQ2hhbmdlcyBpbiB2NjoNCj4gPiA+PiAtIEZvciBH
UEFEQyBkcml2ZXIsIFVzZSBsb3dlciBjYXNlIGV4dGVuZGVkIG5hbWVzIGZvciBJSU8gR1BBREMN
Cj4gPiA+Y2hhbm5lbHMsIGFuZA0KPiA+ID4+ICAgcmVtb3ZlIGV4dGVuZGVkIG5hbWVzIGZvciBH
UElPIHJlbGF0ZWQgY2hhbm5lbHMuDQo+ID4gPj4gLSBGb3IgY2hhcmdlciBkcml2ZXIsIHJldmVy
dCB0byBubyBkZXZtIElSUSByZXF1ZXN0L2ZyZWUgZnVuY3Rpb25zIGFzDQo+ID4gPm9yZGVyaW5n
DQo+ID4gPj4gICBpcyBpbXBvcnRhbnQsIGFuZCBwcm9iZSBmYWlsdXJlIHNjZW5hcmlvIHdhcyBu
b3QgYmVpbmcgY29ycmVjdGx5DQo+ID4gPmNvdmVyZWQuIEENCj4gPiA+PiAgIGhlbHBlciBmdW5j
dGlvbiBmb3IgZnJlZSBJUlFzIGhhcyBiZWVuIGFkZGVkIHRvIG1ha2UgY29kZSBjbGVhbmVyLg0K
PiA+ID4NCj4gPiA+UHJvYmFibHkgYSBkZXZtXyB2YXJpYW50IG9mIHBvd2VyX3N1cHBseV9yZWdp
c3RlciBzaG91bGQgYmUgY3JlYXRlZCwNCj4gPiA+YnV0IGZvciBub3cgdGhpcyBpcyBvayBmb3Ig
bWUuDQo+ID4gPg0KPiA+ID5Kb25hdGhhbiwgTGVlOiBJIGFzc3VtZSB5b3UgYXJlIG9rIHdpdGgg
dGhlIHdob2xlIHBhdGNoc2V0IGdvaW5nDQo+ID4gPnRocm91Z2ggdGhlIHBvd2VyIHN1cHBseSBz
dWJzeXN0ZW0/DQo+ID4gPg0KPiA+IEZpbmUgYnkgbWUgaWYgZWl0aGVyIHBvd2VyIHN1cHBseSBv
ciBNRkQuDQo+IA0KPiBJIGFtLCBidXQgdGhlcmUgaXMgYSBsb3Qgb2YgTUZEIGNvZGUgaGVyZSwg
c28gSSdkIGxpa2UgdG8gdGFrZSBpdCBpbg0KPiBhcyB3ZWxsLiAgSSdkIGxpa2UgYSB0YWdnZWQg
cHVsbC1yZXF1ZXN0IGZyb20gU2ViYXN0aWFuLg0KDQpIaSBTZWJhc3RpZW4sDQoNCkp1c3QgYSBx
dWljayBvbmUgdG8gc2VlIHdoYXQgdGhlIHN0YXR1cyBpcyBvbiB0aGlzIHBhdGNoIHNldD8gSnVz
dCBpbnRlcmVzdGVkDQphcyB0byB3aGVuIGl0J2xsIGJlIHB1bGxlZCBpbi4NCg0KVGhhbmtzDQpB
ZGFtDQo=
