From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v13 3/4] thinkpad_acpi: Add support for
 battery thresholds
Date: Fri, 23 Feb 2018 19:21:11 +0200
Message-ID: <CAHp75Vej+EjOd-fHjM9R45E0M_qttGsEBOQrwp7WdJ16X6qxXQ@mail.gmail.com>
References: <20180207145844.bd567c36juvlkjvz@thinkpad>
 <20180208220323.cr6j2kcozekwbzo6@earth.universe>
 <CAJZ5v0hOf1DfQuoqcqb3Xjmw_Y49MGCnY19Xv6Qz88KyT5T+xQ@mail.gmail.com>
 <20180209103946.fkolldv6boml3e32@earth.universe>
 <CAJZ5v0h8YW03EpqEVO8LGti9ECo7+Gmm0PdgQViidUCZ=o0AQw@mail.gmail.com>
 <20180209123414.xrtmtgmeeezmma5u@earth.universe>
 <20180210084859.dtpydh5gkvoywoju@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20180210084859.dtpydh5gkvoywoju@thinkpad>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph-KeW1gJXA36yNJhrcwGid2A@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gU2F0LCBGZWIgMTAsIDIwMTggYXQgMTA6NDggQU0sIE9nbmplbiBHYWxpxIcgPHNtY2x0MzBw
QGdtYWlsLmNvbT4gd3JvdGU6Cgo+IERvIHlvdSBndXlzIHdhbnQgbWUgdG8gc2VuZCBpbiBhbm90
aGVyIHJldmlzaW9uIG9mIHRoZSBwYXRjaCB3aXRoIHNvbWUKPiBkb2N1bWVudGF0aW9uIG9uIHRo
ZSBzeXNmcyBBUEk/CgpJIG5vdGljZWQgSSBkaWRuJ3QgYXBwbHkgaXQgYmVjYXVzZSBvZiBzb21l
IHBlbmRpbmcgY2hhbmdlcyBkaXNjdXNzZWQsCnBlcmhhcHMgdGhpcyBvbmUgYWJvdmUuClNvLCBk
ZWZpbml0ZWx5IHBsZWFzZSBzZW5kIGEgbmV3IHZlcnNpb24gd2hpY2ggYWRkcmVzc2VzIGNvbW1l
bnRzLgoKLS0gCldpdGggQmVzdCBSZWdhcmRzLApBbmR5IFNoZXZjaGVua28KCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpDaGVjayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9m
IHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRw
Oi8vc2RtLmxpbmsvc2xhc2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaWJtLWFjcGktZGV2ZWwgbWFpbGluZyBsaXN0CmlibS1hY3BpLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9pYm0tYWNwaS1kZXZlbAo=
