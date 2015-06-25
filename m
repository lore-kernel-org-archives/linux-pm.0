From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH 1/4] mfd: da9150: Add support for Fuel-Gauge
Date: Thu, 25 Jun 2015 09:34:05 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB557CA1@SW-EX-MBX01.diasemi.com>
References: <cover.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
 <8d8f583fee9313f261efa96a038874e552995c17.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
 <1434732461.2385.162.camel@x220>
 <2E89032DDAA8B9408CB92943514A0337AB555F28@SW-EX-MBX01.diasemi.com>
 <20150622111624.GF19061@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.140]:49050 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006AbbFYJeO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2015 05:34:14 -0400
In-Reply-To: <20150622111624.GF19061@x1>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

T24gSnVuZSAyMiwgMjAxNSAxNzo0OCwgTGVlIEpvbmVzIHdyb3RlOg0KDQo+ID4gPiBUaGUgcGVk
YW50IGluIG1lIG5vdGljZWQgdGhhdCB0aGlzIGZ1bmN0aW9uIGlzIGFjdHVhbGx5IGFkZGVkIGlu
IDMvNC4gU28NCj4gPiA+IHRoaXMgY2h1bmsgbWlnaHQgYmUgbW92ZWQgdG8gMy80LCBpZiB5b3Ug
bGlrZSB0byBlbnRlcnRhaW4gcGVkYW50cnkgbGlrZQ0KPiA+ID4gdGhhdCwgdGhhdCBpcy4gKEJ1
dCBzZWUgbXkgcmVtYXJrIG9uIDMvNCB0b28uKQ0KPiA+DQo+ID4gVGhpcyBpcyB0cnVlLCBidXQg
YXMgdGhlIGhlYWRlciBpcyBwYXJ0IG9mIE1GRCwgSSBpbmNsdWRlZCBpdCBhcyBwYXJ0IG9mIHRo
YXQNCj4gPiBwYXRjaCBhcyBJIHRob3VnaHQgdGhpcyBtYWRlIG1vcmUgc2Vuc2UuIEkgZ3Vlc3Mg
TGVlIHdpbGwgY29tbWVudCBhcyB0byB3aGV0aGVyDQo+ID4gdGhhdCB3YXMgY29ycmVjdCBvciBu
b3QuIDopDQo+IA0KPiBHbGFuY2VkIG92ZXIgdGhpcyAoYXMgSSBzdGlsbCBoYXZlIDI0MCB1bnJl
YWQgZW1haWxzIHRvIGF0dGVuZCB0bykuDQo+IElmIHRoZSBxdWVzdGlvbiBpcyB3aGV0aGVyIHRv
IHN1Ym1pdCB0aGUgcHJvdG90eXBlIGF0IHRoZSBzYW1lIHRpbWUgYXMNCj4gdGhlIGFzc29jaWF0
ZWQgZnVuY3Rpb24sIHRoZSBhbnN3ZXIgaXMgeWVzLg0KDQpIb3BlIHlvdSd2ZSBtYW5hZ2VkIHRv
IHRyYXdsIHRocm91Z2ggdGhlIGUtbWFpbHMuDQoNClRoZSBxdWVzdGlvbiB3YXMgd2hldGhlciBv
ciBub3QgdGhlIGZ1bmN0aW9uIGFuZCBwcm90b3R5cGUgc2hvdWxkIGJlIHN1Ym1pdHRlZA0KYXMg
cGFydCBvZiB0aGUgc2FtZSBpbmRpdmlkdWFsIHBhdGNoIGZpbGUuIEJvdGggYXJlIHN1Ym1pdHRl
ZCBhcyBwYXJ0IG9mIHRoZQ0KcGF0Y2ggc2V0IGJ1dCB0aGUgcHJvdG90eXBlIHJlc2lkZXMgaW4g
dGhlIE1GRCBwYXRjaCwgYW5kIHRoZSBmdW5jdGlvbiBpbiB0aGUNCnBvd2VyIChmdWVsLWdhdWdl
KSBwYXRjaC4gUGVyc29uYWxseSwgdGhpcyBzZWVtcyBmaW5lIHRvIG1lIGJ1dCBJJ20gbm90IGEN
Cm1haW50YWluZXIuDQo=
