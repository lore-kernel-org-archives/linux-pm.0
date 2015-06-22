From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH 1/4] mfd: da9150: Add support for Fuel-Gauge
Date: Mon, 22 Jun 2015 10:24:33 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB555F28@SW-EX-MBX01.diasemi.com>
References: <cover.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
	 <8d8f583fee9313f261efa96a038874e552995c17.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
 <1434732461.2385.162.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.162]:44276 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756163AbbFVKYn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 06:24:43 -0400
In-Reply-To: <1434732461.2385.162.camel@x220>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

T24gSnVuZSAxOSwgMjAxNSAxNzo0OCwgUGF1bCBCb2xsZSB3cm90ZToNCg0KPiBPbiBUaHUsIDIw
MTUtMDYtMTggYXQgMTc6MDYgKzAxMDAsIEFkYW0gVGhvbXNvbiB3cm90ZToNCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tZmQvZGE5MTUwL2ZnLmgNCj4gDQo+ID4g
Ky8qDQo+ID4gKyAqIEZ1bmN0aW9uIHRlbXBsYXRlIHRvIHByb3ZpZGUgYmF0dGVyeSB0ZW1wZXJh
dHVyZS4gU2hvdWxkIHByb3ZpZGUNCj4gPiArICogMC4xIGRlZ3JlZXMgQyByZXNvbHV0aW9uIHJl
dHVybiB2YWx1ZXMuDQo+ID4gKyAqLw0KPiA+ICt0eXBlZGVmIGludCAoKmRhOTE1MF9yZWFkX3Rl
bXBfdCkodm9pZCAqY29udGV4dCk7DQo+ID4gKw0KPiA+ICsvKiBSZWdpc3RlciB0ZW1wIGNhbGxi
YWNrIGZ1bmN0aW9uICovDQo+ID4gK3ZvaWQgZGE5MTUwX2ZnX3JlZ2lzdGVyX3RlbXBfY2Ioc3Ry
dWN0IHBvd2VyX3N1cHBseSAqcHN5LA0KPiBkYTkxNTBfcmVhZF90ZW1wX3QgY2IsDQo+ID4gKwkJ
CQl2b2lkICpjYl9jb250ZXh0KTsNCj4gDQo+IFRoZSBwZWRhbnQgaW4gbWUgbm90aWNlZCB0aGF0
IHRoaXMgZnVuY3Rpb24gaXMgYWN0dWFsbHkgYWRkZWQgaW4gMy80LiBTbw0KPiB0aGlzIGNodW5r
IG1pZ2h0IGJlIG1vdmVkIHRvIDMvNCwgaWYgeW91IGxpa2UgdG8gZW50ZXJ0YWluIHBlZGFudHJ5
IGxpa2UNCj4gdGhhdCwgdGhhdCBpcy4gKEJ1dCBzZWUgbXkgcmVtYXJrIG9uIDMvNCB0b28uKQ0K
DQpUaGlzIGlzIHRydWUsIGJ1dCBhcyB0aGUgaGVhZGVyIGlzIHBhcnQgb2YgTUZELCBJIGluY2x1
ZGVkIGl0IGFzIHBhcnQgb2YgdGhhdA0KcGF0Y2ggYXMgSSB0aG91Z2h0IHRoaXMgbWFkZSBtb3Jl
IHNlbnNlLiBJIGd1ZXNzIExlZSB3aWxsIGNvbW1lbnQgYXMgdG8gd2hldGhlcg0KdGhhdCB3YXMg
Y29ycmVjdCBvciBub3QuIDopDQo=
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
