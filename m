From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: Re: [PATCH] MIPS:i8259.c remove resume and shutdown to
	syscore_ops
Date: Wed, 25 May 2011 07:14:59 +0800
Message-ID: <1306278899.2135.2.camel__9316.54950040883$1306358631$gmane$org@Tux>
References: <1306247112.2066.8.camel@Tux>  <201105242059.59770.rjw@sisk.pl>
Reply-To: wanlong.gao@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105242059.59770.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Pengfei Zhang <zoppof.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

T24g5LqMLCAyMDExLTA1LTI0IGF0IDIwOjU5ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBPbiBUdWVzZGF5LCBNYXkgMjQsIDIwMTEsIFdhbmxvbmcgR2FvIHdyb3RlOgo+ID4gCj4g
PiA+IE9uIFR1ZSwgTWF5IDI0LCAyMDExIGF0IDA4OjE5OjE4UE0gKzA4MDAsIFBlbmdmZWkgWmhh
bmcgd3JvdGU6Cj4gPiA+IAo+ID4gPiA+IFJlbW92ZSB0aGUgcmVzdW1lIGFuZCBzaHV0ZG93biBv
ZiBpODI1OUEgZnJvbSB0aGUgc3lzZGV2X2NsYXNzCj4gPiA+ID4gdG8gdGhlIHN5c2NvcmVfb3Bz
IHNpbmNlIHRoZXNlIG1lbWJlcnMgaGFkIHJlbW92ZWQgZnJvbSB0aGUKPiA+ID4gPiBzdHJ1Y3R1
cmUgc3lzZGV2X2NsYXNzLgo+ID4gPiAKPiA+ID4gSSBkb24ndCBzZWUgd2h5IG9uZSB3b3VsZCB3
YW50IHRvIHdhbnQgdG8gZmlyc3QgY2FsbAo+ID4gPiByZWdpc3Rlcl9zeXNjb3JlX29wcwo+ID4g
PiB0aGVuIHN5c2Rldl9jbGFzc19yZWdpc3RlciBhbmQgc3lzZGV2X3JlZ2lzdGVyPwo+ID4gPiAK
PiA+IEhpIFJhbGY6Cj4gPiBJZiB0aGVzZSBub3QgbW92ZWQgdG8gc3lzY29yZV9vcHMsIGJ1aWxk
aW5nIHdpbGwgZ2V0IGVycm9yLgo+ID4gCj4gPiBIaSBUaG9tYXM6Cj4gPiBEb2VzIHlvdSBtZWFu
IHRoYXQgd2UgY2FuIGp1c3QgcmVtb3ZlIHRoZSBzeXNmcyBlbnRyeSBub3cgPwo+IAo+IEkgaGFk
IHRoZSBhcHBlbmRlZCBwYXRjaCBpbiBteSB0cmVlIGJlZm9yZSB0aGUgbWVyZ2Ugd2luZG93IHN0
YXJ0ZWQsCj4gYnV0IGl0IGNvbmZsaWN0ZWQgd2l0aCBhbmFsb2dvdXMgY2hhbmdlcyBpbiB0aGUg
TUlQUyB0cmVlLCBzbyBJIGhhZAo+IGRyb3BwZWQgaXQuICBXYXMgaXQgYSBtaXN0YWtlPwo+IAo+
IFJhZmFlbAoKSGkgUmFmYWVsOgoKT24gNS8yNC8xMSwgUmFsZiBCYWVjaGxlIDxyYWxmQGxpbnV4
LW1pcHMub3JnPiB3cm90ZToKPlJlOiBbUEFUQ0hdIE1JUFM6IFVzZSBzdHJ1Y3Qgc3lzY29yZV9v
cHMgaW5zdGVhZCBvZiBzeXNkZXZzIGZvciBpODI1OQo+IE9uIEZyaSwgTWF5IDIwLCAyMDExIGF0
IDEwOjQxOjQxUE0gKzA5MDAsIFlvaWNoaSBZdWFzYSB3cm90ZToKPgo+IFRoYW5rcywgYXBwbGll
ZC4KPgo+ICAgUmFsZgpJdCBzZWVtcyBhbHJlYWR5IGFwcGxpZWQgc29tZSBhYm91dCB0aGlzPwoK
VGhhbmtzCgpCZXN0IHJlZ2FyZHMKV2FubG9uZyBHYW8KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
