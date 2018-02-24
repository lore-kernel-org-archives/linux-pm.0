From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v13 3/4] thinkpad_acpi: Add support for
 battery thresholds
Date: Sat, 24 Feb 2018 11:31:40 +0100
Message-ID: <20180224103140.lyisawzxxkboez42@thinkpad>
References: <20180207145844.bd567c36juvlkjvz@thinkpad>
 <20180208220323.cr6j2kcozekwbzo6@earth.universe>
 <CAJZ5v0hOf1DfQuoqcqb3Xjmw_Y49MGCnY19Xv6Qz88KyT5T+xQ@mail.gmail.com>
 <20180209103946.fkolldv6boml3e32@earth.universe>
 <CAJZ5v0h8YW03EpqEVO8LGti9ECo7+Gmm0PdgQViidUCZ=o0AQw@mail.gmail.com>
 <20180209123414.xrtmtgmeeezmma5u@earth.universe>
 <20180210084859.dtpydh5gkvoywoju@thinkpad>
 <CAHp75Vej+EjOd-fHjM9R45E0M_qttGsEBOQrwp7WdJ16X6qxXQ@mail.gmail.com>
 <CAJZ5v0hdpzW3fqwOaHhV1wc19oLtLNXMGUgV9yMBRuqdn6PpHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hdpzW3fqwOaHhV1wc19oLtLNXMGUgV9yMBRuqdn6PpHA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph-KeW1gJXA36yNJhrcwGid2A@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gU2F0LCBGZWIgMjQsIDIwMTggYXQgMTA6MDc6MjBBTSArMDEwMCwgUmFmYWVsIEouIFd5c29j
a2kgd3JvdGU6Cj4gT24gRnJpLCBGZWIgMjMsIDIwMTggYXQgNjoyMSBQTSwgQW5keSBTaGV2Y2hl
bmtvCj4gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+IHdyb3RlOgo+ID4gT24gU2F0LCBGZWIg
MTAsIDIwMTggYXQgMTA6NDggQU0sIE9nbmplbiBHYWxpxIcgPHNtY2x0MzBwQGdtYWlsLmNvbT4g
d3JvdGU6Cj4gPgo+ID4+IERvIHlvdSBndXlzIHdhbnQgbWUgdG8gc2VuZCBpbiBhbm90aGVyIHJl
dmlzaW9uIG9mIHRoZSBwYXRjaCB3aXRoIHNvbWUKPiA+PiBkb2N1bWVudGF0aW9uIG9uIHRoZSBz
eXNmcyBBUEk/Cj4gPgo+ID4gSSBub3RpY2VkIEkgZGlkbid0IGFwcGx5IGl0IGJlY2F1c2Ugb2Yg
c29tZSBwZW5kaW5nIGNoYW5nZXMgZGlzY3Vzc2VkLAo+ID4gcGVyaGFwcyB0aGlzIG9uZSBhYm92
ZS4KPiA+Cj4gPiBTbywgZGVmaW5pdGVseSBwbGVhc2Ugc2VuZCBhIG5ldyB2ZXJzaW9uIHdoaWNo
IGFkZHJlc3NlcyBjb21tZW50cy4KPiAKPiBObywgaXQgYWN0dWFsbHkgaGFzIGJlZW4gYXBwbGll
ZCBhbHJlYWR5LgoKU28gaXQgaGFzIGJlZW4gcXVldWVkIHVwIGZvciA0LjE3PwoKSWYgaXQgaGFz
LCB0aGF0IGlzIGF3ZXNvbWUhIFRoYW5rcyEKCj4gCj4gV2hhdCBpcyBuZWVkZWQgaXMgYSBmb2xs
b3ctdXAgcGF0Y2gsIGJ1dCBJJ2xsIHdyaXRlIG9uIHRoYXQgbGF0ZXIuCj4gCj4gVGhhbmtzLAo+
IFJhZmFlbAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNo
IGNvbW11bml0eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVz
LCBTbGFzaGRvdC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppYm0tYWNwaS1kZXZlbCBtYWlsaW5nIGxp
c3QKaWJtLWFjcGktZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291
cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2libS1hY3BpLWRldmVsCg==
