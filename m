From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v3 4/6] power: da9150: Add DT bindings documentation for
 Fuel-Gauge
Date: Mon, 3 Aug 2015 15:24:02 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB5690D0@SW-EX-MBX01.diasemi.com>
References: <cover.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
 <3f9095a583c26cdb4a6dd7b749d7f6b33c87b8f7.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
 <20150724220053.GA24362@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.168]:24099 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753884AbbHCPYJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 11:24:09 -0400
In-Reply-To: <20150724220053.GA24362@earth>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

T24gSnVseSAyNCwgMjAxNSAyMzowMSwgU2ViYXN0aWFuIFJlaWNoZWwgd3JvdGU6DQoNCj4gSGks
DQo+IA0KPiBPbiBUdWUsIEp1bCAwNywgMjAxNSBhdCAwNTozNDoyMVBNICswMTAwLCBBZGFtIFRo
b21zb24gd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wb3dlci9kYTkxNTAtZmcudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Bvd2VyL2RhOTE1MC1mZy50eHQNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAuLmMzYzc2ZWINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL2RhOTE1MC1mZy50eHQNCj4g
PiBAQCAtMCwwICsxLDIzIEBADQo+ID4gK0RpYWxvZyBTZW1pY29uZHVjdG9yIERBOTE1MCBGdWVs
LUdhdWdlIFBvd2VyIFN1cHBseSBiaW5kaW5ncw0KPiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVy
dGllczoNCj4gPiArLSBjb21wYXRpYmxlOiAiZGxnLGRhOTE1MC1mZyIgZm9yIERBOTE1MCBGdWVs
LUdhdWdlIFBvd2VyIFN1cHBseQ0KPiAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eDQo+
IA0KPiBzL2RsZyxkYTkxNTAtZmcvZGxnLGRhOTE1MC1mdWVsLWdhdWdlL2cNCj4gDQoNCk9rLCBj
YW4gZG8uDQoNCj4gPiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiArLSBkbGcsdXBkYXRlLWlu
dGVydmFsOiBJbnRlcnZhbCB0aW1lIChtaWxsaXNlY29uZHMpIGJldHdlZW4gYmF0dGVyeSBsZXZl
bCBjaGVja3MuDQo+ID4gKy0gZGxnLHdhcm4tc29jLWxldmVsOiBCYXR0ZXJ5IGRpc2NoYXJnZSBs
ZXZlbCAoJSkgd2hlcmUgd2FybmluZyBldmVudCByYWlzZWQuDQo+ID4gKyAgICAgIFsxIC0gMTAw
XQ0KPiA+ICstIGRsZyxjcml0LXNvYy1sZXZlbDogQmF0dGVyeSBkaXNjaGFyZ2UgbGV2ZWwgKCUp
IHdoZXJlIGNyaXRpY2FsIGV2ZW50IHJhaXNlZC4NCj4gPiArICBUaGlzIHZhbHVlIHNob3VsZCBi
ZSBsb3dlciB0aGFuIHRoZSB3YXJuaW5nIGxldmVsLg0KPiA+ICsgICAgICBbMSAtIDEwMF0NCj4g
PiArDQo+ID4gKw0KPiA+ICtFeGFtcGxlOg0KPiA+ICsNCj4gPiArCWRhOTE1MC1mZyB7DQo+IA0K
PiBNYWtlIHRoaXMganVzdCAiZnVlbC1nYXVnZSIuDQoNCk5vIHByb2JsZW0uDQoNCj4gDQo+ID4g
KwkJY29tcGF0aWJsZSA9ICJkbGcsZGE5MTUwLWZnIjsNCj4gICAgICAgICAgICAgICAgICAgICAg
IF5eXl5eXl5eXl5eXl4NCj4gDQo+IGhlcmUgdG9vIDspDQoNCkNvbnNpZGVyIGl0IGRvbmUuIDop
DQoNCj4gDQo+ID4gKw0KPiA+ICsJCWRsZyx1cGRhdGUtaW50ZXJ2YWwgPSA8MTAwMDA+Ow0KPiA+
ICsJCWRsZyx3YXJuLXNvYy1sZXZlbCA9IC9iaXRzLyA4IDwxNT47DQo+ID4gKwkJZGxnLGNyaXQt
c29jLWxldmVsID0gL2JpdHMvIDggPDU+Ow0KPiA+ICsJfTsNCj4gDQo+IC0tIFNlYmFzdGlhbg0K
