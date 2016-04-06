From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v7 09/20] PM / devfreq: exynos: Remove unused exynos4/5
 busfreq driver
Date: Wed, 06 Apr 2016 10:36:43 +0000 (GMT)
Message-ID: <1047512321.170601459938997028.JavaMail.weblogic@ep2mlwas02a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48108 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbcDFKgp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 06:36:45 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O5702QBSK573IE0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 06 Apr 2016 19:36:43 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, =?utf-8?Q?=ED=81=AC=EC=89=AC=EC=8B=9C=ED=86=A0=ED=94=84?= <k.kozlowski@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "m.reichl@fivetechno.de" <m.reichl@fivetechno.de>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"devicetree@vger.kernel.org" <devicetree@>

PiBUaGlzIHBhdGNoIHJlbW92ZXMgdGhlIHVudXNlZCBleHlub3M0LzUgYnVzZnJlcSBkcml2ZXIu
IEluc3RlYWQsDQo+IGdlbmVyaWMgZXh5bm9zLWJ1cyBmcmVxdWVuY3kgZHJpdmVyIHN1cHBvcnQg
dGhlIGFsbCBFeHlub3MgU29Dcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYW53b28gQ2hvaSA8
Y3cwMC5jaG9pQHNhbXN1bmcuY29tPg0KDQpTaWduZWQtb2ZmLWJ5OiBNeXVuZ0pvbyBIYW0gPG15
dW5nam9vLmhhbUBzYW1zdW5nLmNvbT4NCg0KQmVmb3JlIG1lcmdpbmcsIGxldCBtZSB2aXNpdCB5
b3UgYW5kIHNlZSBob3cgaXQgd29ya3MNCmZvciBFeHlub3M0IGFuZCBFeHlub3M1IGRldmljZXMg
YWZ0ZXIgdGhpcyBwYXRjaC4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZGV2ZnJlcS9LY29uZmlnICAg
ICAgICAgICAgICB8ICAgMjIgLQ0KPiAgZHJpdmVycy9kZXZmcmVxL01ha2VmaWxlICAgICAgICAg
ICAgIHwgICAgMiAtDQo+ICBkcml2ZXJzL2RldmZyZXEvZXh5bm9zL01ha2VmaWxlICAgICAgfCAg
ICAzIC0NCj4gIGRyaXZlcnMvZGV2ZnJlcS9leHlub3MvZXh5bm9zNF9idXMuYyB8IDEwNTUgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9kZXZmcmVxL2V4eW5v
cy9leHlub3M0X2J1cy5oIHwgIDExMCAtLS0tDQo+ICBkcml2ZXJzL2RldmZyZXEvZXh5bm9zL2V4
eW5vczVfYnVzLmMgfCAgNDMxIC0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2RldmZyZXEvZXh5
bm9zL2V4eW5vc19wcG11LmMgfCAgMTE5IC0tLS0NCj4gIGRyaXZlcnMvZGV2ZnJlcS9leHlub3Mv
ZXh5bm9zX3BwbXUuaCB8ICAgODYgLS0tDQo+ICA4IGZpbGVzIGNoYW5nZWQsIDE4MjggZGVsZXRp
b25zKC0pDQo=


