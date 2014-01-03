From: "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>
Subject: RE: [PATCH V3 2/2] cpufreq: imx6q: correct VDDSOC/PU voltage
 scaling when cpufreq is changed
Date: Fri, 3 Jan 2014 09:52:22 +0000
Message-ID: <67c8e04574694cf59625e95fa1a65332@BY2PR03MB315.namprd03.prod.outlook.com>
References: <1387402010-31749-1-git-send-email-b20788@freescale.com>
 <1387402010-31749-2-git-send-email-b20788@freescale.com>
 <20131218142536.GM6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:12841
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751751AbaACJwi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 Jan 2014 04:52:38 -0500
In-Reply-To: <20131218142536.GM6691@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

UGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMuDQpBbnNvbiBodWFuZyDpu4Tli4fmiY0NCsKgDQpGcmVl
c2NhbGUgU2VtaWNvbmR1Y3RvciBTaGFuZ2hhaQ0K5LiK5rW35rWm5Lic5paw5Yy65Lqu5pmv6Lev
MTky5Y+3QeW6pzLmpbwNCjIwMTIwMw0KVGVsOjAyMS0yODkzNzA1OA0KDQoNCj4tLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNoYXduIEd1byBbbWFpbHRvOnNoYXduLmd1b0BsaW5h
cm8ub3JnXQ0KPlNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMTgsIDIwMTMgMTA6MjYgUE0NCj5U
bzogSHVhbmcgWW9uZ2NhaS1CMjA3ODgNCj5DYzogcmp3QHJqd3lzb2NraS5uZXQ7IHZpcmVzaC5r
dW1hckBsaW5hcm8ub3JnOyBjcHVmcmVxQHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1wbUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj5kZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMi8yXSBjcHVm
cmVxOiBpbXg2cTogY29ycmVjdCBWRERTT0MvUFUgdm9sdGFnZSBzY2FsaW5nDQo+d2hlbiBjcHVm
cmVxIGlzIGNoYW5nZWQNCj4NCj5PbiBXZWQsIERlYyAxOCwgMjAxMyBhdCAwNDoyNjo1MFBNIC0w
NTAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4+IG9uIGkuTVg2USwgY3B1IGZyZXEgY2hhbmdlIG5l
ZWQgdG8gZm9sbG93IGJlbG93IGZsb3dzOg0KPj4NCj4+IDEuIGVhY2ggc2V0cG9pbnQgaGFzIGRp
ZmZlcmVudCBWRERBUk0sIFZERFNPQy9QVSB2b2x0YWdlLCBnZXQgdGhlIHNldHBvaW50DQo+PiAg
ICB0YWJsZSBmcm9tIGR0czsNCj4+IDIuIHdoZW4gY3B1IGZyZXEgaXMgc2NhbGluZyB1cCwgbmVl
ZCB0byBpbmNyZWFzZSBWRERTT0MvUFUgdm9sdGFnZSBiZWZvcmUNCj4+ICAgIFZEREFSTSwgaWYg
VkREUFUgaXMgb2ZmLCBubyBuZWVkIHRvIGNoYW5nZSBpdDsgMy4gd2hlbiBjcHUgZnJlcSBpcw0K
Pj4gc2NhbGluZyBkb3duLCBuZWVkIHRvIGRlY3JlYXNlIFZEREFSTSB2b2x0YWdlIGJlZm9yZQ0K
Pj4gICAgVkREU09DL1BVLCBpZiBWRERQVSBpcyBvZmYsIG5vIG5lZWQgdG8gY2hhbmdlIGl0Ow0K
Pj4NCj4+IG5vcm1hbGx5IGR0cyB3aWxsIHBhc3MgdmRkc29jL3B1IGZyZXEvdm9sdCBpbmZvIHRv
IGtlcm5lbCwgaWYgbm90LA0KPj4gd2lsbCB1c2UgZml4ZWQgdmFsdWUgZm9yIHZkZHNvYy9wdSB2
b2x0YWdlIHNldHRpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPGIyMDc4
OEBmcmVlc2NhbGUuY29tPg0KPg0KPkFja2VkLWJ5OiBTaGF3biBHdW8gPHNoYXduLmd1b0BsaW5h
cm8ub3JnPg0KDQo=
