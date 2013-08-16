From: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: System suspend states and device driver suspend() callback
Date: Fri, 16 Aug 2013 17:13:42 +0000
Message-ID: <02318724-F4F7-4D53-9926-872E9417F672@freescale.com>
References: <CADRPPNSD+uj_t5+qbNW29y7SuJkB_vMck-DGFJFV4A0AmPC6pQ@mail.gmail.com>,<17024788.0xFN8jEV59@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:28557
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752125Ab3HPRNr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2013 13:13:47 -0400
In-Reply-To: <17024788.0xFN8jEV59@vostro.rjw.lan>
Content-Language: zh-CN
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

DQoNCtTaIDIwMTMtOC0xNqOsz8LO5zc6MjKjrCJSYWZhZWwgSi4gV3lzb2NraSIgPHJqd0BzaXNr
LnBsPiDQtLXAo7oNCg0KPiBPbiBGcmlkYXksIEF1Z3VzdCAxNiwgMjAxMyAwNDowNjoyNiBQTSBM
aSBZYW5nIHdyb3RlOg0KPj4gSGkgR3V5cywNCj4+IA0KPj4gSXMgdGhlcmUgYSBzdGFuZGFyZCB3
YXkgZm9yIHRoZSBkZXZpY2UgZHJpdmVycyB0byBrbm93IGlmIHRoZSBzeXN0ZW0NCj4+IGlzIGdv
aW5nIHRvIKGwc3RhbmRieaGxIG1vZGUgb3IgobBtZW2hsSBtb2RlIHdoZW4gdGhlIHN1c3BlbmQo
KSBjYWxsYmFja3MNCj4+IGFyZSBjYWxsZWQ/DQo+IA0KPiBObywgdGhlcmUncyBub25lLg0KPiAN
Cj4gV2hhdCBkbyB5b3UgbmVlZCB0aGF0IGZvcj8NCg0KU29tZSBjaGlwcyBsaWtlIG91cnMgYXJl
IHB1dHRpbmcgdGhlIG9uLWNoaXAgZGV2aWNlcyBpbnRvIGRpZmZlcmVudCBsb3cgcG93ZXIgc3Rh
dGVzIHdoZW4gZW50ZXJpbmcgZGlmZmVyZW50IHN5c3RlbSBsb3cgcG93ZXIgc3RhdGVzLiAgV2hl
biB3ZSBlbnRlciBzeXN0ZW0gc3RhbmRieSwgb24tY2hpcCBkZXZpY2VzIGFyZSBjbG9jayBnYXRl
ZC4gIFdoaWxlIGVudGVyaW5nIHN1c3BlbmQgdG8gcmFtLCBvbi1jaGlwIGRldmljZXMgYXJlIHBv
d2VyIGdhdGVkLiAgV2Ugd2FudCB0byBkcml2ZXIgdG8gYWN0IGRpZmZlcmVudGx5IHRvbyB3aGVu
IGVudGVyaW5nIGRpZmZlcmVudCBzdXNwZW5kIHN0YXRlcy4NCg0KLSBMZW8NCg0KPiANCj4gUmFm
YWVsDQo+IA0KPiANCg==

