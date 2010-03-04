From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Move ACPI video resume to a PM
	notifier
Date: Thu, 4 Mar 2010 20:12:36 +0100
Message-ID: <201003042012.36416.rjw__17618.3148440488$1267729872$gmane$org@sisk.pl>
References: <201003040125.30091.rjw@sisk.pl>
	<b170af451003040311g3cea44caj1cd0e23e55814696@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <b170af451003040311g3cea44caj1cd0e23e55814696@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gVGh1cnNkYXkgMDQgTWFyY2ggMjAxMCwgUmFmYcWCIE1pxYJlY2tpIHdyb3RlOgo+IDIwMTAv
My80IFJhZmFlbCBKLiBXeXNvY2tpIDxyandAc2lzay5wbD46Cj4gPiBUaGVyZSBpcyBhIHByb2Js
ZW0gd2l0aCB0aGUgQUNQSSB2aWRlbyByZXN1bWUgcm91dGluZSB0aGF0IGl0J3MKPiA+IGV4ZWN1
dGVkIGJlZm9yZSB0aGUgR1BVIHRoYXQgbWF5IGJlIGFjY2Vzc2VkIGJ5IGl0LiAgVG8gZml4IHRo
aXMKPiA+IGlzc3VlLCBtb3ZlIHRoZSBBQ1BJIHZpZGVvIHJlc3VtZSB0byBhIHBvd2VyIG1hbmFn
ZW1lbnQgbm90aWZpZXIsCj4gPiBzbyB0aGF0IGl0J3MgZXhlY3V0ZWQgYWZ0ZXIgcmVzdW1pbmcg
YWxsIGRldmljZXMsIGluY2x1ZGluZyB0aGUgR1BVLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFJh
ZmFlbCBKLiBXeXNvY2tpIDxyandAc2lzay5wbD4KPiA+IC0tLQo+IAo+IFRlc3RlZC1ieTogUmFm
YcWCIE1pxYJlY2tpIDx6YWplYzVAZ21haWwuY29tPgoKVGhhbmtzIQoKPiBJdCBwYXJ0aWFsbHkg
Zml4ZXMgYnVnemlsbGEgYnVnICMxNTA5NiBhbmQgaXQgZmlyc3QgbmVlZGVkIHN0ZXAgdG8gZml4
Cj4gaXQgY29tcGxldGVseS4KClRvIGZpeCB0aGF0IGNvbXBsZXRlbHkgd2UnZCBuZWVkIHRvIGF2
b2lkIGNhbGxpbmcgYWNwaV92aWRlb19yZXN1bWUoKSBpbiB0aGUKbm9uLUtNUyBjYXNlLCBidXQg
aXQncyBub3QgY2xlYXIgaG93IHRvIHRlbGwgdGhlIEFDUEkgZHJpdmVyIHdoaWNoIGNhc2Ugd2Un
cmUKaW4uICBJdCdzIG5vdCBjZXJ0YWluIGhvdyB0byByZWxpYWJseSBkaXN0aW5ndWlzaCB0aGUg
S01TIGFuZCBub24tS01TIGNhc2VzIGF0CnRoaXMgbGV2ZWwgaW4gdGhlIGZpcnN0IHBsYWNlLgoK
PiBDYW4gd2Ugc2VuZCB0aGlzIHRvIHN0YWJsZSBmb3IgLjMyIGFuZCAuMzM/CgpUaGF0IGRlcGVu
ZHMgb24gTGVuLgoKUmFmYWVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtcG0=
