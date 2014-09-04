From: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable
 'cpu_mask'
Date: Thu, 4 Sep 2014 04:33:39 +0000
Message-ID: <2248223d9db143108dc32ad5f43a145e@BY2PR03MB570.namprd03.prod.outlook.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
	<6a145a322bd64e14a2d94e8c40151bbe@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpokQo=Jqgj2CzTH41WbD6F1GpdhksWdg0dm8WLN_CT5KkA@mail.gmail.com>
	<9fde1bf81522480484897416019b0ee9@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpo=skCssnm0AZi2rMDUTKg0Xo0p9Sz0KwO1iuapLks=nyg@mail.gmail.com>
	<d9f1dbc51c9d408ea593d11a95a36ee4@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpo=Pb88SBg0HwrAtzfRkG5Z9HgsapSmA1PbmqqvP-wQ1qw@mail.gmail.com>
	<21e79b8a95ca443a9844fc2b79ec5379@BY2PR03MB570.namprd03.prod.outlook.com>
 <CAKohpokZ9vGJzD0G8n=rg8qQJEuZZpuz=X7XNn_UarKbyOmQxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2lp0242.outbound.protection.outlook.com ([207.46.163.242]:21512
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753329AbaIDEdm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Sep 2014 00:33:42 -0400
In-Reply-To: <CAKohpokZ9vGJzD0G8n=rg8qQJEuZZpuz=X7XNn_UarKbyOmQxw@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "LeoLi@freescale.com" <LeoLi@freescale.com>, Hongtao Jia <hongtao.jia@freescale.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciBbbWFp
bHRvOnZpcmVzaC5rdW1hckBsaW5hcm8ub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVy
IDA0LCAyMDE0IDExOjM4IEFNDQo+IFRvOiBUYW5nIFl1YW50aWFuLUIyOTk4Mw0KPiBDYzogUmFm
YWVsIFd5c29ja2k7IGxpbmFyby1rZXJuZWxAbGlzdHMubGluYXJvLm9yZzsgbGludXgtcG1Admdl
ci5rZXJuZWwub3JnOyBMaQ0KPiBZYW5nLUxlby1SNTg0NzI7IEppYSBIb25ndGFvLUIzODk1MQ0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gY3B1ZnJlcTogcHBjLWNvcmVuZXQ6IHJlbW92ZSBw
ZXItY3B1IHZhcmlhYmxlDQo+ICdjcHVfbWFzaycNCj4gDQo+IE9uIDQgU2VwdGVtYmVyIDIwMTQg
MDg6MjEsIFl1YW50aWFuIFRhbmcgPFl1YW50aWFuLlRhbmdAZnJlZXNjYWxlLmNvbT4NCj4gd3Jv
dGU6DQo+ID4gQ2FuJ3QgYWdyZWUgeW91IG1vcmUuDQo+IA0KPiBJdHMgbm90IGFib3V0IHVwc3Ry
ZWFtaW5nIG15IHBhdGNoIGJ1dCBkb2luZyB0aGUgcmlnaHQgdGhpbmcuDQo+IA0KPiA+IEFzIEkg
a25vdywgdGhlcmUgaXMgbm8gc3VjaCBmdW5jdGlvbiB0byBnZXQgbWFzayBvZiBvbmxpbmUgYW5k
IG9mZmxpbmUgY3B1cyBpbiBhDQo+IGNsdXN0ZXIuDQo+IA0KPiBUaGlzIGlzIGEgcHJpbWFyeSBy
ZXF1aXJlbWVudCBvZiBjcHVmcmVxLXN1YnN5c3RlbS4gVGhlIC0+aW5pdCgpIGNhbGxiYWNrIG11
c3QNCj4gaW5pdGlhbGl6ZQ0KPiBwb2xpY3ktPmNwdXMgdG8gdGhlIG1hc2sgb2YgYWxsIG9ubGlu
ZStvZmZsaW5lIENQVXMgdGhhdCBhcmUgc2hhcmluZyBjbG9jay4NCj4gDQo+IE9rYXksIHRoZW4g
d2hhdCBJIGNhbiBzYXkgaXMgeW91ciBkcml2ZXIgaXMgYWxyZWFkeSBicm9rZW4gKHdpdGhvdXQg
bXkNCj4gcGF0Y2gpIHdoZW4gd2UNCj4gdXNlIGl0IGFzIGEgbW9kdWxlLg0KPiANCj4gPj4gLSBi
dWlsZCBkcml2ZXIgYXMgbW9kdWxlIGFuZCBkb24ndCBsb2FkIGl0IGJ5IGRlZmF1bHQNCj4gPj4g
LSBib290IHlvdXIgc3lzdGVtDQo+ID4+IC0gb2ZmbGluZSBDUFVzIDggdG8gMTUgYXMgeW91IGRp
ZCBhYm92ZS4NCj4gPj4gLSBpbnNlcnQgbW9kdWxlDQo+ID4+IC0gdHJ5IHRvIG9ubGluZSBjb3Jl
cyBhcyB5b3UgZGlkIGFib3ZlLg0KPiANCj4gQWJvdmUgc2VxdWVuY2Ugb2YgZXZlbnRzIHdvdWxk
IHJlcHJvZHVjZSBzaW1pbGFyIGNyYXNoIGZvciB5b3UuIFNvLCBlaXRoZXIgZml4DQo+IHRoaXMg
cHJvYmxlbSBvciBtYXJrIHlvdXIgbW9kdWxlIGFzICdib29sJyBpbnN0ZWFkIG9mICd0cmlzdGF0
ZScgc28gdGhhdCBpdCBjYW4ndCBiZQ0KPiBjb21waWxlZCBhcyBtb2R1bGUgYW55bW9yZS4NCj4g
DQoNCldoYXQgYWJvdXQgdGhlIG90aGVyIGFyY2g/IENhbiB0aGV5IGRlYWwgd2l0aCB0aGlzIHNp
dHVhdGlvbj8NCg0KVGhhbmtzLA0KWXVhbnRpYW4NCj4gLS0NCj4gdmlyZXNoDQo=
