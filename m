From: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable
 'cpu_mask'
Date: Fri, 5 Sep 2014 09:35:02 +0000
Message-ID: <618265ad45564bd68100c4a72140f645@BY2PR03MB570.namprd03.prod.outlook.com>
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
	<2248223d9db143108dc32ad5f43a145e@BY2PR03MB570.namprd03.prod.outlook.com>
 <CAKohpok5fBvi3UFEszL8in=-TWJ8CG6p9gcUXeEG0322afS-QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1on0134.outbound.protection.outlook.com ([157.56.110.134]:50248
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756464AbaIELHR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Sep 2014 07:07:17 -0400
In-Reply-To: <CAKohpok5fBvi3UFEszL8in=-TWJ8CG6p9gcUXeEG0322afS-QA@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "LeoLi@freescale.com" <LeoLi@freescale.com>, Hongtao Jia <hongtao.jia@freescale.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciBbbWFp
bHRvOnZpcmVzaC5rdW1hckBsaW5hcm8ub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVy
IDA0LCAyMDE0IDEyOjM3IFBNDQo+IFRvOiBUYW5nIFl1YW50aWFuLUIyOTk4Mw0KPiBDYzogUmFm
YWVsIFd5c29ja2k7IGxpbmFyby1rZXJuZWxAbGlzdHMubGluYXJvLm9yZzsgbGludXgtcG1Admdl
ci5rZXJuZWwub3JnOyBMaQ0KPiBZYW5nLUxlby1SNTg0NzI7IEppYSBIb25ndGFvLUIzODk1MQ0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gY3B1ZnJlcTogcHBjLWNvcmVuZXQ6IHJlbW92ZSBw
ZXItY3B1IHZhcmlhYmxlDQo+ICdjcHVfbWFzaycNCj4gDQo+IE9uIDQgU2VwdGVtYmVyIDIwMTQg
MTA6MDMsIFl1YW50aWFuIFRhbmcgPFl1YW50aWFuLlRhbmdAZnJlZXNjYWxlLmNvbT4NCj4gd3Jv
dGU6DQo+ID4gV2hhdCBhYm91dCB0aGUgb3RoZXIgYXJjaD8gQ2FuIHRoZXkgZGVhbCB3aXRoIHRo
aXMgc2l0dWF0aW9uPw0KPiANCj4gWWVzIGZvciBtb3N0IG9mIHRoZW0gKHNwZWFjaWFsbHkgQVJN
KSwgYmVjYXVzZSB0aGV5IGZ1bGZpbGwgdGhlIHJlcXVpcmVtZW50IG9mDQo+IENQVUZyZXEgY29y
ZS4gaS5lLiBzZXQgcG9saWN5LT5jcHVzIHRvIGFsbCBvbmxpbmUrb2ZmbGluZSBDUFVzLg0KDQpX
aGF0J3MgdGhlIG5hbWUgb2YgZnVuY3Rpb24gb24gQVJNIGFyY2ggd2hpY2ggZ2V0IHRoZSBtYXNr
IG9mIGFsbCBvbmxpbmUgYW5kIG9mZmxpbmUgY3B1cz8NCg0KV2Ugd2FudCB0aGlzIGRyaXZlciB0
byBiZSB1c2VkIG9uIEFSTSBhcyB3ZWxsLiBTbyBob3cgdG8gd3JpdGUgdGhlIEtjb25maWcsIA0K
YXMgeW91IGtub3cgd2UgYWxyZWFkeSBoYXZlIGEgQ09ORklHXyogaXRlbSBpbiBLY29uZmlnLnBv
d2VycGMuDQoNClRoYW5rcywNCll1YW50aWFuDQo=
