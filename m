From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: Re: [PATCHv3 2/8] devfreq: exynos: Add documentation for generic
 exynos memory bus frequency driver
Date: Tue, 13 Jan 2015 09:04:31 +0000 (GMT)
Message-ID: <1866237785.970311421139868224.JavaMail.weblogic@epmlwas05d>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:21617 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbAMJEu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jan 2015 04:04:50 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NI30011ZYJJQH10@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 13 Jan 2015 18:04:31 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, Rob Herring <robherring2@gmail.com>
Cc: "kgene@kernel.org" <kgene@kernel.org>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mark Rutland <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

DQpBY2tlZC1ieTogTXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+DQoNCg0K
QWRkaW5nIHRvIENoYW53b28ncyByZXBseToNCg0KSWYgSSB1bmRlcnN0YW5kIENoYW53b28ncyBp
bnRlbnRpb24gY29ycmVjdGx5LA0KdGhpcyBwYXRjaHNldCBpcyB0byBwcm92aWRlIGEgY29tbW9u
IGJ1cyAmIG1lbW9yeS1pbnRlcmZhY2UgRFZGUyBkcml2ZXINCmZvciBzZXZlcmFsIEV4eW5vcyBT
b0NzLCB3aGljaCBhbGxvd3MgRFQgdG8gZXhwcmVzcyBwZXItU29DIGhhcmR3YXJlDQpkZXRhaWxz
IHNvIHRoYXQgd2UgZG8gbm90IG5lZWQgdG8gaGFyZGNvZGUgdGhlbSB3aXRoIHNlcGVyYXRlZCBk
cml2ZXJzDQooYXMgaXQgaXMgbm93KSBvciBhIGRyaXZlciB3aXRoIGEgbG90IG9mIHVudXNlZCBk
ZWZpbml0aW9ucyAocGFydGx5DQphcyBpdCBpcyBub3cpLg0KDQpIYXZpbmcgdGhhdCBtYW55IGxv
b2tpbmcgdWdseSBmcmVxdWVuY3kgZGVmaW5pdGlvbnMgaXMNCmJlY2F1c2UgRXh5bm9zIFNvQ3Mg
dGhhdCBJJ3ZlIHNlZW4gdW50aWwgdG9kYXkgaGF2ZSBtYW55DQpvbi1Tb0MgSVBzIHRoYXQgc2hv
dWxkIGNoYW5nZSBjb25maWd1cmF0aW9ucyAodXN1YWxseSBjbG9jayBzcGVlZCkNCmFjY29yZGlu
ZyB0byB0aGUgY2xvY2sgc3BlZWQgb2YgYnVzLiBUaHVzLCB0aGV5IG1heSBsb29rDQpkdXBsaWNh
dGVkLg0KDQpXZSBtYXkgaGlkZSBzdWNoIGRldGFpbHMgSUYgd2UgbWFrZSBvbmUgZHJpdmVyIHBl
ciBTb0MgbW9kZWw7IGhvd2V2ZXIsDQppdCBpcyB2ZXJ5IGluZWZmaWNpZW50IHdpdGggRFQgc3Vw
cG9ydGVkIGtlcm5lbHMgaWYgd2UgY2FuIHdyaXRlDQpzdWNoIGRldGFpbHMgaW4gRFRTIGFuZCBt
YWtlIHRoZSBkcml2ZXIgc2ltcGxlIGFuZCB1bmlmaWVkLg0KDQoNCg0KQ2hlZXJzLA0KTXl1bmdK
b28uDQoNCj4gIA0KPiBIaSBSb2IsDQo+DQo+Rmlyc3Qgb2YgYWxsLCB0aGFua3MgZm9yIHlvdXIg
cmV2aWV3Lg0KPg0KPk9uIDAxLzA5LzIwMTUgMDY6MTggQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0K
Pj4gQWRkaW5nIFZpcmVzaC4NCj4+IA0KPj4gT24gV2VkLCBKYW4gNywgMjAxNSBhdCA3OjQwIFBN
LCBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4gd3JvdGU6DQo+Pj4gVGhpcyBw
YXRjaCBhZGRzIHRoZSBkb2N1bWVudGF0aW9uIGZvciBnZW5lcmljIGV4eW5vcyBtZW1vcnkgYnVz
IGZyZXF1ZW5jeQ0KPj4+IGRyaXZlci4NCj4+Pg0KPj4+IENjOiBNeXVuZ0pvbyBIYW0gPG15dW5n
am9vLmhhbUBzYW1zdW5nLmNvbT4NCj4+PiBDYzogS3l1bmdtaW4gUGFyayA8a3l1bmdtaW4ucGFy
a0BzYW1zdW5nLmNvbT4NCj4+PiBDYzogS3VramluIEtpbSA8a2dlbmVAa2VybmVsLm9yZz4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4NCj4+
PiAtLS0NCj4+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGV2ZnJlcS9leHlub3MtYnVzZnJl
cS50eHQgfCAxODQgKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAx
ODQgaW5zZXJ0aW9ucygrKQ0KPj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2RldmZyZXEvZXh5bm9zLWJ1c2ZyZXEudHh0DQo+Pj4NCg==


