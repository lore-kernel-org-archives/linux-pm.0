From: Andy Tang <andy.tang@nxp.com>
Subject: RE: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Date: Thu, 21 Mar 2019 01:05:29 +0000
Message-ID: <VI1PR04MB4333256C38E6DEDD3E0F303AF3420@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
 <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <dc94e884-f5eb-fe07-27ef-6a94c3174acb@linaro.org>
 <VI1PR04MB43330C6FAAD0D8EAE901C56FF34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <cb262e2c-7115-86a5-01ce-4a12d45ee019@linaro.org>
 <VI1PR04MB43338294C193D1AB4F577E92F34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20190320081853.GE4980@dragon>
 <VI1PR04MB433351C20A9863EEF21A2504F3410@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20190320144907.GC8337@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190320144907.GC8337@dragon>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE5xOoz1MIyMMjVIDIyOjQ5DQo+IFRvOiBBbmR5
IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiBDYzogRGFuaWVsIExlemNhbm8gPGRhbmllbC5s
ZXpjYW5vQGxpbmFyby5vcmc+OyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+Ow0KPiBlZHViZXp2
YWxAZ21haWwuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IHJ1aS56aGFuZ0BpbnRlbC5jb207DQo+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyXSBhcm02NDogZHRzOiBsczEwODhhOiBhZGQgb25lIG1vcmUgdGhlcm1hbCB6b25lIG5v
ZGUNCj4gDQo+IE9uIFdlZCwgTWFyIDIwLCAyMDE5IGF0IDA4OjQ0OjE4QU0gKzAwMDAsIEFuZHkg
VGFuZyB3cm90ZToNCj4gPiA+ID4gU2Vuc29yIElECQlwbGFjZW1lbnQNCj4gPiA+ID4gMQkJCURE
UiBjb250cm9sbGVyIDENCj4gPiA+ID4gMgkJCUREUiBjb250cm9sbGVyIDINCj4gPiA+ID4gMwkJ
CUREUiBjb250cm9sbGVyIDMNCj4gPiA+ID4gNAkJCWNvcmUgY2x1c3RlciAxDQo+ID4gPiA+IDUg
CQljb3JlIGNsdXN0ZXIgMg0KPiA+ID4gPiA2IAkJY29yZSBjbHVzdGVyIDMNCj4gPiA+ID4gNyAJ
CWNvcmUgY2x1c3RlciA0DQo+ID4gPiA+DQo+ID4gPiA+IEFwcGFyZW50bHkgdXNpbmcgQ1BVIG9y
IENQVS1jbHVzdGVyIGlzIG5vdCBhcHByb3ByaWF0ZS4gQ29yZS1jbHVzdGVyIGlzDQo+IGJldHRl
ci4NCj4gPiA+DQo+ID4gPiBTbyB1c2luZyBDUFUgaXMgYXBwcm9wcmlhdGUgZm9yIG1lLCBsZXNz
IGNvbmZ1c2luZywgbW9yZSBjb25zaXN0ZW50DQo+ID4gPiB3aXRoIG90aGVyIHBsYXRmb3Jtcy4N
Cj4gPiBXaGF0IGFib3V0IGNvcmUgY2x1c3Rlcj8gV2UgY2FuJ3QgbmFtZSBpdCBjcHUwLCBjcHUx
IGV0YyBJIHRoaW5rLg0KPiANCj4gSG1tLCB5ZXMsIHRoYXQgd291bGQgYmUgZXZlbiBtb3JlIGNv
bmZ1c2luZy4gIFdoYXQgYWJvdXQgY3B1LXRoZXJtYWwtMSwNCj4gY3B1LXRoZXJtYWwtMiAuLi4/
DQpDcHUtdGhlcm1hbC14IGNhbid0IGNoYW5nZSBhbnl0aGluZyBiZXR0ZXIgdGhhbiBjcHVYLiBJ
dCBjYW4ndCByZWZsZWN0IHRoZSBjb25jZXB0IG9mIENMVVNURVIuDQpJIHByZWZlciB0byB1c2Ug
Y29yZS1jbHVzdGVyLiBJdCBpcyBhIHdpbGQgYWNjZXB0ZWQgdGVybSBpbiBBUk0gZWNvc3lzdGVt
Lg0KDQpCUiwNCkFuZHkNCj4gDQo+IFNoYXduDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
