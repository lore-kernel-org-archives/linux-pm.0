From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v10 0/7] devfreq: Add devfreq-event class to provide raw
 data for devfreq device
Date: Tue, 27 Jan 2015 09:59:20 +0000 (GMT)
Message-ID: <2091672023.141961422352757659.JavaMail.weblogic@epmlwas08c>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59775 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbbA0J7W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 04:59:22 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NIT00GOJYEWMP10@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 27 Jan 2015 18:59:20 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?utf-8?Q?=EC=9D=B4=EC=83=81=EB=B0=B0?= <sangbae90.lee@samsung.com>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

PiAgVGhpcyBwYXRjaHNldCBhZGQgbmV3IGRldmZyZXFfZXZlbnQgY2xhc3MgdG8gcHJvdmlkZSBy
YXcgZGF0YSB0byBkZXRlcm1pbmUNCj4gY3VycmVudCB1dGlsaXphdGlvbiBvZiBkZXZpY2UgIHdo
aWNoIGlzIHVzZWQgZm9yIGRldmZyZXEgZ292ZXJub3IuDQo+IA0KPiBUaGUgZm9sbG93aW5nIGRl
c2NyaXB0aW9uIGV4cGxhaW5zIHRoZSBmZWF0dXJlIG9mIHR3byBraW5kIG9mIGRldmZyZXEgY2xh
c3M6DQo+IC0gZGV2ZnJlcSBjbGFzcyAoZXhpc3RpbmcpDQo+ICA6IGRldmZyZXEgY29uc3VtZXIg
ZGV2aWNlIHVzZSByYXcgZGF0YSBmcm9tIGRldmZyZXFfZXZlbnQgZGV2aWNlIGZvcg0KPiAgICBk
ZXRlcm1pbmluZyBwcm9wZXIgY3VycmVudCBzeXN0ZW0gc3RhdGUgYW5kIGNoYW5nZSB2b2x0YWdl
L2ZyZXF1ZW5jeQ0KPiAgICBkeW5hbWljYWxseSB1c2luZyB2YXJpb3VzIGdvdmVybm9ycy4NCj4g
LSBkZXZmcmVxX2V2ZW50IGNsYXNzIChuZXcpDQo+ICA6IFByb3ZpZGUgbWVhc3VyZWQgcmF3IGRh
dGEgdG8gZGV2ZnJlcSBkZXZpY2UgZm9yIGdvdmVybm9yDQoNCk1lcmdlZCBpbiBteSBsb2NhbCBn
aXQgcmVwbyAoMS83IHRvIDMvNyBhcyB0aG9zZSB0aHJlZSBhcmUgaW4gL2RyaXZlcnMvZGV2ZnJl
cSkuDQoNCkhvd2V2ZXIsIHRoZSBhZG1pbiByZXF1aXJlcyBtZSB0byBzZXR1cCB0aGUgZmlyZXdh
bGwgYWdhaW4sIHNvIHBsZWFzZSB3YWl0DQphbm90aGVyIGRheSBmb3IgdGhlIG1lcmdlZCBwYXRj
aGVzIHRvIHNob3cgdXAgaW4gZXh0ZXJuYWwgbmV0d29yaw0KKGdpdC5rZXJuZWwub3JnKSBhbmQg
dG8gbWFrZSBhIHB1bGwtcmVxdWVzdCBmb3IgUmFmYWVsLg0KKHdhaXRpbmcgZmlyZXdhbGwgZXhl
Y3B0aW9uIGFwcHJvdmFscyBmcm9tIHRoZSBhZG1pbikNCg0KDQpDaGVlcnMsDQpNeXVuZ0pvbw0K
DQo=


