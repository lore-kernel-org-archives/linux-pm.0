From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v4 02/20] PM / devfreq: exynos: Add documentation for
 generic exynos bus frequency driver
Date: Mon, 14 Dec 2015 08:40:04 +0000 (GMT)
Message-ID: <1393132421.659011450082398931.JavaMail.weblogic@epmlwas07b>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49551 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbbLNIkG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 03:40:06 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NZC01FFUAQSUU90@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 14 Dec 2015 17:40:04 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, =?utf-8?Q?=ED=81=AC=EC=89=AC=EC=8B=9C=ED=86=A0=ED=94=84?= <k.kozlowski@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

PiAgIA0KPiAgVGhpcyBwYXRjaCBhZGRzIHRoZSBkb2N1bWVudGF0aW9uIGZvciBnZW5lcmljIGV4
eW5vcyBidXMgZnJlcXVlbmN5DQo+IGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYW53
b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPg0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9m
IEtvemxvd3NraSA8ay5rb3psb3dza2lAc2Ftc3VuZy5jb20+DQoNCkEgbGl0dGxlIGNoYW5nZXMg
Zm9sbG93aW5nOg0KDQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGV2ZnJlcS9l
eHlub3MtYnVzLnR4dCAgICAgfCA5MyArKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgOTMgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kZXZmcmVxL2V4eW5vcy1idXMudHh0DQo+IA0KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RldmZyZXEvZXh5
bm9zLWJ1cy50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGV2ZnJlcS9l
eHlub3MtYnVzLnR4dA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAw
MDAuLmUzMmRhZWYzMjhkYQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kZXZmcmVxL2V4eW5vcy1idXMudHh0DQo+IEBAIC0wLDAgKzEs
OTMgQEANCj4gKyogR2VuZXJpYyBFeHlub3MgQnVzIGZyZXF1ZW5jeSBkZXZpY2UNCj4gKw0KPiAr
VGhlIFNhbXN1bmcgRXh5bm9zIFNvQyBoYXZlIG1hbnkgYnVzZXMgZm9yIGRhdGEgdHJhbnNmZXIg
YmV0d2VlbiBEUkFNDQoNCitUaGUgU2Ftc3VuZyBFeHlub3MgU29DIGhhcyBtYW55IGJ1c2VzIGZv
ciBkYXRhIHRyYW5zZmVyIGJldHdlZW4gRFJBTQ0KDQpvcg0KDQorVGhlIFNhbXN1bmcgRXh5bm9z
IFNvQ3MgaGF2ZSBtYW55IGJ1c2VzIGZvciBkYXRhIHRyYW5zZmVyIGJldHdlZW4gRFJBTQ0KKGJl
Y2F1c2UgeW91IGludGVuZCB0byBzdXBwb3J0IG11bGl0cGxlIEV4eW5vcyBTb0NzKQ0KDQo+ICth
bmQgc3ViLWJsb2NrcyBpbiBTb0MuIEFsbW9zdCBFeHlub3MgU29DIGhhdmUgdGhlIGNvbW1vbiBh
cmNoaXRlY3R1cmUNCg0KK2FuZCBzdWItYmxvY2tzIGluIFNvQy4gTW9zdCBFeHlub3MgU29DcyBz
aGFyZSB0aGUgY29tbW9uIGFyY2hpdGVjdHVyZQ0KDQo+ICtmb3IgYnVzZXMuIEdlbmVyYWxseSwg
dGhlIGVhY2ggYnVzIG9mIEV4eW5vcyBTb0MgaW5jbHVkZXMgdGhlIHNvdXJjZSBjbG9jaw0KDQor
Zm9yIGJ1c2VzLiBHZW5lcmFsbHksIGVhY2ggYnVzIG9mIEV4eW5vcyBTb0MgaW5jbHVkZXMgYSBz
b3VyY2UgY2xvY2sNCg0KPiArYW5kIHBvd2VyIGxpbmUgYW5kIHRoZW4gaXMgYWJsZSB0byBjaGFu
Z2UgdGhlIGNsb2NrIGFjY29yZGluZyB0byB0aGUgdXNhZ2UNCg0KK2FuZCBhIHBvd2VyIGxpbmUs
IHdoaWNoIGFyZSBhYmxlIHRvIGNoYW5nZSB0aGUgY2xvY2sgZnJlcXVlbmN5IA0KDQo+ICtvZiBl
YWNoIGJ1c2VzIG9uIHJ1bnRpbWUuIFdoZW4gZ2F0aGVyaW5nIHRoZSB1c2FnZSBvZiBlYWNoIGJ1
c2VzIG9uIHJ1bnRpbWUsDQoNCitvZiB0aGUgYnVzIGluIHJ1bnRpbWUuIFRvIG1vbml0b3IgdGhl
IHVzYWdlIG9mIGVhY2ggYnVzIGluIHJ1bnRpbWUsDQoNCj4gK3RoZSBkcml2ZXIgdXNlcyB0aGUg
UFBNVSAoUGxhdGZvcm0gUGVyZm9ybWFuY2UgTW9uaXRvcmluZyBVbml0KSB3aGljaA0KDQordGhl
IGRyaXZlciB1c2VzIHRoZSBQUE1VIChQbGF0Zm9ybSBQZXJmb3JtYW5jZSBNb25pdG9yaW5nIFVu
aXQpLCB3aGljaA0KDQo+ICtpcyBhYmxlIHRvIG1lYXN1cmUgdGhlIGN1cnJlbnQgbG9hZCBvZiBz
dWItYmxvY2tzLg0KPiArDQo+ICtUaGVyZSBhcmUgYSBsaXR0bGUgZGlmZmVyZW50IGNvbXBvc2l0
aW9uIGFtb25nIEV4eW5vcyBTb0MgYmVjYXVzZSBlYWNoIEV4eW5vcw0KPiArU29DIGhhcyB0aGUg
ZGlmZmVyZW50IHN1Yi1ibG9ja3MuIFNvLCB0aGlzIGRpZmZlcmVuY2Ugc2hvdWxkIGJlIHNwZWNp
ZmllZA0KDQorU29DIGhhcyBkaWZmZXJlbnQgc3ViLWJsb2Nrcy4gVGhlcmVmb3JlLCBzdWNoIGRp
ZmZlcmVuY2Ugc2hvdWxkIGJlIHNwZWNpZmllZA0KDQo+ICtpbiBkZXZpY2V0cmVlIGZpbGUgaW5z
dGVhZCBvZiBlYWNoIGRldmljZSBkcml2ZXIuIEluIHJlc3VsdCwgdGhpcyBkcml2ZXINCj4gK2lz
IGFibGUgdG8gc3VwcG9ydCB0aGUgYnVzIGZyZXF1ZW5jeSBmb3IgYWxsIEV4eW5vcyBTb0NzLg0K
PiArDQpbXQ0K


