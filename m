From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: RE: [PATCH] x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
 systems
Date: Mon, 22 May 2017 20:20:56 +0000
Message-ID: <BN6PR1201MB01312A2AB93708B9115D4865F8F80@BN6PR1201MB0131.namprd12.prod.outlook.com>
References: <1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com>
 <20170522162143.GA19781@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:53320
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757604AbdEVUVA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 May 2017 16:21:00 -0400
In-Reply-To: <20170522162143.GA19781@nazgul.tnic>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21h
aWx0bzpicEBhbGllbjguZGVdDQo+IFNlbnQ6IE1vbmRheSwgTWF5IDIyLCAyMDE3IDEyOjIyIFBN
DQo+DQoNCi4uLg0KIA0KPiBXaGF0IGFib3V0IHg4Nl9pZGxlPw0KPiANCj4gVGhhdCB3aG9sZSBz
ZWxlY3RfaWRsZV9yb3V0aW5lKCkganVtcGluZyB0aHJvdWdoIGhvb3BzLiBUaGF0J3Mgc3RpbGwg
ZG9pbmcNCj4gZGVmYXVsdF9pZGxlKCkgb24gWmVuLCBBRkFJQ1QuDQo+IA0KPiBPciBhbSBJIG1p
c3Npbmcgc29tZXRoaW5nPw0KPiANCj4gQmVjYXVzZSB0aGF0IHN0aWxsIGFza3MgcHJlZmVyX213
YWl0X2MxX292ZXJfaGFsdCgpIGFuZCB0aGF0IG5lZWRzIGEgZmFtaWx5DQo+IGNoZWNrIG9yIHdo
YXRldmVyLi4uDQo+IA0KDQpJIHRoaW5rIHdlIGxlYXZlIEhBTFQgYXMgdGhlIGRlZmF1bHQgaWRs
ZSBtZWNoYW5pc20gYW5kIGFsbG93IEJJT1MgdG8gc2VsZWN0DQpvdGhlciBtZWNoYW5pc21zIHRo
cm91Z2ggQUNQSS4gDQoNCk9uIEFNRCwgSEFMVCBhbGxvd3MgdGhlIGhhcmR3YXJlIHRvIGF1dG9t
YXRpY2FsbHkgbWFuYWdlIGl0cyBDc3RhdGVzLiBUaGlzDQppcyB1c2VmdWwgaWYgdGhlIE9TIGRv
ZXNuJ3QgZGVmaW5lIG11bHRpcGxlIHN0YXRlcyBsaWtlIHdoZW4gd2UgdXNlDQpkZWZhdWx0X2lk
bGVfY2FsbCgpLg0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgTVdBSVQgb24gQU1EIGxpbWl0cyB0aGUg
aGFyZHdhcmUgdG8gdXNpbmcgb25seSBjZXJ0YWluLA0Kc2hhbGxvd2VyIENzdGF0ZXMuIFRoaXMg
aXMgb2theSBpZiB3ZSBkZWZpbmUgaW5kaXZpZHVhbCBzdGF0ZXMgYW5kIHVzZSBNV0FJVA0KZm9y
IHNvbWUgb2YgdGhlbS4gQnV0IGl0IHdvdWxkIGNvbnN1bWUgbW9yZSBwb3dlciBpZiB1c2VkIGFs
d2F5cy4NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
