From: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable
 'cpu_mask'
Date: Tue, 2 Sep 2014 07:02:37 +0000
Message-ID: <9fde1bf81522480484897416019b0ee9@BY2PR03MB570.namprd03.prod.outlook.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
	<6a145a322bd64e14a2d94e8c40151bbe@BY2PR03MB570.namprd03.prod.outlook.com>
 <CAKohpokQo=Jqgj2CzTH41WbD6F1GpdhksWdg0dm8WLN_CT5KkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2lp0242.outbound.protection.outlook.com ([207.46.163.242]:9237
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751105AbaIBHCk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Sep 2014 03:02:40 -0400
In-Reply-To: <CAKohpokQo=Jqgj2CzTH41WbD6F1GpdhksWdg0dm8WLN_CT5KkA@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hongbo Zhang <hongbo.zhang@freescale.com>, "LeoLi@freescale.com" <LeoLi@freescale.com>

SSBhbSBzYXlpbmcgeW91ciBwYXRjaCAyIHByb2JhYmx5IGlzIHdyb25nLCBub3QgcGF0Y2ggMS4N
CkNvbnNpZGVyIGZvbGxvd2luZyBjYXNlOg0KT24gVDQyNDAgcGxhdGZvcm0sIHdlIGhhdmUgMyBj
bHVzdGVyIHdpdGggOCBjcHUgaW4gZWFjaCBjbHVzdGVyLg0KV2Ugb2ZmbGluZSA0IDUgNiA3IGNw
dSBhbmQgdGhlbiBvbmxpbmUgdGhlbSBiYWNrLg0KQ3B1IDQncyBwb2xpY3ktPmNwdXMgaXMgMCwg
MSwgMiwgMywgNCANCkNwdSA1J3MgcG9saWN5LT5jcHVzIGlzIDAsIDEsIDIsIDMsIDQsIDUuDQou
Li4uDQpTbyBjcHUgNCBhbmQgNSdzIHBvbGljeS0+Y3B1cyBhcmUgbm90IHJpZ2h0LCB0aGV5IHNo
b3VsZCBiZSAwLCAxLCAyLCAzLCA0LCA1LCA2LCA3Lg0KDQpUaGFua3MsDQpZdWFudGlhbg0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciBbbWFpbHRv
OnZpcmVzaC5rdW1hckBsaW5hcm8ub3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMDIs
IDIwMTQgMjo0OSBQTQ0KPiBUbzogVGFuZyBZdWFudGlhbi1CMjk5ODMNCj4gQ2M6IFJhZmFlbCBX
eXNvY2tpOyBsaW5hcm8ta2VybmVsQGxpc3RzLmxpbmFyby5vcmc7IGxpbnV4LXBtQHZnZXIua2Vy
bmVsLm9yZzsNCj4gWmhhbmcgSG9uZ2JvLUI0NTkzOTsgTGkgWWFuZy1MZW8tUjU4NDcyDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBjcHVmcmVxOiBwcGMtY29yZW5ldDogcmVtb3ZlIHBlci1j
cHUgdmFyaWFibGUNCj4gJ2NwdV9tYXNrJw0KPiANCj4gT24gMiBTZXB0ZW1iZXIgMjAxNCAxMjox
NiwgWXVhbnRpYW4gVGFuZyA8WXVhbnRpYW4uVGFuZ0BmcmVlc2NhbGUuY29tPg0KPiB3cm90ZToN
Cj4gPiBIZWxsbyBWaXJlc2g6DQo+ID4NCj4gPiBQcm9iYWJseSBpdCBpcyBub3QgcmlnaHQgY29u
c2lkZXJpbmcgdGhlIENQVSBjbHVzdGVyIGFuZCBDUFUgaG90cGx1ZyBjYXNlLg0KPiANCj4gU28g
aW4gY2FzZSBvZiBob3RwbHVnIHRoZSB3b3JzdCB0aGF0IGNhbiBoYXBwZW4gaXMgcG9saWN5LT5j
cHUgZ2V0cyB1cGRhdGVkLg0KPiBCdXQgYmVjYXVzZSB3ZSBhcmUgYWxsIGNvbmNlcm5lZCBhYm91
dCBjcHVfZGF0YSBoZXJlLCB3aGljaCBpcyBzdG9yZWQgaW4NCj4gcGVyLWNwdSB2YXJpYWJsZXMg
YW5kIGlzIHVwZGF0ZWQgZm9yIGFsbCBvbmxpbmUgQ1BVcywgaXQgc2hvdWxkIHdvcmsuDQo+IA0K
PiBJIHdvdWxkIGxpa2UgdG8gc2VlIGhvdyB0aGF0IGZhaWxzIDopDQo=
