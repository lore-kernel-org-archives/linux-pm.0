From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v2] PM: Fix dev_pm_put_subsys_data() to not call kfree()
 while holding device power lock
Date: Mon, 6 May 2013 19:46:18 +0000
Message-ID: <1367869578.2953.57.camel@lorien>
References: <1367614010.8452.2.camel@lorien>
	 <20130504125116.GA13770@amd.pavel.ucw.cz>
	 <1882177.s6zpHZ6crc@vostro.rjw.lan>
	 <20130506120925.GA25542@amd.pavel.ucw.cz> <1367867093.2953.49.camel@lorien>
	 <20130506194119.GA15886@kroah.com>
Reply-To: Shuah Khan <shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sisa.samsung.com ([63.166.156.250]:45096 "EHLO
	mx2.sisa.samsung.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755967Ab3EFTqU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 15:46:20 -0400
In-Reply-To: <20130506194119.GA15886@kroah.com>
Content-Language: en-US
Content-ID: <349E5979C21582448C8BEF3AEEBE23A5@sisa.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "len.brown@intel.com" <len.brown@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>

T24gTW9uLCAyMDEzLTA1LTA2IGF0IDEyOjQxIC0wNzAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gTW9uLCBNYXkgMDYsIDIwMTMgYXQgMDc6MDQ6NTNQTSArMDAwMCwg
U2h1YWggS2hhbiB3cm90ZToNCj4gPiBkZXZfcG1fcHV0X3N1YnN5c19kYXRhKCkgY2FsbHMga2Zy
ZWUoKSB3aGlsZSBob2xkaW5nIGRldmljZSBwb3dlciBsb2NrLCB3aGVuDQo+ID4gdGhlIHJlZmVy
ZW5jZSBjb3VudCBpcyAwLiBGaXggaXQgdG8gY2FsbCBrZnJlZSgpIGFmdGVyIHJlbGVhc2luZyB0
aGUgbG9jay4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHVhaCBLaGFuIDxzaHVhaC5raEBz
YW1zdW5nLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+
DQo+ID4gUmV2aWV3ZWQtYnk6IFJhZmFlbCBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVs
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9iYXNlL3Bvd2VyL2NvbW1vbi5jIHwgICAgOCAr
KysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiANCj4gSXMgdGhpcyBjYXVzaW5nIGEgcHJvYmxlbSBub3csIGFuZCBpdCBzaG91bGQg
Z28gaW50byAzLjEwIGFuZCBlYXJsaWVyDQo+IGtlcm5lbHMgKGlmIHNvLCB3aGljaCBvbmVzPyks
IG9yIGNhbiBpdCBqdXN0IHdhaXQgdW50aWwgMy4xMSBhcyBpdCdzDQo+IGp1c3QgYSBjbGVhbnVw
IGZpeD8NCg0KSXQgY2FuIHdhaXQgdW50aWwgMy4xMS4gQXQgdGhpcyBwb2ludCBJIGRvbid0IGhh
dmUgYW55IGV2aWRlbmNlIHRoYXQNCnRoaXMgaXMgYWN0dWFsbHkgY2F1c2luZyBwcm9ibGVtcy4g
U28gcGxlYXNlIHRyZWF0IHRoaXMgYXMgYSBjbGVhbnVwIGZpeA0KZm91bmQgZHVyaW5nIGNvZGUg
cmV2aWV3Lg0KDQp0aGFua3MsDQotLSBTaHVhaA0KDQotLSANClNodWFoIEtoYW4gTGVhZCBLZXJu
ZWwgRGV2ZWxvcGVyIC0gT3BlbiBTb3VyY2UgR3JvdXAgDQpTYW1zdW5nIFJlc2VhcmNoIEFtZXJp
Y2EgKFNpbGljb24gVmFsbGV5KQ0Kc2h1YWgua2hAc2Ftc3VuZy5jb20gfCAoOTcwKSA2NzItMDY1
OA0K
