From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v7 04/20] PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER
 notifier
Date: Wed, 06 Apr 2016 09:47:00 +0000 (GMT)
Message-ID: <2132021939.168541459936013813.JavaMail.weblogic@ep2mlwas02a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47137 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbcDFJrC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 05:47:02 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O570036EHUCS860@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 06 Apr 2016 18:47:00 +0900 (KST)
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
by5kZT4NCj4gVGVzdGVkLWJ5OiBBbmFuZCBNb29uIDxsaW51eC5hbW9vbkBnbWFpbC5jb20+DQoN
ClNpZ25lZC1vZmYtYnk6IE15dW5nSm9vIEhhbSA8bXl1bmdqb28uaGFtQHNhbXN1bmcuY29tPg0K
DQo+IC0tLQ0KPiAgZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyB8IDE2MyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICBpbmNsdWRlL2xpbnV4L2RldmZy
ZXEuaCAgIHwgIDU5ICsrKysrKysrKysrKysrKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIyMCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K


