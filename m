From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCHv7 07/10] ARM: dts: Add PPMU dt node for Exynos4 SoCs
Date: Mon, 12 Jan 2015 09:49:54 +0000 (GMT)
Message-ID: <1120420862.904031421056191722.JavaMail.weblogic@epmlwas01a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50279 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbALJt4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 04:49:56 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NI200DL15Z6EP90@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 12 Jan 2015 18:49:54 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

PiAgIA0KPiAgVGhpcyBwYXRjaCBhZGQgUFBNVSAoUGxhdGZvcm0gUGVyZm9ybWFuY2UgTW9uaXRv
cmluZyBVbml0KSBkdCBub2RlIGZvciBFeHlub3M0DQo+IChFeHlub3M0MjEwLzQyMTIvNDQxMikg
U29DLiBQUE1VIGR0IG5vZGUgaXMgdXNlZCB0byBtb25pdG9yIHRoZSB1dGlsaXphdGlvbiBvZg0K
PiBlYWNoIElQLg0KPiANCj4gVGhlIEV4eW5vczQyMTAvRXh5bm9zNDIxMi9FeHlub3M0NDEyIFNv
QyBpbmNsdWRlcyBmb2xsb3dpbmcgUFBNVXM6DQo+IC0gUFBNVV9ETUMwICAgICAgMHgxMDZBXzAw
MDANCj4gLSBQUE1VX0RNQzEgICAgICAweDEwNkJfMDAwMA0KPiAtIFBQTVVfQ1BVICAgICAgIDB4
MTA2Q18wMDAwDQo+IC0gUFBNVV9BQ1AgICAgICAgMHgxMEFFXzAwMDANCj4gLSBQUE1VX1JJR0hU
X0JVUyAweDExMkFfMDAwMA0KPiAtIFBQTVVfTEVGVF9CVVMgIDB4MTE2QV8wMDAwDQo+IC0gUFBN
VV9GU1lTICAgICAgMHgxMjYzXzAwMDANCj4gLSBQUE1VX0xDRDAgICAgICAweDExRTRfMDAwMA0K
PiAtIFBQTVVfQ0FNSUYgICAgIDB4MTFBQ18wMDAwDQo+IC0gUFBNVV9JTUFHRSAgICAgMHgxMkFB
XzAwMDANCj4gLSBQUE1VX1RWICAgICAgICAweDEyRTRfMDAwMA0KPiAtIFBQTVVfM0QgICAgICAg
IDB4MTMyMl8wMDAwDQo+IC0gUFBNVV9NRkNfTEVGVCAgMHgxMzY2XzAwMDANCj4gLSBQUE1VX01G
Q19SSUdIVCAweDEzNjdfMDAwMA0KPiANCj4gQWRkaXRpb25hbGx5LCB0aGUgRXh5bm9zNDIxMCBT
b0MgaW5jbHVkZXMgZm9sbG93aW5nIFBQTVVzOg0KPiAtIFBQTVVfTENEMSAgICAgIDB4MTIyNF8w
MDAwDQo+IA0KPiBDYzogS3VramluIEtpbSA8a2dlbmVAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9m
Zi1ieTogQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiAgYXJj
aC9hcm0vYm9vdC9kdHMvZXh5bm9zNC5kdHNpICAgIHwgMTA4ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL2FybS9ib290L2R0cy9leHlub3M0MjEwLmR0c2kg
fCAgIDggKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDExNiBpbnNlcnRpb25zKCspDQo+IA0KDQpB
Y2tlZC1ieTogTXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+DQoNCg==


