From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get()
 method
Date: Fri, 21 Mar 2014 12:01:07 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6E5386@AcuExch.aculab.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:57406 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965459AbaCUMCe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Mar 2014 08:02:34 -0400
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 15349-10 for <linux-pm@vger.kernel.org>;
 Fri, 21 Mar 2014 12:02:32 +0000 (GMT)
In-Reply-To: <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>

RnJvbTogVmlyZXNoIEt1bWFyDQogDQo+IE9uIDIxIE1hcmNoIDIwMTQgMTY6MzQsIEdhdXRoYW0g
UiBTaGVub3kgPGVnb0BsaW51eC52bmV0LmlibS5jb20+IHdyb3RlOg0KPiA+IEhlaCEgV2VsbCwg
dGhhdCB3YXNuJ3QgdGhlIHJlYXNvbiB3aHkgdGhpcyB3YXMgc2VudCBvdXQgYXMgYSBzZXBhcmF0
ZQ0KPiA+IHBhdGNoLCBidXQgbmV2ZXIgbWluZC4gVGhvdWdoIEkgZG9uJ3QgdW5kZXJzdGFuZCB3
aHkgaXQgd291bGQgYmUNCj4gPiBkaWZmaWN1bHQgdG8gcmV2aWV3IHRoZSBwYXRjaCB0aG91Z2gu
DQo+IA0KPiBCZWNhdXNlIHRoZSBpbml0aWFsIGRyaXZlciB3YXNuJ3QgY29tcGxldGUgZWFybGll
ci4gVGhlcmUgd2VyZSAyLTMgcGF0Y2hlcw0KPiBhZnRlciB0aGUgZmlyc3Qgb25lIHdoaWNoIGFy
ZSBjaGFuZ2luZyB3aGF0IHRoZSBmaXJzdCBwYXRjaCBoYXMgYWRkZWQuDQo+IE5vdGhpbmcgZWxz
ZSA6KQ0KPiANCj4gPj4gPiArc3RhdGljIHZvaWQgcG93ZXJudl9yZWFkX2NwdV9mcmVxKHZvaWQg
KnJldF9mcmVxKQ0KPiA+PiA+ICt7DQo+ID4+ID4gKyAgICAgICB1bnNpZ25lZCBsb25nIHBtc3By
X3ZhbDsNCj4gPj4gPiArICAgICAgIHM4IGxvY2FsX3BzdGF0ZV9pZDsNCj4gPj4gPiArICAgICAg
IGludCAqY3VyX2ZyZXEsIGZyZXEsIHBzdGF0ZV9pZDsNCj4gPj4gPiArDQo+ID4+ID4gKyAgICAg
ICBjdXJfZnJlcSA9IChpbnQgKilyZXRfZnJlcTsNCj4gPj4NCj4gPj4gWW91IGRvbid0IG5lZWQg
Y3VyX2ZyZXEgdmFyaWFibGUgYXQgYWxsLi4NCj4gPg0KPiA+IEkgZG9uJ3QgbGlrZSBpdCBlaXRo
ZXIuIEJ1dCB0aGUgY29tcGlsZXIgY29tcGxhaW5zIHdpdGhvdXQgdGhpcyBoYWNrDQo+ID4gOi0o
DQo+IA0KPiBXaHkgd291bGQgdGhlIGNvbXBpbGVyIHdhcm4gZm9yIGRvaW5nIHRoaXM/Og0KPiAN
Cj4gKihpbnQgKilyZXRfZnJlcSA9IGZyZXE7DQoNCkJlY2F1c2UgaXQgaXMgdmVyeSBsaWtlbHkg
dG8gYmUgd3JvbmcuDQpJbiBnZW5lcmFsIGNhc3RzIG9mIHBvaW50ZXJzIHRvIGludGVnZXIgdHlw
ZXMgYXJlIGRhbmdlcm91cy4NCkluIHRoaXMgY2FzZSB3aHkgbm90IG1ha2UgdGhlIGZ1bmN0aW9u
IHJldHVybiB0aGUgdmFsdWU/DQoNCglEYXZpZA0KDQoNCg==
