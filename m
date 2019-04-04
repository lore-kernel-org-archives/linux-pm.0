From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Date: Thu, 4 Apr 2019 08:10:52 +0000
Message-ID: <70a8a87a403eb2ab8f0aad2a26456de8a162f363.camel@fi.rohmeurope.com>
References: <20190403073152.GM4187@dell>
         <20190403084732.GA3493@localhost.localdomain> <20190403093015.GJ11301@dell>
         <20190403101003.GC3493@localhost.localdomain> <20190403112559.GP11301@dell>
         <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
         <20190404025234.GB6830@dell>
         <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
         <20190404065452.GD6830@dell> <20190404072449.GE3493@localhost.localdomain>
         <20190404075640.GV22216@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404075640.GV22216@piout.net>
Content-Language: de-DE
Content-ID: <77CA96EB2605C44DBED0E5318C266071@de.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "sboyd@kernel.org" <sboyd@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "mark.rutland@arm.com" <mark.rutland@arm.com>"linux@roeck-us.net" <li>
List-Id: linux-pm@vger.kernel.org

SGVsbG8gQWxleGFuZHJlLA0KDQpPbiBUaHUsIDIwMTktMDQtMDQgYXQgMDk6NTYgKzAyMDAsIEFs
ZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBPbiAwNC8wNC8yMDE5IDEwOjI0OjQ5KzAzMDAsIE1h
dHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gPiBPbiBUaHUsIEFwciAwNCwgMjAxOSBhdCAwNzo1NDo1
MkFNICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDA0IEFwciAyMDE5LCBW
YWl0dGluZW4sIE1hdHRpIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IEFjdHVhbGx5LCBub3cgdGhh
dCBJIHRoaWsgb2YgaXQgdGhlIHJpZ2h0IHdheSB0byBkbyB0aGlzIHdvdWxkDQo+ID4gPiA+IGhh
dmUNCj4gPiA+ID4gYmVlbiB0aGUgZnVuY3Rpb24gcG9pbnRlciBpbiBwYXJlbnQgZGF0YSBhcyB3
YXMgZG9uZSBpbg0KPiA+ID4gPiBvcmlnaW5hbCBwYXRjaA0KPiA+ID4gPiBzZXQuIEhXLWNvbGxl
YWd1ZXMgdGVuZCB0byByZS11c2UgSFcgYmxvY2tzLCBhbmQgd2UgbGlrZSB0byByZS0NCj4gPiA+
ID4gdXNlIG91cg0KPiA+ID4gPiBkcml2ZXJzLiBJZiB0aGUgbmV4dCBQTUlDIGZyb20gUk9ITSB1
c2VzIHNhbWUgUlRDIGJsb2NrIGJ1dA0KPiA+ID4gPiBkb2VzIG5vdA0KPiA+ID4gPiBwcm92aWRl
IHdhdGNoZG9nIC0gdGhlbiBpdCBpcyBjbGVhbmVzdCBzb2x1dGlvbiB0byBmYWxsIGJhY2sgdG8N
Cj4gPiA+ID4gZnVuY3Rpb24gcG9pbnRlciBhbmQgbGVhdmUgaXQgdG8gTlVMTCB3aGVuIHRoZXJl
IGlzIG5vIFdEVCBvcg0KPiA+ID4gPiB3aGVuIFdEVA0KPiA+ID4gPiBpcyB1bnVzZWQuIEFub3Ro
ZXIgb3B0aW9uIGlzIHRvIGV4cG9ydCBkdW1teSBmdW5jdGlvbiAtIHdoaWNoDQo+ID4gPiA+IGlz
IG5vdCBzbw0KPiA+ID4gPiBuaWNlLg0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHRoZSBjb252ZXJz
ZSBpcyB0cnVlLg0KPiA+ID4gDQo+ID4gPiBQb2ludGVycyB0byBmdW5jdGlvbnMgb3V0c2lkZSBv
ZiBhIHN1YnN5c3RlbSBBUEkgY29udGV4dCBhcmUNCj4gPiA+IGdlbmVyYWxseQ0KPiA+ID4gaG9y
cmlibGUuICBJdCdzIG11Y2ggbmljZXIgdG8gY2FsbCBhIGZ1bmN0aW9uIHdoaWNoIGNhbiBiZSBl
YXNpbHkNCj4gPiA+IHN0dWJiZWQgb3V0IGluIGEgaGVhZGVyIGZpbGUgYmFzZWQgb24gYSBLY29u
ZmlnIG9wdGlvbi4gIEl0J3MgaG93DQo+ID4gPiBtb3N0DQo+ID4gPiBrZXJuZWwgQVBJcyB3b3Jr
Lg0KPiA+IA0KPiA+IEkgaGF0ZSB0byBhZG1pdCBidXQgSSBzZWUgeW91ciBwb2ludC4gVGhpcyBu
aWNlbHkgc29sdmVzIGFueSBpc3N1ZXMNCj4gPiBpbg0KPiA+IHN5bmNyb25pemluZyB0aGUgc3Rh
cnR1cCBmb3IgZHJpdmVyIHByb3ZpZGluZyBmdW5jdGlvbiBwb2ludGVyIGFuZA0KPiA+IGZvcg0K
PiA+IGRyaXZlciB1c2luZyBpdC4NCj4gPiANCj4gDQo+IFdvdWxkbid0IGl0IGJlIGVhc2llciB0
byByZWdpc3RlciB0aGUgd2F0Y2hkb2cgZHJpdmVyIGFzIHBhcnQgb2YgdGhlDQo+IFJUQw0KPiBk
cml2ZXI/DQo+IA0KPiBBcyBJIHNlZSBpdCwgdGhlIHdkdCBpcyBqdXN0IGEgZ2xvcmlmaWVkIFJU
QyBhbGFybS4NCg0KRG8geW91IHN1Z2dlc3QgbWUgdG8gcHV0IGFsbCB0aGUgc3R1ZmYgbm93IHBs
YWNlZCBpbg0KZHJpdmVycy93YXRjaGRvZy9iZDcwNTI4X3dkdC5jIGludG8gcnRjIGRyaXZlcj8g
SXQgd291bGQgYmUgZG9hYmxlIC0NCmJ1dCBJJ2QgcmF0aGVyIGtlcHQgdGhlIFdEVCBpbmRlcGVu
ZGVudCBtb2R1bGUgc28gdGhhdCBpdCBjYW4gYmUgbGVmdA0Kb3V0IG9mIGNvbmZpZyBpZiBXRFQg
bmVlZHMgbm90IHRvIGJlIHVzZWQuIEFuZCBzYW1lIHdpdGggUlRDLiBBbHNvLCByZS0NCnVzZSBv
ZiBSVEMgZHJpdmVyIGluIEhXIHdoaWNoIGRvZXMgbm90IGluY2x1ZGUgV0RUIGlzIGVhc2llciB3
aGVuIFdEVA0KaXMgYSBzZXBhcmF0ZSBtb2R1bGUuIFRvIG1lIGl0IGxvb2tzIG11Y2ggY2xlYW5l
ciB0byBoYXZlIHRoZSBXRFQgYXMNCm93biBtb2R1bGUgdGhhbiBwb2xsdXRpbmcgdGhlIFJUQyBk
cml2ZXIgd2l0aCBjb25maWcgaWZkZWZzLg0KDQpCdXQgZnJvbSBIVyBwZXJzcGVjdGl2ZSB5b3Ug
YXJlIGNvcnJlY3QuIFRoZSBXRFQgaW4gQkQ3MDUyOCBzZWVtcyB0byBiZQ0Ka2luZCBvZiBSVEMg
YWxhcm0gd2hpY2ggc2h1dHMgb2YgdGhlIFBNSUMgaWYgdHJpZ2dlcmVkLg0KDQpCciwNCglNYXR0
aSBWYWl0dGluZW4NCg==
