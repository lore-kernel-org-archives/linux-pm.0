From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v6 01/21] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Mon, 28 Mar 2016 02:41:05 +0000 (GMT)
Message-ID: <687204698.26641459132858812.JavaMail.weblogic@epmlwas02a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
MIME-version: 1.0
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, =?utf-8?Q?=ED=81=AC=EC=89=AC=EC=8B=9C=ED=86=A0=ED=94=84?= <k.kozlowski@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "m.reichl@fivetechno.de" <m.reichl@fivetechno.de>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"devicetree@vger.kernel.org" <devicetree@>
List-Id: linux-pm@vger.kernel.org

PiAgIA0KPiAgVGhpcyBwYXRjaCBhZGRzIHRoZSBnZW5lcmljIGV4eW5vcyBidXMgZnJlcXVlbmN5
IGRyaXZlciBmb3IgQU1CQSBBWEkgYnVzDQo+IG9mIHN1Yi1ibG9ja3MgaW4gZXh5bm9zIFNvQyB3
aXRoIERFVkZSRVEgZnJhbWV3b3JrLiBUaGUgU2Ftc3VuZyBFeHlub3MgU29DDQo+IGhhdmUgdGhl
IGNvbW1vbiBhcmNoaXRlY3R1cmUgZm9yIGJ1cyBiZXR3ZWVuIERSQU0gYW5kIHN1Yi1ibG9ja3Mg
aW4gU29DLg0KPiBUaGlzIGRyaXZlciBjYW4gc3VwcG9ydCB0aGUgZ2VuZXJpYyBidXMgZnJlcXVl
bmN5IGRyaXZlciBmb3IgRXh5bm9zIFNvQ3MuDQo+IA0KPiBJbiBkZXZpY2V0cmVlLCBFYWNoIGJ1
cyBibG9jayBoYXMgYSBidXMgY2xvY2ssIHJlZ3VsYXRvciwgb3BlcmF0aW9uLXBvaW50DQo+IGFu
ZCBkZXZmcmVxLWV2ZW50IGRldmljZXMgd2hpY2ggbWVhc3VyZSB0aGUgdXRpbGl6YXRpb24gb2Yg
ZWFjaCBidXMgYmxvY2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFud29vIENob2kgPGN3MDAu
Y2hvaUBzYW1zdW5nLmNvbT4NCj4gW20ucmVpY2hsIGFuZCBsaW51eC5hbW9vbjogVGVzdGVkIGl0
IG9uIGV4eW5vczQ0MTItb2Ryb2lkdTMgYm9hcmRdDQo+IFRlc3RlZC1ieTogTWFya3VzIFJlaWNo
bCA8bS5yZWljaGxAZml2ZXRlY2huby5kZT4NCj4gVGVzdGVkLWJ5OiBBbmFuZCBNb29uIDxsaW51
eC5hbW9vbkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9kZXZmcmVxL0tjb25maWcgICAg
ICB8ICAxNSArKw0KPiAgZHJpdmVycy9kZXZmcmVxL01ha2VmaWxlICAgICB8ICAgMSArDQo+ICBk
cml2ZXJzL2RldmZyZXEvZXh5bm9zLWJ1cy5jIHwgNDQzICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNDU5IGluc2VydGlvbnMo
KykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2RldmZyZXEvZXh5bm9zLWJ1cy5jDQo+
IA0KDQpTaWduZWQtb2ZmLWJ5OiBNeXVuZ0pvbyBIYW0gPG15dW5nam9vLmhhbUBzYW1zdW5nLmNv
bT4NCg0K
