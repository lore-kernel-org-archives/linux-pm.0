From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Fwd: [PATCH v2 0/8] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
Date: Mon, 02 May 2016 05:48:50 +0000 (GMT)
Message-ID: <1894783822.297231462168123817.JavaMail.weblogic@ep2mlwas04a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
MIME-version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, =?utf-8?Q?=ED=81=AC=EC=89=AC=EC=8B=9C=ED=86=A0=ED=94=84?= <k.kozlowski@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "m.reichl@fivetechno.de" <m.reichl@fivetechno.de>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>de
List-Id: linux-pm@vger.kernel.org

U2VuZGVyIDog7LWc7LCs7JqwPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4gUzUo7LGF7J6EKS9DaGFu
Z2UgQWdlbnQvVGl6ZW4gUGxhdGZvcm0gTGFiKFMvV+yEvO2EsCkv7IK87ISx7KCE7J6QDQpEYXRl
IDogMjAxNi0wNC0xNSAxNTozMiAoR01UKzA5OjAwKQ0KPiANCj4gVGhpcyBwYXRjaHNldCBzdXBw
b3J0IHRoZSBBTUJBIGJ1cyBmcmVxdWVuY3kgc2NhbGluZyBvbiBFeHlub3M1NDIyLWJhc2VkDQo+
IE9kcm9pZC1YVTMgYm9hcmQuIEJ1dCwgdGhpcyBzZXJpZXMgb25seSBzdXBwb3J0IHRoZSBidXMg
ZnJlcXVlbmN5IHNjYWxpbmcNCj4gZm9yIElOVCAoSW50ZXJuYWwpIGJsb2NrIHVzaW5nIFZERF9J
TlQgcG93ZXIgbGluZS4NCg0KQWxvbmcgd2l0aCBEZXZmcmVxL1Bhc3NpdmUgcGF0Y2hzZXQsIHRo
ZSBwYXRjaHNldCBpcyBtZXJnZWQgaW4NCmRldmZyZXEgZm9yLTQuNyB0cmVlLg0KDQpodHRwczov
L2dpdC5rZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVsL2dpdC9tengvZGV2ZnJlcS5naXQvbG9n
Lz9oPWZvci00LjcNCg0KQENoYW53b286IElmIHRoZXJlIGFyZSBjb21taXRzIHRvIGJlIG1lcmdl
ZCBieSBhIHRyZWUgb3RoZXIgdGhhbiBMaW51eC9QTSwNCnBsZWFzZSBsZXQgbWUga25vdy4gSSds
bCBzZW5kIG91dCBwdWxsLXJlcXVlc3Qgc29vbi4NCg0KDQpDaGVlcnMsDQpNeXVuZ0pvbw0KDQo+
IA0KPiBBbHNvLCB0byBzdXBwb3J0IHRoZSBidXMgZnJlcXVlbmN5IHNjYWxpbmcgZm9yIEV4eW5v
czU0MnggU29DLA0KPiBFeHlub3M1NDJ4IFNvQyBoYXMgdGhlIHNwZWNpZmljICdOb0MgKE5ldHdv
cmsgb24gQ2hpcCkgUHJvYmUnIGRldmljZQ0KPiB0byBtZWFzdXJlIHRoZSB0cmFuc2ZlcmVkIGRh
dGEgdHJhZmZpYyBvbiBOb0MgKE5ldHdvcmsgb24gQ2hpcCkNCj4gaW5zdGVhZCBvZiBQUE1VIChQ
bGF0Zm9ybSBQZXJmb3JtYW5jZSBNb25pdG9yaW5nIFVuaXQpLiBOb0MgUHJvYmUgZGV2aWNlDQo+
IHByb3ZpZGUgdGhlIHV0aWxpemF0aW9uIGZvciBJTlQgYmxvY2sgb2YgRXh5bm9zNTQyeCBTb0Mu
DQo+IA0KPiBUaGUgZ2VuZXJpYyBleHlub3MtYnVzIGZyZXF1ZW5jeSBkcml2ZXIgdXNlcyB0aGUg
J05vQyBQcm9iZScgZGV2ZnJlcS1ldmVudA0KPiBkZXZpY2UgKGRyaXZlcnMvZGV2ZnJlcS9ldmVu
dC9leHlub3Mtbm9jcC5jKSB3aXRob3V0IGFueSBtb2RpZmljYXRpb24uDQo+IEp1c3QgYWRkIHRo
ZSBwaGFuZGxlIG9mICdOb0MgUHJvYmUnIGR0IG5vZGUgdG8gYnVzIGR0IG5vZGUuDQo+IA0KPiBE
ZXBlbmQgb246DQo+IFRoaXMgcGF0Y2hzZXQgZGVwZW5kcyBvbiBwYXRjaFsxXSB3aGljaCBzdXBw
b3J0IHRoZSBnZW5lcmljIGV4eW5vcy1idXMNCj4gZnJlcXVlbmN5IGRyaXZlci4NCj4gWzFdIGh0
dHA6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvYXJtLWtlcm5lbC9tc2c0OTU5NzYuaHRtbA0KPiAt
IFtQQVRDSCB2OSAwMC8yMF0gUE0gLyBkZXZmZXJxOiBBZGQgZ2VuZXJpYyBleHlub3MgYnVzIGZy
ZXF1ZW5jeSBkcml2ZXIgYW5kIG5ldyBwYXNzaXZlIGdvdmVybm9yDQo+IA0KPiANCg==
