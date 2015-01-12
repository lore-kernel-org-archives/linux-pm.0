From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: Re: [PATCHv7 00/10] devfreq: Add devfreq-event class to provide
 raw data for devfreq device
Date: Mon, 12 Jan 2015 10:18:14 +0000 (GMT)
Message-ID: <948926965.905951421057891449.JavaMail.weblogic@epmlwas01a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64446 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbbALKSQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 05:18:16 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NI2002G67AF6WC0@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 12 Jan 2015 19:18:15 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>
Cc: "kgene@kernel.org" <kgene@kernel.org>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

PiAgDQo+IE9uIDAxLzEyLzIwMTUgMDY6NTggUE0sIE15dW5nSm9vIEhhbSB3cm90ZToNCj4+PiAg
IA0KPj4+ICBUaGlzIHBhdGNoc2V0IGFkZCBuZXcgZGV2ZnJlcV9ldmVudCBjbGFzcyB0byBwcm92
aWRlIHJhdyBkYXRhIHRvIGRldGVybWluZQ0KPj4+IGN1cnJlbnQgdXRpbGl6YXRpb24gb2YgZGV2
aWNlICB3aGljaCBpcyB1c2VkIGZvciBkZXZmcmVxIGdvdmVybm9yLg0KPj4+DQo+Pj4gVGhlIGZv
bGxvd2luZyBkZXNjcmlwdGlvbiBleHBsYWlucyB0aGUgZmVhdHVyZSBvZiB0d28ga2luZCBvZiBk
ZXZmcmVxIGNsYXNzOg0KPj4+IC0gZGV2ZnJlcSBjbGFzcyAoZXhpc3RpbmcpDQo+Pj4gIDogZGV2
ZnJlcSBjb25zdW1lciBkZXZpY2UgdXNlIHJhdyBkYXRhIGZyb20gZGV2ZnJlcV9ldmVudCBkZXZp
Y2UgZm9yDQo+Pj4gICAgZGV0ZXJtaW5pbmcgcHJvcGVyIGN1cnJlbnQgc3lzdGVtIHN0YXRlIGFu
ZCBjaGFuZ2Ugdm9sdGFnZS9mcmVxdWVuY3kNCj4+PiAgICBkeW5hbWljYWxseSB1c2luZyB2YXJp
b3VzIGdvdmVybm9ycy4NCj4+PiAtIGRldmZyZXFfZXZlbnQgY2xhc3MgKG5ldykNCj4+PiAgOiBQ
cm92aWRlIG1lYXN1cmVkIHJhdyBkYXRhIHRvIGRldmZyZXEgZGV2aWNlIGZvciBnb3Zlcm5vcg0K
Pj4+DQo+PiANCj4+IFF1ZXN0aW9uOiBBcHBseWluZyB0aGlzIHBhdGNoc2V0IHNlZW1zIHRvIGlt
cGx5IHRoYXQNCj4+IGRyaXZlcnMvZGV2ZnJlcS9leHlub3MvZXh5bm9zX3BwbXUuYyBiZWNvbWVz
IG9ic29sZXRlLg0KPj4gSG93IGRvIHlvdSB3YW50IHRvIGFkZHJlc3MgaXQ/IERvIHlvdSB0aGlu
ayBpdCdkIGJlIG9rIHRvIHJlbW92ZQ0KPj4gdGhzZSBvYnNvbGV0ZSBkcml2ZXJzIGFmdGVyIHlv
dXIgc3VjY2Vzc2luZyBwYXRjaHNldD8NCj4+IA0KPj4gSWYgaXQgaXMgb2sgdG8gcmVtb3ZlIG9s
ZCBkcml2ZXJzIGFmdGVyIGFwcGx5aW5nIHRoZSBuZXcgcGF0Y2hzZXQsDQo+PiBwbGVhc2UgaW5j
bGRlIGEgcGF0Y2ggdGhhdCByZW1vdmVzIG9sZCBkcml2ZXJzIHVubGVzcyBzdWNoIGEgcmVtb3Zh
bA0KPj4gbWlnaHQgcmVzdWx0IGluIGNvbXBhdGliaWxpdHkgaXNzdWVzIHdpdGggb2xkICh5ZXQg
YW5vdGhlciBvYnNvbGV0ZSkNCj4+IGJvYXJkIGZpbGVzLCB3aGljaCBJIGRvbid0IHRoaW5rIHBy
b2JhYmxlLg0KPg0KPkkgYWdyZWUgdG8gcmVtb3ZlICdkcnZpZXJzL2RldmZyZXEvZXh5bm9zL2V4
eW5vc19wcG11LmMuDQo+QnV0LCBleGlzdGluZyBleHlub3NfcHBtdS5jIHdhcyB1c2VkIGZvciBk
cml2ZXJzL2RldmZyZXEvZXh5bm9zL2V4eW5vczVfYnVzLmMuDQo+DQo+QmVmb3JlIHJlbW92aW5n
IGV4aXN0aW5nICdleHlub3NfcHBtdS5jJywgbWlnaHQgbmVlZCB0byB0ZXN0IHRoZSBkZXZmcmVx
LWV2ZW50IGNsYXNzDQo+b24gRXh5bm9zNTI2MCBTb0MuIEkgd2lsbCBqdXN0IHJlbW92ZSBvbGQg
ZHJpdmVyKCdkcml2ZXJzL2RldmZyZXEvZXh5bm9zL2V4eW5vczRfYnVzLntjfGh9JykNCj5vbiBu
ZXh0IHBhdGNoc2V0Lg0KDQpUaGF0J3MgZmluZSB3aXRoIG1lLg0KDQoNCkNoZWVycywNCk15dW5n
Sm9vDQoNCj4NCj5UbyBBYmhpbGFzaCwNCj5Db3VsZCB5b3UgdGVzdCB0aGlzIHBhdGNoLXNldCBv
biBFeHlub3M1MjYwIFNvQz8NCj4NCj5CZXN0IFJlZ2FyZHMsDQo+Q2hhbndvbyBDaG9pDQo=


