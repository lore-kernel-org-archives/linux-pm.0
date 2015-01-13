From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCHv3 5/8] ARM: dts: Add memory bus node for Exynos4x12
Date: Tue, 13 Jan 2015 09:51:02 +0000 (GMT)
Message-ID: <36216978.973981421142658259.JavaMail.weblogic@epmlwas05d>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
MIME-version: 1.0
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

PiAgIA0KPiAgVGhpcyBwYXRjaCBhZGRzIHRoZSBtZW1vcnkgYnVzIG5vZGUgZm9yIEV4eW5vczR4
MTIgU29DLiBFeHlub3M0eDEyIFNvQyBoYXMNCj4gdHdvIG1lbW9yeSBidXMgdG8gdHJhbnNsYXRl
IGRhdGEgYmV0d2VlbiBEUkFNIGFuZCBlTU1DL3N1Yi1JUHMuDQo+IA0KPiBGb2xsb3dpbmcgbGlz
dCBzcGVjaWZpZXMgdGhlIGRldGFpbGVkIHJlbGF0aW9uIGJldHdlZW4gbWVtb3J5IGJ1cyBjbG9j
ayBhbmQgRE1DDQo+IElQIGluIE1JRiAoTWVtb3J5IEludGVyZmFjZSkgYmxvY2s6DQo+IC0gRE1D
L0FDUCBjbG9jayA6IERNQyAoRHluYW1pYyBNZW1vcnkgQ29udHJvbGxlcikNCj4gDQo+IEZvbGxv
d2luZyBsaXN0IHNwZWNpZmllcyB0aGUgZGV0YWlsZWQgcmVsYXRpb24gYmV0d2VlbiBtZW1vcnkg
YnVzIGNsb2NrIGFuZA0KPiBzdWItSVBzIGluIElOVCAoSW50ZXJuYWwpIGJsb2NrOg0KPiAtIEFD
TEsxMDAgY2xvY2sgOiBQRVJJTC9QRVJJUi9NRkMoUENMSykNCj4gLSBBQ0xLMTYwIGNsb2NrIDog
Q0FNL1RWL0xDRA0KPiAtIEFDTEsxMzMgY2xvY2sgOiBGU1lTDQo+IC0gR0RML0dEUiBjbG9jayA6
IGxlZnRidXMvcmlnaHRidXMNCj4gLSBTQ0xLX01GQyBjbG9jayA6IE1GQw0KPiANCj4gQ2M6IEt1
a2ppbiBLaW0gPGtnZW5lQGtlcm5lbC5vcmc+DQo+IENjOiBNeXVuZ2pvbyBIYW0gPG15dW5nam9v
LmhhbUBzYW1zdW5nLmNvbT4NCj4gQ2M6IEt5dW5nbWluIFBhcmsgPGt5dW5nbWluLnBhcmtAc2Ft
c3VuZy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1
bmcuY29tPg0KDQpBY2tlZC1ieTogTXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5j
b20+IGZvciBhbGwgdGhlIG90aGVyIGR0cyBmaWxlIHBhdGNoIHdpdGggRXh5bm9zKi4NCg0KDQpP
ZmYgVG9waWMuIE5vdCB1cmdlbnQuIEp1c3Qgb3V0IG9mIGN1cmlvdXNpdHk6DQogIERvIHlvdSBo
YXZlIHNvbWUgaWRlYSBvbiBob3cgdG8gZXhwcmVzcyB2b2x0YWdlIHZhcmlhdGlvbnMNCndpdGgg
ZGV2aWNlIHRyZWU/IChub3QgcnVudGltZS1BVlMsIGJ1dCBib290dGltZS1BVlMuIHJ1bnRpbWUt
QVZTIGlzIHJhdGhlcg0KdHJpdmlhbCkNCg0KICBJIHRoaW5rIHlvdSByZW1lbWJlciB0aGF0IHdl
IG9mdGVuIGhhZCBtdWx0aXBsZSBzZXQgb2YgIk9QUCB0YWJsZXMiIGFuZA0Kd2UgY2hvc2Ugb25l
IG9mIHRoZW0gYmFzZWQgb24gdGhlIHZhbHVlIGV4dHJhY3RlZCBhdCBib290IHRpbWUgaW4gb3Jk
ZXIgdG8NCnVzZSBsb3dlciB2b2x0YWdlIHZhbHVlcyB3aXRob3V0IGRldGVyaW9yYXRpbmcgdGhl
IHJlbGlhYmlsaXR5Lg0KDQogIEJhc2ljYWxseSwgc3VjaCBhIGZlYXR1cmUgcmVxdWlyZXMgdG8g
ZXhwcmVzcyBtdWx0aXBsZSBPUFAgbGlzdHMgYW5kIGxldA0KdGhlIGtlcm5lbCBjaG9vc2Ugb25l
IG9mIHRoZSBsaXN0cyBhdCB0aGUgYm9vdCB0aW1lLCB3aGljaCBJIGRvdWJ0IHRoZQ0KZXhwcmVz
c2l2ZW5lc3MgaW4gdGhlIGN1cnJlbnQgZGV2aWNlIHRyZWUgdGVjaG5pcXVlLg0KDQo+IC0tLQ0K
PiAgYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNHgxMi5kdHNpIHwgMTIxICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIxIGluc2VydGlv
bnMoKykNCj4gDQo=
