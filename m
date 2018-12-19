From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Wed, 19 Dec 2018 17:47:25 -0600
Message-ID: <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
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
 <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCBEZWMgMTksIDIwMTggYXQgNDo0MCBQTSBEb3VnIEFuZGVyc29uIDxkaWFuZGVyc0Bj
aHJvbWl1bS5vcmc+IHdyb3RlOgo+Cj4gSGksCj4KPiBPbiBXZWQsIERlYyAxOSwgMjAxOCBhdCAx
Mjo0MCBQTSBEb3VnIEFuZGVyc29uIDxkaWFuZGVyc0BjaHJvbWl1bS5vcmc+IHdyb3RlOgo+ID4K
PiA+IEhpLAo+ID4KPiA+IE9uIFdlZCwgRGVjIDE5LCAyMDE4IGF0IDEyOjA5IFBNIFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUdWUsIERlYyAxOCwg
MjAxOCBhdCAxMDo0OSBQTSBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPiB3
cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIDE4LTEyLTE4LCAxMTowNSwgRG91ZyBBbmRlcnNvbiB3
cm90ZToKPiA+ID4gPiA+IE9LLCBpdCdzIGZpbmUgd2l0aCBtZSB0byBoYXZlIHRoZSBmYWxsYmFj
aywgYnV0IGlmIHdlIGRvIHdlIHNob3VsZCBiZQo+ID4gPiA+ID4gY29uc2lzdGVudCBhYm91dCBp
dCBhbmQgbWFrZSBzdXJlIGl0J3MgaW4gYWxsIHRoZSBiaW5kaW5ncyBhbmQgZGV2aWNlCj4gPiA+
ID4gPiB0cmVlIGZpbGVzLi4uCj4gPiA+ID4KPiA+ID4gPiBTdXJlLgo+ID4gPiA+Cj4gPiA+ID4g
SSBhbSBub3Qgc3VyZSB3aGF0J3MgdGhlIHJpZ2h0IHdheSB0byBkbyBpdCBpcywgaS5lLiBzaG91
bGQgd2Uga2VlcCB0aGUKPiA+ID4gPiAib3BlcmF0aW5nLXBvaW50cy12MiIgc3RyaW5nIG9yIG5v
dC4KPiA+ID4KPiA+ID4gRG9lcyBoYXZpbmcgaXQgYnV5IHlvdSBhbnl0aGluZz8gR2l2ZW4gdGhl
IFFDb20gb25lIGRvZXNuJ3QgaGF2ZSBhbnkKPiA+ID4gZnJlcXVlbmN5IG9yIHZvbHRhZ2UsIEkg
ZG9uJ3Qgc2VlIGhvdyBpdCB3b3VsZCBiZSB1c2VmdWwgdG8gaGF2ZSBpdC4KPiA+Cj4gPiAuLi5i
dXQgaXQgZG9lcyBoYXZlIGEgZnJlcXVlbmN5LCBkb2Vzbid0IGl0Pwo+ID4KPiA+ICsgICBjb21w
YXRpYmxlID0gIm9wZXJhdGluZy1wb2ludHMtdjItcWNvbS1sZXZlbCI7Cj4gPiArCj4gPiArICAg
b3BwLTcxMDAwMDAwMCB7Cj4gPiArICAgICBvcHAtaHogPSAvYml0cy8gNjQgPDcxMDAwMDAwMD47
Cj4gPiArICAgICBxY29tLGxldmVsID0gPFJQTUhfUkVHVUxBVE9SX0xFVkVMX1RVUkJPX0wxPjsK
PiA+ICsgICB9Owo+Cj4gQWgsIEkgcGVyaGFwcyBzZWUgdGhlIGNvbmZ1c2lvbi4gIFNvIFJhamVu
ZHJhJ3MgdXNhZ2Ugb2YKPiAib3BlcmF0aW5nLXBvaW50cy12Mi1xY29tLWxldmVsIiBbMV0gZG9l
c24ndCBoYXZlIGEgZnJlcXVlbmN5IGJ1dAo+IEpvcmRhbidzIGRvLiAgU28gSSBndWVzcyBpdCBt
YWtlcyBzZW5zZSB0aGF0IEpvcmRhbidzIGhhdmUgdGhlCj4gZmFsbGJhY2sgY29tcGF0aWJsZSBi
dXQgUmFqZW5kcmEncyBkb24ndD8KCklzIGhhdmluZyBpdCB1c2VmdWwgdG8gcy93IHRoYXQgZG9l
c24ndCB1bmRlcnN0YW5kCiJvcGVyYXRpbmctcG9pbnRzLXYyLXFjb20tbGV2ZWwiPyBJZiBzbywg
dGhlbiBhZGQKIm9wZXJhdGluZy1wb2ludHMtdjIiLiBJZiBub3QsIHRoZW4gZG9uJ3QuCgpJIGRv
bid0IHJlYWxseSBjYXJlIGVpdGhlciB3YXkuIEp1c3QgZG9uJ3QgZG8gYm90aCB3YXlzIGFuZCBk
b2N1bWVudAp3aGljaCB3YXkgaXMgY29ycmVjdC4KClJvYgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpGcmVlZHJlbm8gbWFpbGluZyBsaXN0CkZyZWVkcmVu
b0BsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9mcmVlZHJlbm8K
