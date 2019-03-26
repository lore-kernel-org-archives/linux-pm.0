From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v11 6/8] rtc: bd70528: Initial support for ROHM bd70528
 RTC
Date: Tue, 26 Mar 2019 13:51:40 +0000
Message-ID: <1db28c6d6223f2c052c0853121fd7b7aa6f7b227.camel@fi.rohmeurope.com>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
         <901900e12e2a06865b3649ec94af511fcc6443a3.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
         <20190325170451.GQ30105@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325170451.GQ30105@piout.net>
Content-Language: de-DE
Content-ID: <81AF68924370B84D802F4EC304942223@de.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sboyd@kernel.org" <sboyd@kernel.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "broonie@kernel.org" <broonie@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Mutanen,
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTI1IGF0IDE4OjA0ICswMTAwLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90
ZToNCj4gT24gMjUvMDMvMjAxOSAxNDowNjo0MiswMjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6
DQo+ID4gU3VwcG9ydCBSVEMgYmxvY2sgaW4gUk9ITSBiZDcwNTI4IHBvd2VyIG1hbmFnZW1lbnQg
SUMuIFN1cHBvcnQNCj4gPiBnZXR0aW5nIGFuZCBzZXR0aW5nIHRoZSB0aW1lIGFuZCBkYXRlIGFz
IHdlbGwgYXMgYXJtaW5nIGFuIGFsYXJtDQo+ID4gd2hpY2ggY2FuIGFsc28gYmUgdXNlZCB0byB3
YWtlIHRoZSBQTUlDIGZyb20gc3RhbmRieSBzdGF0ZS4NCj4gPiANCj4gPiBIVyBzdXBwb3J0cyB3
YWtlIGludGVycnVwdCBvbmx5IGZvciB0aGUgbmV4dCAyNCBob3VycyAoc2VjLCBtaW51dGUNCj4g
PiBhbmQgaG91ciBpbmZvcm1hdGlvbiBvbmx5KSBzbyB3ZSBsaW1pdCBhbHNvIHRoZSBhbGFybSBp
bnRlcnJ1cHQgdG8NCj4gPiB0aGlzIDI0IGhvdXJzIGZvciB0aGUgc2FrZSBvZiBjb25zaXN0ZW5j
eS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0
aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBBbGV4YW5kcmUgQmVsbG9u
aSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQo+IA0KPiA+ICsJci0+dGltZS5ob3Vy
IHw9IEJENzA1MjhfTUFTS19SVENfSE9VUl8yNEg7DQo+ID4gKwlyLT5kYXkgfD0gYmluMmJjZCh0
LT50bV9tZGF5KTsNCj4gPiArCXItPndlZWsgfD0gYmluMmJjZCh0LT50bV93ZGF5KTsNCj4gPiAr
CXItPm1vbnRoIHw9IGJpbjJiY2QodC0+dG1fbW9uICsgMSk7DQo+ID4gKwlyLT55ZWFyID0gYmlu
MmJjZCh0LT50bV95ZWFyLTEwMCk7DQo+IA0KPiBJZiB5b3UgZXZlciBoYXZlIHRvIHJlc2VuZCwg
cGxlYXNlIGFkZCBzcGFjZXMgYXJvdW5kIHRoYXQgLQ0KDQpHb29kIGNhdGNoLCB0aGFua3MhIEkg
d29uZGVyIHdoeSBJIGRpZG4ndCBnZXQgY2hlY2twYXRjaCB3YXJuaW5nLi4uIEkNCnNob3VsZCd2
ZSBoYWQgb25lLiAoSSB1c3VhbGx5IGRvIHJ1biBjaGVja3BhdGNoKS4NCg0KQW55d2F5cywgSSds
bCBhZGQgc3BhY2VzIGlmIEkgbmVlZCB0byByZXNwaW4gdGhlIHNlcmllcy4NCg0KQnIsDQogICAg
TWF0dGkgVmFpdHRpbmVuDQoNCg==
