From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Date: Thu, 28 Mar 2019 11:27:53 +0000
Message-ID: <AM0PR04MB4211673DC2071A6181B0948880590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
         <1553701479.2561.38.camel@pengutronix.de>
         <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
         <1553702767.2561.40.camel@pengutronix.de>
         <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
 <1553709304.2561.44.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553709304.2561.44.camel@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Abel Vesa <abel.vesa@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Wy4uLl0NCj4gPiA+IEFueXRoaW5nIHRoYXQgaXNuJ3QgdmlzaWJsZSB0byB0aGUgR1BDIGFuZCBy
ZXF1aXJlcyB0aGUgR0lDDQo+ID4gPiB3YWtlX3JlcXVlc3Qgc2lnbmFsIHRvIGJlaGF2ZSBhcyBz
cGVjaWZpZWQgaXMgYnJva2VuIGJ5IHRoaXMgZXJyYXR1bS4NCj4gPg0KPiA+IEkgcmVhbGx5IHdv
bmRlciBob3cgYSB0aW1lciBpbnRlcnJ1cHQgKGEgUFBJLCBoZW5jZSBub3Qgcm91dGVkIHRocm91
Z2gNCj4gPiB0aGUgR1BDKSBjYW4gd2FrZSB1cCB0aGUgQ1BVIGluIHRoaXMgY2FzZS4gSXQgcmVh
bGx5IGZlZWxzIGxpa2UNCj4gPiBzb21ldGhpbmcgbGlrZSAicHJvZ3JhbSBDTlRWX0NWQUxfRUww
IHRvIGV4cGlyZSBhdCBzb21lIGxhdGVyIHBvaW50Ow0KPiA+IFdGSSIgY291bGQgcmVzdWx0IGlu
IHRoZSBDUFUgZ29pbmcgdG8gYSBkZWVwIHNsZWVwIHN0YXRlLCBhbmQgbm90DQo+ID4gd2FrZS11
cCBhdCBhbGwuDQo+IA0KPiBJIGd1ZXNzIGl0J3MgYnJva2VuIGluIHRoZSBzYW1lIHdheS4gVGhl
IGRvd25zdHJlYW0gRFQgY2xhaW1zDQo+ICJsb2NhbC10aW1lci1zdG9wIiBmb3IgdGhlIENQVSBz
bGVlcCBzdGF0ZSBhbmQgImFybSxuby10aWNrLWluLXN1c3BlbmQiDQo+IGZvciB0aGUgYXJtdjgt
dGltZXIsIHdoaWNoIEkgZ3Vlc3MgaXMgbm90IHRoZSB0aW1lciBhY3R1YWxseSBzdG9wcGluZyBp
biBzdXNwZW5kLA0KPiBidXQgdGhlIENQVSBiZWluZyB1bmFibGUgdG8gd2FrZSB1cCBkdWUgdG8g
dGhlIHRpbWVyIElSUS4NCj4gDQo+ID4gVGhpcyB3b3VsZCBpbmRpY2F0ZSB0aGF0IG5vdCBvbmx5
IGNwdWlkbGUgaXMgYnJva2VuIHdpdGggdGhpcywgYnV0DQo+ID4gYWJzb2x1dGVseSBldmVyeSBp
bnRlcnJ1cHQgdGhhdCBpcyBub3Qgcm91dGVkIHRocm91Z2ggdGhlIEdQQy4NCj4gDQo+IFRoYXQn
cyBteSB1bmRlcnN0YW5kaW5nIGFzIHdlbGwuIE5vdGUgdGhhdCBJIGhhdmUgbm8gTlhQIGludGVy
bmFsIGluZm9ybWF0aW9uDQo+IGFuZCBjYW4gb25seSBpbmZlciBmcm9tIHRoZSBwdWJsaXNoZWQg
cmVmZXJlbmNlIG1hbnVhbCwgZXJyYXRhIG5vdGljZSBhbmQNCj4gZG93bnN0cmVhbSBrZXJuZWwu
DQo+IA0KDQpXZSB3aWxsIGRvdWJsZSBjaGVjayBpdC4NClRoYW5rcyBmb3IgdGhlIGluZm9ybWF0
aW9uLg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiBSZWdhcmRzLA0KPiBMdWNhcw0K
