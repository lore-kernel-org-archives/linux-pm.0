From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v13 3/4] thinkpad_acpi: Add support for
 battery thresholds
Date: Sat, 24 Feb 2018 10:07:20 +0100
Message-ID: <CAJZ5v0hdpzW3fqwOaHhV1wc19oLtLNXMGUgV9yMBRuqdn6PpHA@mail.gmail.com>
References: <20180207145844.bd567c36juvlkjvz@thinkpad>
 <20180208220323.cr6j2kcozekwbzo6@earth.universe>
 <CAJZ5v0hOf1DfQuoqcqb3Xjmw_Y49MGCnY19Xv6Qz88KyT5T+xQ@mail.gmail.com>
 <20180209103946.fkolldv6boml3e32@earth.universe>
 <CAJZ5v0h8YW03EpqEVO8LGti9ECo7+Gmm0PdgQViidUCZ=o0AQw@mail.gmail.com>
 <20180209123414.xrtmtgmeeezmma5u@earth.universe>
 <20180210084859.dtpydh5gkvoywoju@thinkpad>
 <CAHp75Vej+EjOd-fHjM9R45E0M_qttGsEBOQrwp7WdJ16X6qxXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAHp75Vej+EjOd-fHjM9R45E0M_qttGsEBOQrwp7WdJ16X6qxXQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph-KeW1gJXA36yNJhrcwGid2A@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gRnJpLCBGZWIgMjMsIDIwMTggYXQgNjoyMSBQTSwgQW5keSBTaGV2Y2hlbmtvCjxhbmR5LnNo
ZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToKPiBPbiBTYXQsIEZlYiAxMCwgMjAxOCBhdCAxMDo0
OCBBTSwgT2duamVuIEdhbGnEhyA8c21jbHQzMHBAZ21haWwuY29tPiB3cm90ZToKPgo+PiBEbyB5
b3UgZ3V5cyB3YW50IG1lIHRvIHNlbmQgaW4gYW5vdGhlciByZXZpc2lvbiBvZiB0aGUgcGF0Y2gg
d2l0aCBzb21lCj4+IGRvY3VtZW50YXRpb24gb24gdGhlIHN5c2ZzIEFQST8KPgo+IEkgbm90aWNl
ZCBJIGRpZG4ndCBhcHBseSBpdCBiZWNhdXNlIG9mIHNvbWUgcGVuZGluZyBjaGFuZ2VzIGRpc2N1
c3NlZCwKPiBwZXJoYXBzIHRoaXMgb25lIGFib3ZlLgo+Cj4gU28sIGRlZmluaXRlbHkgcGxlYXNl
IHNlbmQgYSBuZXcgdmVyc2lvbiB3aGljaCBhZGRyZXNzZXMgY29tbWVudHMuCgpObywgaXQgYWN0
dWFsbHkgaGFzIGJlZW4gYXBwbGllZCBhbHJlYWR5LgoKV2hhdCBpcyBuZWVkZWQgaXMgYSBmb2xs
b3ctdXAgcGF0Y2gsIGJ1dCBJJ2xsIHdyaXRlIG9uIHRoYXQgbGF0ZXIuCgpUaGFua3MsClJhZmFl
bAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11
bml0eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFz
aGRvdC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppYm0tYWNwaS1kZXZlbCBtYWlsaW5nIGxpc3QKaWJt
LWFjcGktZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9y
Z2UubmV0L2xpc3RzL2xpc3RpbmZvL2libS1hY3BpLWRldmVsCg==
