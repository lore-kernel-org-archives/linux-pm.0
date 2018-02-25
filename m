From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v13 3/4] thinkpad_acpi: Add support for
 battery thresholds
Date: Sun, 25 Feb 2018 10:22:38 +0100
Message-ID: <CAJZ5v0h1R7Jb97rGmDDMzrkKfSf-bsoxBOjWGtUosnBhTKZ6aw@mail.gmail.com>
References: <20180207145844.bd567c36juvlkjvz@thinkpad>
 <20180208220323.cr6j2kcozekwbzo6@earth.universe>
 <CAJZ5v0hOf1DfQuoqcqb3Xjmw_Y49MGCnY19Xv6Qz88KyT5T+xQ@mail.gmail.com>
 <20180209103946.fkolldv6boml3e32@earth.universe>
 <CAJZ5v0h8YW03EpqEVO8LGti9ECo7+Gmm0PdgQViidUCZ=o0AQw@mail.gmail.com>
 <20180209123414.xrtmtgmeeezmma5u@earth.universe>
 <20180210084859.dtpydh5gkvoywoju@thinkpad>
 <CAHp75Vej+EjOd-fHjM9R45E0M_qttGsEBOQrwp7WdJ16X6qxXQ@mail.gmail.com>
 <CAJZ5v0hdpzW3fqwOaHhV1wc19oLtLNXMGUgV9yMBRuqdn6PpHA@mail.gmail.com>
 <20180224173217.l62d52qyn2yghk2v@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20180224173217.l62d52qyn2yghk2v@thinkpad>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph-KeW1gJXA36yNJhrcwGid2A@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gU2F0LCBGZWIgMjQsIDIwMTggYXQgNjozMiBQTSwgT2duamVuIEdhbGnEhyA8c21jbHQzMHBA
Z21haWwuY29tPiB3cm90ZToKPiBPbiBTYXQsIEZlYiAyNCwgMjAxOCBhdCAxMDowNzoyMEFNICsw
MTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToKPj4gT24gRnJpLCBGZWIgMjMsIDIwMTggYXQg
NjoyMSBQTSwgQW5keSBTaGV2Y2hlbmtvCj4+IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiB3
cm90ZToKPj4gPiBPbiBTYXQsIEZlYiAxMCwgMjAxOCBhdCAxMDo0OCBBTSwgT2duamVuIEdhbGnE
hyA8c21jbHQzMHBAZ21haWwuY29tPiB3cm90ZToKPj4gPgo+PiA+PiBEbyB5b3UgZ3V5cyB3YW50
IG1lIHRvIHNlbmQgaW4gYW5vdGhlciByZXZpc2lvbiBvZiB0aGUgcGF0Y2ggd2l0aCBzb21lCj4+
ID4+IGRvY3VtZW50YXRpb24gb24gdGhlIHN5c2ZzIEFQST8KPj4gPgo+PiA+IEkgbm90aWNlZCBJ
IGRpZG4ndCBhcHBseSBpdCBiZWNhdXNlIG9mIHNvbWUgcGVuZGluZyBjaGFuZ2VzIGRpc2N1c3Nl
ZCwKPj4gPiBwZXJoYXBzIHRoaXMgb25lIGFib3ZlLgo+PiA+Cj4+ID4gU28sIGRlZmluaXRlbHkg
cGxlYXNlIHNlbmQgYSBuZXcgdmVyc2lvbiB3aGljaCBhZGRyZXNzZXMgY29tbWVudHMuCj4+Cj4+
IE5vLCBpdCBhY3R1YWxseSBoYXMgYmVlbiBhcHBsaWVkIGFscmVhZHkuCj4KPiBBbmQgYWxzbywg
aG93IGlzIGl0IGFwcGxpZWQgaWYgaXQgZG9lcyBub3QgYXBwbHkgdG8gNC4xNi1yYzIgYW55bW9y
ZT8KPiBEbyB5b3UgbmVlZCBhIG5ldyByZXZpc2lvbiB0aGF0IHNvbHZlcyB0aGUgYXBwbHkgY29u
ZmxpY3RzPwo+IERvIHlvdSBuZWVkIGEgbmV3IHJldmlzaW9uIHRoYXQgYWRkcmVzc2VzIHRoZSBk
b2N1bWVudGF0aW9uPwo+IERpZCB5b3UgYXBwbHkgaXQgZWFybGllciB0aGFuIDQuMTYtcmMyPwo+
IFdoZW4gZGlkIHlvdSBhcHBseSBpdD8KPiBEaWQgeW91IGFwcGx5IGl0IGF0IGFsbD8KClllcywg
SSBkaWQsIG9uIHRvcCBvZiA0LjE2LXJjMiwgYW5kIEkgbWlnaHQgaGF2ZSByZWJhc2VkIGl0IGEg
Yml0LgoKUGxlYXNlIHNlZSBsaW51eC1uZXh0IGFuZCBJIHdpbGwgZXhwb3NlIHRoZSBhY3BpLWJh
dHRlcnkgYnJhbmNoCmNvbnRhaW5pbmcgdGhpcyBzZXJpZXMgbGF0ZXIgdG9kYXkgYW5kIHRvbW9y
cm93LgoKPj4gV2hhdCBpcyBuZWVkZWQgaXMgYSBmb2xsb3ctdXAgcGF0Y2gsIGJ1dCBJJ2xsIHdy
aXRlIG9uIHRoYXQgbGF0ZXIuCgpQbGVhc2Ugc2VlIG15IHByZXZpb3VzIG1lc3NhZ2UgaW4gdGhp
cyB0aHJlYWQgcmVnYXJkaW5nIHRoZSBhYm92ZS4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVj
ayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1v
c3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xh
c2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaWJt
LWFjcGktZGV2ZWwgbWFpbGluZyBsaXN0CmlibS1hY3BpLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9pYm0tYWNw
aS1kZXZlbAo=
