From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 2/3] PM / devfreq: tegra: add devfreq driver for Tegra
 Activity Monitor
Date: Tue, 25 Nov 2014 07:07:33 +0000 (GMT)
Message-ID: <715439136.113681416899252854.JavaMail.weblogic@epmlwas08c>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13038 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbaKYHHi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 02:07:38 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NFL006Q22GLCJ00@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 25 Nov 2014 16:07:33 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

PiBUaGUgQUNUTU9OIGJsb2NrIGNhbiBtb25pdG9yIHNldmVyYWwgY291bnRlcnMsIHByb3ZpZGlu
ZyBhdmVyYWdpbmcgYW5kIGZpcmluZw0KPiBpbnRlcnJ1cHRzIGJhc2VkIG9uIHdhdGVybWFya2lu
ZyBjb25maWd1cmF0aW9uLiBUaGlzIGltcGxlbWVudGF0aW9uIG1vbml0b3JzDQo+IHRoZSBNQ0FM
TCBhbmQgTUNDUFUgY291bnRlcnMgdG8gY2hvb3NlIGFuIGFwcHJvcHJpYXRlIGZyZXF1ZW5jeSBm
b3IgdGhlDQo+IGV4dGVybmFsIG1lbW9yeSBjbG9jay4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgYmFz
ZWQgb24gd29yayBieSBBbGV4IEZyaWQgPGFmcmlkQG52aWRpYS5jb20+IGFuZCBNaWtrbw0KPiBQ
ZXJ0dHVuZW4gPG1pa2tvLnBlcnR0dW5lbkBrYXBzaS5maT4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBUb21ldSBWaXpvc28gPHRvbWV1LnZpem9zb0Bjb2xsYWJvcmEuY29tPg0KDQpTaWduZWQtb2Zm
LWJ5OiBNeXVuZ0pvbyBIYW0gPG15dW5nam9vLmhhbUBzYW1zdW5nLmNvbT4NCg0KSG93IGFyZSB5
b3UgZ29pbmcgdG8gaW50ZWdyYXRlIG90aGVyIHR3byBwYXRjaGVzPw0KTWF5IEkganVzdCBnbyBh
aGVhZCB3aXRoIHRoaXMgcGF0Y2ggb25seT8NCg0KDQpDaGVlcnMsDQpNeXVuZ0pvby4NCg0KPiAN
Cj4gLS0tDQo+IA0KPiB2MjoJKiBVc2UgZGV2ZnJlcQ0KPiAtLS0NCj4gIGRyaXZlcnMvZGV2ZnJl
cS9LY29uZmlnICAgICAgICAgfCAgMTAgKw0KPiAgZHJpdmVycy9kZXZmcmVxL01ha2VmaWxlICAg
ICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2RldmZyZXEvdGVncmEtZGV2ZnJlcS5jIHwgNzE4ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdl
ZCwgNzI5IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2RldmZy
ZXEvdGVncmEtZGV2ZnJlcS5jDQo+IA0K


