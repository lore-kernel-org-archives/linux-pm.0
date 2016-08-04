From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] PM / devfreq: event: remove duplicate
 devfreq_event_get_drvdata()
Date: Thu, 04 Aug 2016 17:40:05 +0900
Message-ID: <57A2FF65.80704@samsung.com>
References: <CGME20160804060219epcas1p2543bf871e76403f90d47f352251074fa@epcas1p2.samsung.com>
 <1470290508-19178-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-reply-to: <1470290508-19178-1-git-send-email-hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?B?Iu2VqOuqheyjvCAoc2Ftc3VuZy4=?= =?UTF-8?B?Y29tKSI=?= <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

KyBNeXVuZ2pvbyBIYW0sCgpIaSBMaW4gSHVhbmcsCgpPbiAyMDE264WEIDA47JuUIDA07J28IDE1
OjAxLCBMaW4gSHVhbmcgd3JvdGU6Cj4gdGhlcmUgZGVmaW5lIHR3byBkZXZmcmVxX2V2ZW50X2dl
dF9kcnZkYXRhKCkgZnVuY3Rpb24gaW4gZGV2ZnJlcS1ldmVudC5oCj4gd2hlbiBkaXNhYmxlIENP
TkZJR19QTV9ERVZGUkVRX0VWRU5ULCBpdCB3aWxsIGxlYWQgdG8gYnVpbGQgZmFpbC4gU28KPiBy
ZW1vdmUgZGV2ZnJlcV9ldmVudF9nZXRfZHJ2ZGF0YSgpIGZ1bmN0aW9uLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IExpbiBIdWFuZyA8aGxAcm9jay1jaGlwcy5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvbGlu
dXgvZGV2ZnJlcS1ldmVudC5oIHwgNSAtLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlv
bnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZmcmVxLWV2ZW50LmggYi9p
bmNsdWRlL2xpbnV4L2RldmZyZXEtZXZlbnQuaAo+IGluZGV4IDBhODNhMWUuLjRkYjAwYjAgMTAw
NjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9kZXZmcmVxLWV2ZW50LmgKPiArKysgYi9pbmNsdWRl
L2xpbnV4L2RldmZyZXEtZXZlbnQuaAo+IEBAIC0xNDgsMTEgKzE0OCw2IEBAIHN0YXRpYyBpbmxp
bmUgaW50IGRldmZyZXFfZXZlbnRfcmVzZXRfZXZlbnQoc3RydWN0IGRldmZyZXFfZXZlbnRfZGV2
ICplZGV2KQo+ICAJcmV0dXJuIC1FSU5WQUw7Cj4gIH0KPiAgCj4gLXN0YXRpYyBpbmxpbmUgdm9p
ZCAqZGV2ZnJlcV9ldmVudF9nZXRfZHJ2ZGF0YShzdHJ1Y3QgZGV2ZnJlcV9ldmVudF9kZXYgKmVk
ZXYpCj4gLXsKPiAtCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+IC19Cj4gLQo+ICBzdGF0aWMg
aW5saW5lIHN0cnVjdCBkZXZmcmVxX2V2ZW50X2RldiAqZGV2ZnJlcV9ldmVudF9nZXRfZWRldl9i
eV9waGFuZGxlKAo+ICAJCQkJCXN0cnVjdCBkZXZpY2UgKmRldiwgaW50IGluZGV4KQo+ICB7Cj4g
CgpMb29rcyBnb29kIHRvIG1lLgoKQWNrZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNh
bXN1bmcuY29tPgoKUmVnYXJkcywKQ2hhbndvbyBDaG9pCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKTGlu
dXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
