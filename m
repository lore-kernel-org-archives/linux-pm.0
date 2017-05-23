From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: RE: [PATCH] x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
 systems
Date: Tue, 23 May 2017 12:50:15 +0000
Message-ID: <BN6PR1201MB0131B6E13B6E782494751054F8F90@BN6PR1201MB0131.namprd12.prod.outlook.com>
References: <1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com>
 <20170522162143.GA19781@nazgul.tnic>
 <BN6PR1201MB01312A2AB93708B9115D4865F8F80@BN6PR1201MB0131.namprd12.prod.outlook.com>
 <20170523075911.GA25383@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-cys01nam02on0081.outbound.protection.outlook.com ([104.47.37.81]:4097
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965928AbdEWMuT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 May 2017 08:50:19 -0400
In-Reply-To: <20170523075911.GA25383@nazgul.tnic>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21h
aWx0bzpicEBhbGllbjguZGVdDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyMywgMjAxNyAzOjU5IEFN
DQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzogbGlu
dXgtcG1Admdlci5rZXJuZWwub3JnOyB4ODZAa2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0OyBsZW4uYnJvd25AaW50ZWwuY29tOw0K
PiBwYXZlbEB1Y3cuY3oNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0geDg2L0FDUEkvY3N0YXRlOiBB
bGxvdyBBQ1BJIEMxIEZGSCBNV0FJVCB1c2Ugb24NCj4gQU1EIHN5c3RlbXMNCj4gDQo+IE9uIE1v
biwgTWF5IDIyLCAyMDE3IGF0IDA4OjIwOjU2UE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdyb3Rl
Og0KPiA+IE9uIHRoZSBvdGhlciBoYW5kLCBNV0FJVCBvbiBBTUQgbGltaXRzIHRoZSBoYXJkd2Fy
ZSB0byB1c2luZyBvbmx5DQo+ID4gY2VydGFpbiwgc2hhbGxvd2VyIENzdGF0ZXMuIFRoaXMgaXMg
b2theSBpZiB3ZSBkZWZpbmUgaW5kaXZpZHVhbA0KPiA+IHN0YXRlcyBhbmQgdXNlIE1XQUlUIGZv
ciBzb21lIG9mIHRoZW0uIEJ1dCBpdCB3b3VsZCBjb25zdW1lIG1vcmUNCj4gcG93ZXIgaWYgdXNl
ZCBhbHdheXMuDQo+IA0KPiBMZXQgbWUgc2VlIGlmIEkgdW5kZXJzdGFuZCBpdCBjb3JyZWN0bHk6
DQo+IA0KPiBFdmVuIHRob3VnaCB3ZSB1c2VkIHRvIGRvIEhMVCBvbiBwcmV2aW91cyBmYW1pbGll
cyBhcyBpZGxpbmcgd2l0aCBITFQNCj4gKmlzKiB0aGUgcHJlZmVycmVkIG1ldGhvZCB1bnRpbCBu
b3csIHdpdGggeW91ciBjaGFuZ2UgeW91J3JlIG1vdmluZw0KPiAqZXZlcnkqIEFNRCBtYWNoaW5l
IG91dCB0aGVyZSB0byBkbyBNV0FJVCBub3cuDQo+IA0KDQpObywgQU1EIHN5c3RlbXMgd2lsbCBj
b250aW51ZSB0byB1c2UgSExUIHVubGVzcyB0aGUgQklPUyBzcGVjaWZpZXMgdGhlDQp1c2Ugb2Yg
TVdBSVQgdXNpbmcgYSBGRkggZW50cnkgaW4gdGhlIEFDUEkgX0NTVC4NCg0KQWxsIHRoaXMgY2hh
bmdlIGRvZXMgaXMgKmFsbG93KiB1cyB0byB1c2UgTVdBSVQgdGhyb3VnaCB0aGUgRkZIDQppbXBs
ZW1lbnRhdGlvbiBpZiB0aGUgQklPUyBkZWZpbmVzIGl0LiBJdCBkb2Vzbid0ICpmb3JjZSogYSBj
aGFuZ2UuDQoNCklmIHRoZSBCSU9TIGRvZXNuJ3QgZGVmaW5lIHRoZSBhcHByb3ByaWF0ZSBfQ1NU
IGVudHJ5IG9yIGl0IGRlZmluZXMgaXQNCndyb25nLCB0aGVuIHdlJ2xsIGZhbGxiYWNrIHRvIHVz
aW5nIEhMVC4NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
