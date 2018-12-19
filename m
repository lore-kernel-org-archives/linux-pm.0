From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Wed, 19 Dec 2018 14:40:41 -0800
Message-ID: <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
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
 <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

SGksCgpPbiBXZWQsIERlYyAxOSwgMjAxOCBhdCAxMjo0MCBQTSBEb3VnIEFuZGVyc29uIDxkaWFu
ZGVyc0BjaHJvbWl1bS5vcmc+IHdyb3RlOgo+Cj4gSGksCj4KPiBPbiBXZWQsIERlYyAxOSwgMjAx
OCBhdCAxMjowOSBQTSBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4g
PiBPbiBUdWUsIERlYyAxOCwgMjAxOCBhdCAxMDo0OSBQTSBWaXJlc2ggS3VtYXIgPHZpcmVzaC5r
dW1hckBsaW5hcm8ub3JnPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gMTgtMTItMTgsIDExOjA1LCBE
b3VnIEFuZGVyc29uIHdyb3RlOgo+ID4gPiA+IE9LLCBpdCdzIGZpbmUgd2l0aCBtZSB0byBoYXZl
IHRoZSBmYWxsYmFjaywgYnV0IGlmIHdlIGRvIHdlIHNob3VsZCBiZQo+ID4gPiA+IGNvbnNpc3Rl
bnQgYWJvdXQgaXQgYW5kIG1ha2Ugc3VyZSBpdCdzIGluIGFsbCB0aGUgYmluZGluZ3MgYW5kIGRl
dmljZQo+ID4gPiA+IHRyZWUgZmlsZXMuLi4KPiA+ID4KPiA+ID4gU3VyZS4KPiA+ID4KPiA+ID4g
SSBhbSBub3Qgc3VyZSB3aGF0J3MgdGhlIHJpZ2h0IHdheSB0byBkbyBpdCBpcywgaS5lLiBzaG91
bGQgd2Uga2VlcCB0aGUKPiA+ID4gIm9wZXJhdGluZy1wb2ludHMtdjIiIHN0cmluZyBvciBub3Qu
Cj4gPgo+ID4gRG9lcyBoYXZpbmcgaXQgYnV5IHlvdSBhbnl0aGluZz8gR2l2ZW4gdGhlIFFDb20g
b25lIGRvZXNuJ3QgaGF2ZSBhbnkKPiA+IGZyZXF1ZW5jeSBvciB2b2x0YWdlLCBJIGRvbid0IHNl
ZSBob3cgaXQgd291bGQgYmUgdXNlZnVsIHRvIGhhdmUgaXQuCj4KPiAuLi5idXQgaXQgZG9lcyBo
YXZlIGEgZnJlcXVlbmN5LCBkb2Vzbid0IGl0Pwo+Cj4gKyAgIGNvbXBhdGlibGUgPSAib3BlcmF0
aW5nLXBvaW50cy12Mi1xY29tLWxldmVsIjsKPiArCj4gKyAgIG9wcC03MTAwMDAwMDAgewo+ICsg
ICAgIG9wcC1oeiA9IC9iaXRzLyA2NCA8NzEwMDAwMDAwPjsKPiArICAgICBxY29tLGxldmVsID0g
PFJQTUhfUkVHVUxBVE9SX0xFVkVMX1RVUkJPX0wxPjsKPiArICAgfTsKCkFoLCBJIHBlcmhhcHMg
c2VlIHRoZSBjb25mdXNpb24uICBTbyBSYWplbmRyYSdzIHVzYWdlIG9mCiJvcGVyYXRpbmctcG9p
bnRzLXYyLXFjb20tbGV2ZWwiIFsxXSBkb2Vzbid0IGhhdmUgYSBmcmVxdWVuY3kgYnV0CkpvcmRh
bidzIGRvLiAgU28gSSBndWVzcyBpdCBtYWtlcyBzZW5zZSB0aGF0IEpvcmRhbidzIGhhdmUgdGhl
CmZhbGxiYWNrIGNvbXBhdGlibGUgYnV0IFJhamVuZHJhJ3MgZG9uJ3Q/CgpbMV0gaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDcyNTc5My8KCi1Eb3VnCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyZWVkcmVubyBtYWlsaW5nIGxpc3QK
RnJlZWRyZW5vQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ZyZWVkcmVubwo=
