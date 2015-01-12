From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCHv7 04/10] devfreq: event: Add exynos-ppmu devfreq-event
 driver
Date: Mon, 12 Jan 2015 08:04:34 +0000 (GMT)
Message-ID: <603055177.891931421049871049.JavaMail.weblogic@epmlwas09a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
MIME-version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

PiAgIA0KPiAgVGhpcyBwYXRjaCBhZGRzIGV4eW5vcy1wcG11IGRldmZyZXEtZXZlbnQgZHJpdmVy
IHRvIGdldCBwZXJmb3JtYW5jZSBkYXRhDQo+IG9mIGVhY2ggSVAgZm9yIFNhbXN1bmcgRXh5bm9z
IFNvQy4gVGhlc2UgZXZlbnQgZnJvbSBFeHlub3MgUFBNVSBwcm92aWRlDQo+IHVzZWZ1bCBpbmZv
cm1hdGlvbiBhYm91dCB0aGUgYmVoYXZpb3Igb2YgdGhlIFNvQyB0aGF0IHlvdSBjYW4gdXNlIHdo
ZW4NCj4gYW5hbHl6aW5nIHN5c3RlbSBwZXJmb3JtYW5jZSwgYW5kIG1hZGUgdmlzaWJsZSBhbmQg
Y2FuIGJlIGNvdW50ZWQgdXNpbmcNCj4gbG9naWMgaW4gZWFjaCBJUC4NCj4gDQo+IFRoaXMgcGF0
Y2ggaXMgYmFzZWQgb24gZXhpc3RpbmcgZHJpdmVycy9kZXZmcmVxL2V4eW5vcy9leHlub3MtcHBt
dS5jDQo+IA0KPiBDYzogTXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+DQo+
IENjOiBLeXVuZ21pbiBQYXJrIDxreXVuZ21pbi5wYXJrQHNhbXN1bmcuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2RldmZyZXEvZXZlbnQvS2NvbmZpZyAgICAgICB8ICAgOSArDQo+ICBkcml2ZXJzL2Rl
dmZyZXEvZXZlbnQvTWFrZWZpbGUgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2RldmZyZXEvZXZl
bnQvZXh5bm9zLXBwbXUuYyB8IDM5OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNDA5IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL2RldmZyZXEvZXZlbnQvZXh5bm9zLXBwbXUuYw0KPiANCg0KQWNrZWQt
Ynk6IE15dW5nSm9vIEhhbSA8bXl1bmdqb28uaGFtQHNhbXN1bmcuY29tPg0KDQo=
