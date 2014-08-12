From: =?euc-kr?B?x9S47cHW?= <myungjoo.ham@samsung.com>
Subject: Re: RE: [PATCH 1/2] PM / devfreq: Export helper functions for drivers
Date: Tue, 12 Aug 2014 23:37:25 +0000 (GMT)
Message-ID: <2126088679.390471407886644188.JavaMail.weblogic@epmlwas02a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:41494 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbaHLXh1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Aug 2014 19:37:27 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NA700DKTWADYD60@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 13 Aug 2014 08:37:25 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Hernandez, Carlos" <ceh@ti.com>, Punit Agrawal <punit.agrawal@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Cc: "orjan.eide@arm.com" <orjan.eide@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>

DQoNCj4gLS0tLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tLS0NCj4gU2VuZGVyIDogSGVybmFu
ZGV6LCBDYXJsb3M8Y2VoQHRpLmNvbT4NCj4gRGF0ZSA6IDIwMTQtMDgtMTIgMjI6NDkgKEdNVCsw
OTowMCkNCj4gVGl0bGUgOiBSRTogW1BBVENIIDEvMl0gUE0gLyBkZXZmcmVxOiBFeHBvcnQgaGVs
cGVyIGZ1bmN0aW9ucyBmb3IgZHJpdmVycw0KPiANCj4gQWNrZWQtQnk6IENhcmxvcyBIZXJuYW5k
ZXogDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1rZXJu
ZWwtb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgta2VybmVsLW93bmVyQHZnZXIu
a2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIFB1bml0IEFncmF3YWwNCj4gU2VudDogRnJpZGF5LCBK
dWx5IDE4LCAyMDE0IDEwOjEwIEFNDQo+IFRvOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LXNhbXN1bmctc29jQHZnZXIua2VybmVsLm9yZw0KPiBDYzogb3JqYW4uZWlkZUBhcm0uY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IE15dW5nSm9vIEhhbTsgS3l1bmdtaW4gUGFyaw0KPiBTdWJqZWN0OiBbUEFU
Q0ggMS8yXSBQTSAvIGRldmZyZXE6IEV4cG9ydCBoZWxwZXIgZnVuY3Rpb25zIGZvciBkcml2ZXJz
DQo+IA0KPiBGcm9tOiCoqnJqYW4gRWlkZSANCj4gDQo+IFRoZXNlIGZ1bmN0aW9ucyBhcmUgaW5k
ZW5kZWQgZm9yIHVzZSBieSBkcml2ZXJzIGFuZCBzaG91bGQgYmUgYXZhaWxhYmxlIGFsc28gd2hl
biB0aGUgZHJpdmVyIGlzIGJ1aWx0IGFzIGEgbW9kdWxlLj4gDQo+IA0KPiBDYzogTXl1bmdKb28g
SGFtIA0KPiBDYzogS3l1bmdtaW4gUGFyayANCj4gU2lnbmVkLW9mZi1ieTogqKpyamFuIEVpZGUg
DQoNCkFja2VkLWJ5OiBNeXVuZ0pvbyBIYW0gPG15dW5nam9vLmhhbUBzYW1zdW5nLmNvbT4NCg0K
VGhlcmUgd2lsbCBiZSBzb21lIG1vZGlmaWNhdGlvbnMgdG8gdGhpcyBwYXRjaCBmb3IgY29uc2lz
dGVuY3kgd2l0aCBvdGhlciBwZW5kaW5nIHBhdGNoZXMsIGJ1dCBwbGVhc2UgZG9uJ3Qgd29ycnkg
YWJvdXQgdGhlbS4gSSdsbCBoYW5kbGUgdGhlbSB3aGlsZSBtZXJnaW5nIHRoaXMuDQoNCg0KQ2hl
ZXJzLA0KTXl1bmdKb28uDQoNCj4gLS0tDQo+IGRyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgfCAg
ICAzICsrKw0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCg0KDQotLQ0KTXl1
bmdKb28gSGFtICjH1LjtwdYpLCBQSEQNCkZyb250aWVyIENTIExhYiwgU29mdHdhcmUgQ2VudGVy
DQpTYW1zdW5nIEVsZWN0cm9uaWNzDQpDZWxsOiArODItMTAtNjcxNC0yODU4


