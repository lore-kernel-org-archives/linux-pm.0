From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Date: Thu, 28 Mar 2019 11:55:30 +0000
Message-ID: <AM0PR04MB42119717B5EC292411963EE380590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
 <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
 <1553702767.2561.40.camel@pengutronix.de>
 <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
 <cb2e5521cc0d29b7c3ac42a6717256ec2e8d35e6.camel@nxp.com>
 <b90bd658-a29d-ea16-abf4-95b388467c8c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b90bd658-a29d-ea16-abf4-95b388467c8c@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Leonard Crestez <leonard.crestez@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robh@kernel.org" <robh@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, Anson Huang <anson.huang@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Wy4uLl0NCg0KPiA+ICogQWxsIFNQSXMgYXJlIGNvbm5lY3RlZCB0byBHUEMgaW4gYSAxOjEgbWFw
cGluZw0KPiA+ICogVGhpcyBzZXJpZXMgZGVhbHMgd2l0aCBTR0lzDQo+ID4gKiBUaGUgdGltZXIg
UFBJcyBhcmUgbm90IHJlcXVpcmVkOyBjb3ZlcmVkIGJ5IGxvY2FsLXRpbWVyLXN0b3ANCj4gPiAq
IExQSXMgYXJlIGN1cnJlbnRseSB1bnVzZWQgKEkgdW5kZXJzdGFuZCBpbXgtcGNpIHVzZXMgU1BJ
IGJ5IGRlZmF1bHQNCj4gPiBmcm9tIEx1Y2FzKQ0KPiA+DQo+ID4gQW55dGhpbmcgbWlzc2luZz8N
Cj4gPg0KPiA+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGlzIHdha2UgcmVxdWVzdCBmZWF0
dXJlIHZpYSBHSUMgaXMgbmV3IGluDQo+ID4gdjMgYW5kIHRoaXMgaXMgbWF5YmUgd2h5IEhXIHRl
YW0gbWlzc2VkIGl0IGR1cmluZyBpbnRlZ3JhdGlvbi4gT2xkZXINCj4gPiBpbXg2LzcgaGFzIEdJ
Q3YyIGFuZCBoYXMgZGVlcCBpZGxlIHN0YXRlcyB3aGljaCBhbHdheXMgcmVseSBvbiBHUEMgdG8N
Cj4gPiB3YWtldXAgc28gdGhlIGFwcHJvYWNoIGNhbiB3b3JrLg0KPiANCj4gQ2VydGFpbmx5IHRo
ZSBhcHByb2FjaCBjYW4gd29yay4gVGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgd2Ugd2FudCB0byBz
dXBwb3J0DQo+IHRoaXMgaW4gYSBtYWlubGluZSBrZXJuZWwsIHNwcmVhZGluZyByYW5kb20gaG9v
a3MgaW4gdGhlIGdlbmVyaWMgY29kZSBhbmQNCj4gYWRkaW5nIGEgZmlybXdhcmUgaW50ZXJmYWNl
IG9uIHRvcCBvZiB0aGF0Lg0KPiANCj4gQnkgYWxsIGFjY291bnRzLCB0aGlzIEhXIGlzIGJyb2tl
bi4gWW91IGNhbiBpbmRlZWQgaW1wb3NlIGxpbWl0YXRpb25zIChkdW1iDQo+IGRvd24gUENJLCBt
YW5kYXRlIHRoZSB1c2Ugb2YgYSBicm9hZGNhc3QgdGltZXIpLCBvciB5b3UgY2FuIGp1c3QgZmxh
ZyBjcHVpZGxlDQo+IGFzIHVuc3VwcG9ydGVkIG9uIHRoaXMgSFcuIE15IHZvdGUgaXMgb24gdGhl
IGxhdHRlci4NCj4gDQoNCkhpIE1hcmMsIFJhZmFlbCwgTG9yZW56byANCg0KVGhhbmtzIGZvciB0
aGUgc3VnZ2VzdGlvbi4gSSBmdWxseSB1bmRlcnN0YW5kIHRoZSBjb25jZXJuLg0KRG8geW91IHRo
aW5rIHdlIGNhbiBwYXRjaCB0aGUgcGxhdGZvcm0gY29kZSB0byBhZGRyZXNzIHRoZSBpc3N1ZSB0
byBhdm9pZA0KdGhlIGJpZyBjaHVybiBvbiBrZXJuZWwgY29yZSBjb2RlPw0KDQpJZiB5ZXMsIHdl
IGNvdWxkIHRyeSB0byBpbnZlc3RpZ2F0ZSBpZiB0aGVyZSdzIGEgc3VpdGFibGUgcGxhY2UgdG8g
ZG8gdGhhdC4NClRoZSBtYWluIHRoaW5nIHdlIG5lZWQgdG8gZG8gc2VlbXMgbGlrZSB0byBtYW51
YWxseSB3YWtldXAgY3B1IGNvcmUNCmR1cmluZyB0aGUgc2VuZGluZyBJUEkgcGF0aCB3aGVuIGV4
aXQgaWRsZS4gV2UgY291bGQgc2VlIGlmIHRoZXJlJ3MgY2hhbmNlDQp0byBkbyBpdCBvbiB0aGF0
IHBhdGguDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+IFRoYW5rcywNCj4gDQo+IAlNLg0K
PiAtLQ0KPiBKYXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLg0K
