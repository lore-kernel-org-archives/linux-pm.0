From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] thermal: intel_pch_thermal: Support skylake PCH 100
 series thermal
Date: Tue, 18 Oct 2016 20:15:57 +0000
Message-ID: <1476821756.132953.56.camel@intel.com>
References: <87pomyd515.fsf@mail.parknet.co.jp>
         <1476813814.132953.50.camel@intel.com> <87eg3dctaj.fsf@mail.parknet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64630 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752446AbcJRUP7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Oct 2016 16:15:59 -0400
In-Reply-To: <87eg3dctaj.fsf@mail.parknet.co.jp>
Content-Language: en-US
Content-ID: <E5C9DB06FB30F14AB54A1CE7625CB257@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "hirofumi@mail.parknet.co.jp" <hirofumi@mail.parknet.co.jp>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

T24gV2VkLCAyMDE2LTEwLTE5IGF0IDA1OjEwICswOTAwLCBPR0FXQSBIaXJvZnVtaSB3cm90ZToN
Cj4gIlBhbmRydXZhZGEsIFNyaW5pdmFzIiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+
IHdyaXRlczoNCj4gDQo+ID4gDQo+ID4gT24gVHVlLCAyMDE2LTEwLTE4IGF0IDA2OjQ0ICswOTAw
LCBPR0FXQSBIaXJvZnVtaSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gVXNpbmcgcmVnaXN0ZXJzIGFy
ZSBjb21wYXRpYmxlIHdpdGggY3VycmVudCBkcml2ZXIuDQo+ID4gVGhpcyBkZXNjcmlwdGlvbiBp
cyBub3QgZW5vdWdoLiBXaXRob3V0IGdvaW5nIHRocm91Z2ggdGhlIHdob2xlDQo+ID4gY29kZSwg
SQ0KPiA+IHdhcyBub3QgYWJsZSB0byBmaW5kIG91dCB3aGF0IHRoaXMgcGF0Y2ggaXMgZG9pbmcu
DQo+ID4gDQo+ID4gQmFzaWNhbGx5IHlvdSB3YW50IHRvIHRpZSB0aGUgdGhlbWFsX3pvbmUgbmFt
ZSBhbmQgZGV2aWNlDQo+ID4gb3BlcmF0aW9ucyB0bw0KPiA+IGEgYm9hcmQsIHJhdGhlciB0aGFu
IHRvIFBDSSBkZXZpY2VzIGlkcy4gSW4gdGhpcyB3YXkgbXVsdGlwbGUgUENJDQo+ID4gaWRzDQo+
ID4gZm9yIHRoZSBzYW1lIGJvYXJkIGNhbiBiZSBhY2NvdW50ZWQgZm9yLg0KPiANCj4gRXhhY3Rs
eS4gSSB0aG91Z2h0IHRoZSBwYXRjaCBpcyBlbm91Z2ggZWFzeSB0byByZWFkLCBhbmQgY2hhbmdl
bG9nDQo+IHdvdWxkDQo+IGJlIGJldHRlciB0byBub3QgZXhwbGFpbiB3aGF0IGNvZGUgaXRzZWxm
LCBhbmQgd3JvdGUgbm90ZSBvZiBjb2RlDQo+IChyZWdpc3RlcnMgYXJlIHNhbWUgd2l0aCBjdXJy
ZW50KS4NCg0KUmV2aWV3ZXJzIHdpbGwgbG9vayBhdCB0aGUgZGVzY3JpcHRpb24gYmVmb3JlIHRv
IGxvb2sgYXQgdGhlIGNvZGUuDQoNClsuLi5dDQoNCj4gPiA+IMKgc3RhdGljIHN0cnVjdCBwY2lf
ZGV2aWNlX2lkIGludGVsX3BjaF90aGVybWFsX2lkW10gPSB7DQo+ID4gPiAtCXsgUENJX0RFVklD
RShQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0hfVEhFUk1BTF9ESURfV1BUKQ0KPiA+ID4gfSwNCj4g
PiA+IC0JeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIFBDSF9USEVSTUFMX0RJRF9T
S0wpDQo+ID4gPiB9LA0KPiA+ID4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwg
UENIX1RIRVJNQUxfRElEX1dQVCksDQo+ID4gPiArCcKgwqAuZHJpdmVyX2RhdGEgPSBib2FyZF93
cHQsIH0sDQo+ID4gPiArCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0hfVEhF
Uk1BTF9ESURfU0tMKSwNCj4gPiA+ICsJwqDCoC5kcml2ZXJfZGF0YSA9IGJvYXJkX3NrbCwgfSwN
Cj4gPiA+ICsJLyogc2t5bGFrZSBQQ0ggMTAwIHNlcmllcyAqLw0KPiA+ID4gKwl7IFBDSV9ERVZJ
Q0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhMTMxKSwNCj4gPiBDaGFuZ2UgYTEzMSB0byBhIGRl
ZmluZSAoUENIX1RIRVJNQUxfRElEX1NLTF9IKQ0KPiANCj4gSSBkb24ndCB0aGluayBpdCBoZWxw
cyBhbnl0aGluZyBhY3R1YWxseSwgYmVjYXVzZSBubyB1c2VycyBvZiBkZWZpbmUNCj4gYW55bW9y
ZS4gV2VsbCwgYW55d2F5LCBvaywgSSBkb24ndCBjYXJlIGVpdGhlciBjYXNlLg0KDQpPbmx5IGZv
ciB0aGUgc2FrZSBjb25zaXN0ZW5jeSB3aXRoIHJlc3Qgb2YgdGhlIGlkcyBkZWZpbmVkIGhlcmUu
DQoNClRoYW5rcywNClNyaW5pdmFzDQo=
