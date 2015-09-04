From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v3] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 map
Date: Fri, 4 Sep 2015 10:44:42 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401CB04111@SHSMSX101.ccr.corp.intel.com>
References: <1441195588-31175-1-git-send-email-yu.c.chen@intel.com>
 <17819977.aDTvlCt931@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52879 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757007AbbIDKos (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 06:44:48 -0400
In-Reply-To: <17819977.aDTvlCt931@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "mingo@redhat.com" <mingo@redhat.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "yinghai@kernel.org" <yinghai@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tp
IFttYWlsdG86cmp3QHJqd3lzb2NraS5uZXRdDQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIg
MDMsIDIwMTUgOToxOSBBTQ0KPiBUbzogQ2hlbiwgWXUgQw0KPiBDYzogQnJvd24sIExlbjsgcGF2
ZWxAdWN3LmN6OyBtaW5nb0ByZWRoYXQuY29tOw0KPiBqb2V5bGkua2VybmVsQGdtYWlsLmNvbTsg
eWluZ2hhaUBrZXJuZWwub3JnOyBaaGFuZywgUnVpOyBsaW51eC0NCj4gcG1Admdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IFt2M10gUE0gLyBoaWJlcm5hdGU6IEZpeCBoaWJlcm5hdGlvbiBwYW5pYyBjYXVzZWQgYnkNCj4g
aW5jb25zaXN0ZW50IGU4MjAgbWFwDQo+IA0KPiBPbiBXZWRuZXNkYXksIFNlcHRlbWJlciAwMiwg
MjAxNSAwODowNjoyOCBQTSBDaGVuIFl1IHdyb3RlOg0KPiANCj4gV2VsbCwgbG9va3MgbGlrZSBh
biBpbXByb3ZlbWVudCwgYnV0IEkgd291bGRuJ3QgYmUgY29tZm9ydGFibGUgd2l0aCBwdXNoaW5n
DQo+IGl0IHRvIExpbnVzIGJlZm9yZSBpdCBzcGVudCBhIGZhaXIgYW1vdW50IG9mIHRpbWUgaW4g
bGludXgtbmV4dC4NCj4gDQo+IEZvciB0aGlzIHJlYXNvbiwgSSBjYW4gcXVldWUgaXQgdXAgZm9y
IHRoZSBuZXh0IG1lcmdlIHdpbmRvdyB3aGVuIDQuMy1yYzEgaXMNCj4gb3V0Lg0KDQpPSywgdGhh
bmtzIQ0KDQpCZXN0IFJlZ2FyZHMsDQpZdQ0KPiANCj4gVGhhbmtzLA0KPiBSYWZhZWwNCg0K
