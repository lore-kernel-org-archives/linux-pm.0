From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH][v2] ARM: davinci: cpuidle - remove ops
Date: Tue, 22 May 2012 20:40:24 +0200
Message-ID: <4FBBDD98.30105@linaro.org>
References: <1337551640-5973-1-git-send-email-daniel.lezcano@linaro.org>
	<4FBBD3CD.7070804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4FBBD3CD.7070804-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: khilman-l0cyMroinI0@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gMDUvMjIvMjAxMiAwNzo1OCBQTSwgU2VraGFyIE5vcmkgd3JvdGU6Cj4gSGkgRGFuaWVsLAo+
Cj4gT24gNS8yMS8yMDEyIDM6MzcgQU0sIERhbmllbCBMZXpjYW5vIHdyb3RlOgo+PiBUaGlzIHBh
dGNoIHJlbW92ZXMgdGhlIG9wcyB1c2FnZSBiZWNhdXNlIHdlIGhhdmUgdGhlIGluZGV4Cj4+IHBh
c3NlZCBhcyBwYXJhbWV0ZXIgdG8gdGhlIGlkbGUgZnVuY3Rpb24gYW5kIHdlIGNhbiBkZXRlcm1p
bmUKPj4gaWYgd2UgZG8gV0ZJIG9yIG1lbW9yeSByZXRlbnRpb24uCj4+Cj4+IFRoZSBiZW5lZml0
IG9mIHRoaXMgY2xlYW51cCBpcyB0aGUgcmVtb3ZhbCBvZjoKPj4gICAqIHRoZSBvcHMKPj4gICAq
IHRoZSBzdGF0ZWRhdGEgdXNhZ2UgYmVjYXVzZSB3ZSB3YW50IHRvIGdldCByaWQgb2YgaXQgaW4g
YWxsIHRoZSBkcml2ZXJzCj4+ICAgKiBleHRyYSBzdHJ1Y3R1cmUgZGVmaW5pdGlvbgo+PiAgICog
ZXh0cmEgZnVuY3Rpb25zIGRlZmluaXRpb24KPj4gICAqIHJlbW92ZSBtYWNybyBkZWZpbml0aW9u
IHVzaW5nIEJJVCgwKQo+Pgo+PiBJdCBhbHNvIGJlbmVmaXRzIHRoZSByZWFkYWJpbGl0eS4KPj4K
Pj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIExlemNhbm88ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9y
Zz4KPgo+IExvb2tzIGdvb2QgdG8gbWUuIElmIHRoZXJlIGlzIG5vIG90aGVyIHBsYW4sIEkgd2ls
bCBxdWV1ZSB0aGVzZSB0d28KPiBjcHVpZGxlIHBhdGNoZXMgZm9yIHYzLjYgdGhyb3VnaCBEYVZp
bmNpIHRyZWUuCgpDb29sICEKCkp1c3QgYSByZW1pbmRlciwgSSBkb24ndCBoYXZlIHRoaXMgYm9h
cmQsIHNvIEkgd2FzIG5vdCBhYmxlIHRvIHRlc3QgaXQuCgpUaGFua3MuCiAgIC0tIERhbmllbAoK
Ci0tIAogIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJj
ZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0cDovL3d3dy5mYWNl
Ym9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8vdHdpdHRlci5jb20vIyEv
bGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+
IEJsb2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW5hcm8tZGV2IG1haWxpbmcgbGlzdApsaW5hcm8tZGV2QGxpc3RzLmxpbmFyby5vcmcKaHR0cDov
L2xpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9saXN0aW5mby9saW5hcm8tZGV2Cg==
