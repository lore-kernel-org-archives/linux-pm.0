From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Wed, 19 Dec 2018 12:40:39 -0800
Message-ID: <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
 <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
 <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
 <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

SGksCgpPbiBXZWQsIERlYyAxOSwgMjAxOCBhdCAxMjowOSBQTSBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPiB3cm90ZToKPgo+IE9uIFR1ZSwgRGVjIDE4LCAyMDE4IGF0IDEwOjQ5IFBNIFZp
cmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4KPiA+IE9uIDE4
LTEyLTE4LCAxMTowNSwgRG91ZyBBbmRlcnNvbiB3cm90ZToKPiA+ID4gT0ssIGl0J3MgZmluZSB3
aXRoIG1lIHRvIGhhdmUgdGhlIGZhbGxiYWNrLCBidXQgaWYgd2UgZG8gd2Ugc2hvdWxkIGJlCj4g
PiA+IGNvbnNpc3RlbnQgYWJvdXQgaXQgYW5kIG1ha2Ugc3VyZSBpdCdzIGluIGFsbCB0aGUgYmlu
ZGluZ3MgYW5kIGRldmljZQo+ID4gPiB0cmVlIGZpbGVzLi4uCj4gPgo+ID4gU3VyZS4KPiA+Cj4g
PiBJIGFtIG5vdCBzdXJlIHdoYXQncyB0aGUgcmlnaHQgd2F5IHRvIGRvIGl0IGlzLCBpLmUuIHNo
b3VsZCB3ZSBrZWVwIHRoZQo+ID4gIm9wZXJhdGluZy1wb2ludHMtdjIiIHN0cmluZyBvciBub3Qu
Cj4KPiBEb2VzIGhhdmluZyBpdCBidXkgeW91IGFueXRoaW5nPyBHaXZlbiB0aGUgUUNvbSBvbmUg
ZG9lc24ndCBoYXZlIGFueQo+IGZyZXF1ZW5jeSBvciB2b2x0YWdlLCBJIGRvbid0IHNlZSBob3cg
aXQgd291bGQgYmUgdXNlZnVsIHRvIGhhdmUgaXQuCgouLi5idXQgaXQgZG9lcyBoYXZlIGEgZnJl
cXVlbmN5LCBkb2Vzbid0IGl0PwoKKyAgIGNvbXBhdGlibGUgPSAib3BlcmF0aW5nLXBvaW50cy12
Mi1xY29tLWxldmVsIjsKKworICAgb3BwLTcxMDAwMDAwMCB7CisgICAgIG9wcC1oeiA9IC9iaXRz
LyA2NCA8NzEwMDAwMDAwPjsKKyAgICAgcWNvbSxsZXZlbCA9IDxSUE1IX1JFR1VMQVRPUl9MRVZF
TF9UVVJCT19MMT47CisgICB9OwoKLURvdWcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZnJlZWRyZW5vCg==
