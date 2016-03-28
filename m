From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v6 04/21] PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER
 notifier
Date: Mon, 28 Mar 2016 02:54:56 +0000 (GMT)
Message-ID: <190611333.27621459133690582.JavaMail.weblogic@epmlwas02a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50533 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbcC1Cy6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Mar 2016 22:54:58 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O4Q0070JARKHR20@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 28 Mar 2016 11:54:56 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, =?utf-8?Q?=ED=81=AC=EC=89=AC=EC=8B=9C=ED=86=A0=ED=94=84?= <k.kozlowski@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "m.reichl@fivetechno.de" <m.reichl@fivetechno.de>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"devicetree@vger.kernel.org" <devicetree@>

PiAgIA0KPiAgVGhpcyBwYXRjaCBhZGRzIHRoZSBuZXcgREVWRlJFUV9UUkFOU0lUSU9OX05PVElG
SUVSIG5vdGlmaWVyIHRvIHNlbmQNCj4gdGhlIG5vdGlmaWNhdGlvbiB3aGVuIHRoZSBmcmVxdWVu
Y3kgb2YgZGV2aWNlIGlzIGNoYW5nZWQuDQo+IFRoaXMgbm90aWZpZXIgaGFzIHR3byBzdGF0ZSBh
cyBmb2xsb3dpbmc6DQo+IC0gREVWRlJFUV9QUkVDSEFOR0UgIDogTm90aWZ5IGl0IGJlZm9yZSBj
aGFuaW5nIHRoZSBmcmVxdWVuY3kgb2YgZGV2aWNlDQo+IC0gREVWRlJFUV9QT1NUQ0hBTkdFIDog
Tm90aWZ5IGl0IGFmdGVyIGNoYW5nZWQgdGhlIGZyZXF1ZW5jeSBvZiBkZXZpY2UNCj4gDQo+IEFu
ZCB0aGlzIHBhdGNoIGFkZHMgdGhlIHJlc291cmNlZC1tYW5hZ2VkIGZ1bmN0aW9uIHRvIHJlbGVh
c2UgdGhlIHJlc291cmNlDQo+IGF1dG9tYXRpY2FsbHkgd2hlbiBlcnJvciBoYXBwZW4uDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4NCj4g
W20ucmVpY2hsIGFuZCBsaW51eC5hbW9vbjogVGVzdGVkIGl0IG9uIGV4eW5vczQ0MTItb2Ryb2lk
dTMgYm9hcmRdDQo+IFRlc3RlZC1ieTogTWFya3VzIFJlaWNobCA8bS5yZWljaGxAZml2ZXRlY2hu
by5kZT4NCj4gVGVzdGVkLWJ5OiBBbmFuZCBNb29uIDxsaW51eC5hbW9vbkBnbWFpbC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyB8IDE2MyArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICBpbmNsdWRlL2xpbnV4L2RldmZyZXEu
aCAgIHwgIDU4ICsrKysrKysrKysrKysrKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIxOSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpbXQ0KDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2RldmZyZXEuaCBiL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oDQo+IGluZGV4IGFhMGI4
NDI0ZWJjMy4uMTUyZWEzNDI1MjljIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RldmZy
ZXEuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2RldmZyZXEuaA0KPiBAQCAtMTksNiArMTksMTMg
QEANCj4gIA0KPiAgI2RlZmluZSBERVZGUkVRX05BTUVfTEVOIDE2DQo+ICANCj4gKy8qIERFVkZS
RVEgbm90aWZpZXIgaW50ZXJmYWNlICovDQo+ICsjZGVmaW5lIERFVkZSRVFfVFJBTlNJVElPTl9O
T1RJRklFUgkoMCkNCj4gKw0KPiArLyogVHJhbnNpdGlvbiBub3RpZmllcnMgb2YgREVWRlJFUV9U
UkFOU0lUSU9OX05PVElGSUVSICovDQo+ICsjZGVmaW5lCURFVkZSRVFfUFJFQ0hBTkdFCQkoMCkN
Cj4gKyNkZWZpbmUgREVWRlJFUV9QT1NUQ0hBTkdFCQkoMSkNCj4gKw0KPiAgc3RydWN0IGRldmZy
ZXE7DQo+ICANCj4gIC8qKg0KPiBAQCAtMTc3LDYgKzE4NCwxMyBAQCBzdHJ1Y3QgZGV2ZnJlcSB7
DQo+ICAJdW5zaWduZWQgaW50ICp0cmFuc190YWJsZTsNCj4gIAl1bnNpZ25lZCBsb25nICp0aW1l
X2luX3N0YXRlOw0KPiAgCXVuc2lnbmVkIGxvbmcgbGFzdF9zdGF0X3VwZGF0ZWQ7DQo+ICsNCj4g
KwlzdHJ1Y3Qgc3JjdV9ub3RpZmllcl9oZWFkIHRyYW5zaXRpb25fbm90aWZpZXJfbGlzdDsNCj4g
K307DQoNCkxpa2Ugb3RoZXIgcHJvcGVydGllcyBvZiBzdHJ1Y3QgZGV2ZnJlcSwgcGxlYXNlIGFk
ZA0KZGVzY3JpcHRpb25zIGFib3ZlLiBPdGhlciB0aGFuIHRoYXQsIGl0IGxvb2tzIGdvb2QuDQoN
Cg0KDQo=


