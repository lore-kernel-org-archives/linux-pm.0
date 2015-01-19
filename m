From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v4 7/9] ARM: dts: Add the support for exynos busfreq on
 Exynos3250-based Rinato/Monk board
Date: Mon, 19 Jan 2015 09:35:40 +0000 (GMT)
Message-ID: <1074447423.1254841421660137637.JavaMail.weblogic@epmlwas05d>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:15062 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbbASJgW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jan 2015 04:36:22 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NIF00HU83ZG7BB0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 19 Jan 2015 18:35:40 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?utf-8?Q?=EC=A1=B0=EC=98=81=EC=A4=80?= <yj44.cho@samsung.com>

PiAgIA0KPiAgVGhpcyBwYXRjaCBhZGRzIHRoZSBFeHlub3MzMjUwIG1lbW9yeS1idXMgbm9kZSB3
aGljaCBpbmNsdWRlcyB0aGUgcmVndWxhdG9yDQo+IGFuZCBkZXZmcmVxLWV2ZW50IHBoYW5kbGUu
IFRoZSBkZXZmcmVxLWV2ZW50IHBoYW5kbGUgaXMgdXNlZCBmb3IgdGhlDQo+IGdvdmVybm9yIG9m
IGRldmZyZXEgZGV2aWNlIGFuZCBwcm92aWRlIHRoZSBjdXJyZW50IHVzYWdlIHN0YXRlIG9mDQo+
IE1JRiAoTWVtb3J5IEludGVyZmFjZSkgLyBJTlQgKEludGVybmFsKSBtZW1vcnkgYnVzIGdyb3Vw
Lg0KPiANCj4gQ2M6IEt1a2ppbiBLaW0gPGtnZW5lQGtlcm5lbC5vcmc+DQo+IENjOiBNeXVuZ2pv
byBIYW0gPG15dW5nam9vLmhhbUBzYW1zdW5nLmNvbT4NCj4gQ2M6IEt5dW5nbWluIFBhcmsgPGt5
dW5nbWluLnBhcmtAc2Ftc3VuZy5jb20+DQo+IENjOiBZb3VuZ2p1biBDaG8gPHlqNDQuY2hvQHNh
bXN1bmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1z
dW5nLmNvbT4NCj4gQWNrZWQtYnk6IEt5dW5nbWluIFBhcmsgPGt5dW5nbWluLnBhcmtAc2Ftc3Vu
Zy5jb20+DQoNCkkgYW0gbm90IHNvIGNvbmZpZGVudCB3aXRoIHRoaXMgU29DIGFzIEkgZGlkbid0
IHdyaXRlIGFueSBrZXJuZWwgY29kZXMNCmZvciBFeHlub3MzMjUwIGRldmljZXMuIEFueXdheSwg
YXMgdGhlIHN5bnRheCBhbmQgdXNhZ2UgYXBwZWFycyBnb29kIHRvIG1lLg0KDQpBY2tlZC1ieTog
TXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+DQoNCj4gLS0tDQo+ICBhcmNo
L2FybS9ib290L2R0cy9leHlub3MzMjUwLW1vbmsuZHRzICAgfCAxMiArKysrKysrKysrKysNCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAtcmluYXRvLmR0cyB8IDEyICsrKysrKysrKysr
Kw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+IA0K


