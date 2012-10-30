From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: Re: [linux-next PATCH] PM / devfreq: documentation cleanups for
 devfreq header
Date: Tue, 30 Oct 2012 08:09:08 +0000 (GMT)
Message-ID: <31002982.486491351584547433.JavaMail.weblogic@epv6ml03>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:29957 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab2J3IJL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Oct 2012 04:09:11 -0400
Received: from epcpsbge4.samsung.com (epcpsbge4 [203.254.230.14])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCP00FE7572MBG0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 30 Oct 2012 17:09:09 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Nishanth Menon <nm@ti.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rajagopal Venkat <rajagopal.venkat@linaro.org>, =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?euc-kr?Q?=C0=CC=C1=BE=C8=AD?= <jonghwa3.lee@samsung.com>

PiBPbiAxMC8yOS8yMDEyIDA2OjAyIEFNLCBOaXNoYW50aCBNZW5vbiB3cm90ZToNCj4gDQo+ID4g
c3RydWN0IHBhcmFtZXRlcnMgbmVlZCB0byBoYXZlICc6JyBpbiBkb2N1bWVudGF0aW9uIGZvcg0K
PiA+IHNjcmlwdHMva2VybmVsLWRvYyB0byBwYXJzZSBhcHByb3ByaWF0ZWx5Lg0KPiA+IA0KPiA+
IEZpeCB0aGUgZXJyb3JzIHJlcG9ydGVkIGJ5Og0KPiA+IC4vc2NyaXB0cy9rZXJuZWwtZG9jIGlu
Y2x1ZGUvbGludXgvZGV2ZnJlcS5oID4vZGV2L251bGwNCj4gPiANCj4gPiBDYzogUmFqYWdvcGFs
IFZlbmthdCA8cmFqYWdvcGFsLnZlbmthdEBsaW5hcm8ub3JnPg0KPiA+IENjOiBNeXVuZ0pvbyBI
YW0gPG15dW5nam9vLmhhbUBzYW1zdW5nLmNvbT4NCj4gPiBDYzogS3l1bmdtaW4gUGFyayA8a3l1
bmdtaW4ucGFya0BzYW1zdW5nLmNvbT4NCj4gPiBDYzogIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmp3
QHNpc2sucGw+DQo+ID4gQ2M6IEtldmluIEhpbG1hbiA8a2hpbG1hbkB0aS5jb20+DQo+ID4gQ2M6
IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmlzaGFudGggTWVub24gPG5tQHRpLmNv
bT4NCj4gDQo+IA0KPiBBY2tlZC1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQHhlbm90aW1lLm5l
dD4NCj4gDQo+IFRoYW5rcy4NCg0KQWNrZWQtYnk6IE15dW5nSm9vIEhhbSA8bXl1bmdqb28uaGFt
QHNhbXN1bmcuY29tPg0KDQpBcHBseWluZyB0byBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvbXp4L2RldmZyZXEuZ2l0IGZvci1yYWZhZWwsIHdoaWNoIGlzIGJh
c2VkIG9uIHJhZmFlbCdzIGxpbnV4LXBtLmdpdCAvIGxpbnV4LW5leHQuDQoNCmh0dHA6Ly9naXQu
a2VybmVsLm9yZy8/cD1saW51eC9rZXJuZWwvZ2l0L216eC9kZXZmcmVxLmdpdDthPXNob3J0bG9n
O2g9cmVmcy9oZWFkcy9mb3ItcmFmYWVsDQoNCkknbGwgYXBwbHkgeW91ciAiQWRkIHN5c2ZzIG5v
ZGUgLi4uIiBwYXRjaCBhZnRlciByZWZhY3RvcmluZyB3aXRoIEpvbmdod2EncyAoZGV2ZnJlcSB0
cmFuc19zdGF0KSBhcyB0aGUgdHdvIHBhdGNoZXMgdXNlIHRoZSBzYW1lIGRhdGEgKGxpc3Qgb2Yg
YXZhaWxhYmxlIGZyZXFzKS4NCg0KQ2hlZXJzLA0KTXl1bmdKb28NCg0KPiANCj4gPiAtLS0NCj4g
PiBBcHBsaWVzIG9uDQo+ID4gbGludXgtbmV4dCAgICAgICAgICAgICAgICBlMDgzZmViIE1lcmdl
IGJyYW5jaCAnYWNwaS1uZXh0JyBpbnRvIGxpbnV4LW5leHQNCj4gPiBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcmFmYWVsL2xpbnV4LXBtLmdpdA0KPiA+IA0K
PiA+ICBpbmNsdWRlL2xpbnV4L2RldmZyZXEuaCB8ICAgNTQgKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2Vy
dGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiA+IA0K


