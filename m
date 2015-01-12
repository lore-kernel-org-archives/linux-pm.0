From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCHv7 05/10] devfreq: event: Add documentation for exynos-ppmu
 devfreq-event driver
Date: Mon, 12 Jan 2015 08:11:25 +0000 (GMT)
Message-ID: <905389780.892831421050282747.JavaMail.weblogic@epmlwas09a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37760 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbbALIL1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 03:11:27 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NI200MNL1F1CD30@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 12 Jan 2015 17:11:25 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

DQpJIGhhdmUgcmVwaHJhc2VkIHBhcnQgb2YgdGhlIGRvY3VtZW50YXRpb24gZm9yIGJldHRlciBy
ZWFkYWJpbGl0eS4NClNvbWUgc2VtYW50aWNzIGlzIGd1ZXNzZWQgc28geW91IG1heSBuZWVkIHRv
IHJlLXJlcGhyYXNlLg0KDQpPdGhlciB0aGFuIHRoYXQsIEFja2VkLWJ5OiBNeXVuZ0pvbyBIYW0g
PG15dW5nam9vLmhhbUBzYW1zdW5nLmNvbT4NCg0KDQo+ICBUaGlzIHBhdGNoIGFkZHMgdGhlIGRv
Y3VtZW50YXRpb24gZm9yIEV4eW5vcyBQUE1VIChQbGF0Zm9ybSBQZXJmb3JtYW5jZQ0KPiBNb25p
dG9yaW5nIFVuaXQpIGRldmZyZXEtZXZlbnQgZHJpdmVyLg0KPiANCj4gQ2M6IE15dW5nSm9vIEhh
bSA8bXl1bmdqb28uaGFtQHNhbXN1bmcuY29tPg0KPiBDYzogS3l1bmdtaW4gUGFyayA8a3l1bmdt
aW4ucGFya0BzYW1zdW5nLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hhbndvbyBDaG9pIDxjdzAw
LmNob2lAc2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiAgLi4uL2JpbmRpbmdzL2RldmZyZXEvZXZlbnQv
ZXh5bm9zLXBwbXUudHh0ICAgICAgICAgfCAxMTAgKysrKysrKysrKysrKysrKysrKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTEwIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGV2ZnJlcS9ldmVudC9leHlub3MtcHBt
dS50eHQNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZGV2ZnJlcS9ldmVudC9leHlub3MtcHBtdS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGV2ZnJlcS9ldmVudC9leHlub3MtcHBtdS50eHQNCj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uZTY2NWQzMA0KPiAtLS0gL2Rldi9udWxsDQo+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kZXZmcmVxL2V2ZW50L2V4eW5v
cy1wcG11LnR4dA0KPiBAQCAtMCwwICsxLDExMCBAQA0KPiArDQo+ICsqIFNhbXN1bmcgRXh5bm9z
IFBQTVUgKFBlcmZvcm1hbmNlIFByb2ZpbGluZyBNb25pdG9yaW5nIFVuaXQpIGRldmljZQ0KPiAr
DQo+ICtUaGUgU2Ftc3VuZyBFeHlub3MgU29DIGhhdmUgUFBNVSAoUGVyZm9ybWFuY2UgUHJvZmls
aW5nIE1vbml0b3JpbmcgVW5pdCkgZm9yDQoNClRoZSBTYW1zdW5nIEV4eW5vcyBTb0MgaGFzIFBQ
TVUgKFBlcmZvcm1hbmNlIFByb2ZpbGluZyBNb25pdG9yaW5nIFVuaXQpIGZvcg0KKGhhdmUtPmhh
cykNCg0KPiArZWFjaCBJUHMuIFBQTVUgcHJvdmlkZXMgdGhlIHByaW1pdGl2ZSB2YWx1ZXMgdG8g
Z2V0IHBlcmZvcm1hbmNlIGRhdGEuIFRoZXNlDQoNCmVhY2ggSVAuIFBQTVUgcHJvdmlkZXMgcHJp
bWl0aXZlIHZhbHVlcyB0byBnZXQgcGVyZm9ybWFuY2UgZGF0YS4NCihJUHMtPklQKQ0KDQo+ICtl
dmVudHMgcHJvdmlkZSB1c2VmdWwgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGJlaGF2aW9yIG9mIHRo
ZSBTb0MgdGhhdCB5b3UgY2FuDQoNClBQTVUgZXZlbnRzIHByb3ZpZGUgaW5mb3JtYXRpb24gb2Yg
dGhlIFNvQydzIGJlaGF2aW9ycyBzbyB0aGF0IHlvdSBtYXkNCg0KPiArdXNlIHdoZW4gYW5hbHl6
aW5nIHN5c3RlbSBwZXJmb3JtYW5jZSwgYW5kIG1hZGUgdmlzaWJsZSBhbmQgY2FuIGJlIGNvdW50
ZWQNCg0KdXNlIHRvIGFuYWx5emUgc3lzdGVtIHBlcmZvcm1hbmNlLCB0byBtYWtlIGJlaGF2aW9y
cyB2aXNpYmxlLCBhbmQgdG8gY291bnQNCg0KPiArdXNpbmcgbG9naW4gaW4gZWFjaCBJUCAoRE1D
LCBDUFUsIFJJR0hUQlVTLCBMRUZUQlVTLCBDQU0gaW50ZXJmYWNlLCBMQ0QsIEczRCwNCg0KdXNh
Z2VzIG9mIGVhY2ggSVAgKCAuLi4uICkNCg0KPiArTUZDKS4gVGhlIEV4eW5vcyBQUE1VIGRyaXZl
ciB1c2UgdGhlIGRldmZyZXEtZXZlbnQgY2xhc3MgdG8gcHJvdmlkZSBldmVudCBkYXRhDQoNCnVz
ZSAtPiB1c2VzDQoNCj4gK3RvIHZhcmlvdXMgZGV2ZnJlcSBkZXZpY2UuIFRoZSBkZXZmcmVxIGRl
dmljZSB3b3VsZCB1c2UgdGhlIGV2ZW50IGRhdGEgd2hlbg0KDQpkZXZpY2UgLT4gZGV2aWNlcw0K
DQo+ICtkZXJ0ZXJtaW5nIHRoZSBjdXJyZW50IHN0YXRlIG9mIGVhY2ggSVAuDQo+ICsNCj4gK1Jl
cXVpcmVkIHByb3BlcnRpZXM6DQo+ICstIGNvbXBhdGlibGU6IFNob3VsZCBiZSAic2Ftc3VuZyxl
eHlub3MtcHBtdSIuDQo+ICstIHJlZzogcGh5c2ljYWwgYmFzZSBhZGRyZXNzIG9mIGVhY2ggUFBN
VSBhbmQgbGVuZ3RoIG9mIG1lbW9yeSBtYXBwZWQgcmVnaW9uLg0KPiArDQo+ICtPcHRpb25hbCBw
cm9wZXJ0aWVzOg0KPiArLSBjbG9jay1uYW1lcyA6IHRoZSBuYW1lIG9mIGNsb2NrIHVzZWQgYnkg
dGhlIFBQTVUsICJwcG11Ig0KPiArLSBjbG9ja3MgOiBwaGFuZGxlcyBmb3IgY2xvY2sgc3BlY2lm
aWVkIGluICJjbG9jay1uYW1lcyIgcHJvcGVydHkNCj4gKy0gI2Nsb2NrLWNlbGxzOiBzaG91bGQg
YmUgMS4NCj4gKw0KDQpbXQ0K


