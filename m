From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
Date: Thu, 20 Dec 2018 13:29:24 -0800
Message-ID: <154534136449.79149.14097954220921296509@swboyd.mtv.corp.google.com>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
 <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
 <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
 <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
 <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Doug Anderson <dianders@chromium.org>, Rob Herring <robh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

UXVvdGluZyBSb2IgSGVycmluZyAoMjAxOC0xMi0xOSAxNTo0NzoyNSkKPiBPbiBXZWQsIERlYyAx
OSwgMjAxOCBhdCA0OjQwIFBNIERvdWcgQW5kZXJzb24gPGRpYW5kZXJzQGNocm9taXVtLm9yZz4g
d3JvdGU6Cj4gPiBPbiBXZWQsIERlYyAxOSwgMjAxOCBhdCAxMjo0MCBQTSBEb3VnIEFuZGVyc29u
IDxkaWFuZGVyc0BjaHJvbWl1bS5vcmc+IHdyb3RlOgo+ID4gPiBPbiBXZWQsIERlYyAxOSwgMjAx
OCBhdCAxMjowOSBQTSBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4g
Li4uYnV0IGl0IGRvZXMgaGF2ZSBhIGZyZXF1ZW5jeSwgZG9lc24ndCBpdD8KPiA+ID4KPiA+ID4g
KyAgIGNvbXBhdGlibGUgPSAib3BlcmF0aW5nLXBvaW50cy12Mi1xY29tLWxldmVsIjsKPiA+ID4g
Kwo+ID4gPiArICAgb3BwLTcxMDAwMDAwMCB7Cj4gPiA+ICsgICAgIG9wcC1oeiA9IC9iaXRzLyA2
NCA8NzEwMDAwMDAwPjsKPiA+ID4gKyAgICAgcWNvbSxsZXZlbCA9IDxSUE1IX1JFR1VMQVRPUl9M
RVZFTF9UVVJCT19MMT47Cj4gPiA+ICsgICB9Owo+ID4KPiA+IEFoLCBJIHBlcmhhcHMgc2VlIHRo
ZSBjb25mdXNpb24uICBTbyBSYWplbmRyYSdzIHVzYWdlIG9mCj4gPiAib3BlcmF0aW5nLXBvaW50
cy12Mi1xY29tLWxldmVsIiBbMV0gZG9lc24ndCBoYXZlIGEgZnJlcXVlbmN5IGJ1dAo+ID4gSm9y
ZGFuJ3MgZG8uICBTbyBJIGd1ZXNzIGl0IG1ha2VzIHNlbnNlIHRoYXQgSm9yZGFuJ3MgaGF2ZSB0
aGUKPiA+IGZhbGxiYWNrIGNvbXBhdGlibGUgYnV0IFJhamVuZHJhJ3MgZG9uJ3Q/Cj4gCj4gSXMg
aGF2aW5nIGl0IHVzZWZ1bCB0byBzL3cgdGhhdCBkb2Vzbid0IHVuZGVyc3RhbmQKPiAib3BlcmF0
aW5nLXBvaW50cy12Mi1xY29tLWxldmVsIj8gSWYgc28sIHRoZW4gYWRkCj4gIm9wZXJhdGluZy1w
b2ludHMtdjIiLiBJZiBub3QsIHRoZW4gZG9uJ3QuCgpUaGUgb25seSBiZW5lZml0IEkgc2VlIGlu
IGhhdmluZyAib3BlcmF0aW5nLXBvaW50cy12MiIgaXMgdGhhdCB3ZSBkb24ndApuZWVkIHRvIHVw
ZGF0ZSB0aGUgb2Zfc2tpcHBlZF9ub2RlX3RhYmxlW10gaW4gZHJpdmVycy9wbGF0Zm9ybS9vZi5j
IHRvCmhhdmUgYWxsIHRoZSB2YXJpYW50cyBvZiBvcGVyYXRpbmctcG9pbnRzLXYyLSogd2hlbiB0
aGV5IGRlY2lkZSB0byBub3QKdXNlIGFueXRoaW5nIGZyb20gdGhlICJiYXNlIiBiaW5kaW5nLgoK
SWYgdGhhdCBmYWlscyB0byB3b3JrIGJlY2F1c2Ugb3BwLWh6IGlzIHJlcXVpcmVkIGZvciB0aGUK
Im9wZXJhdGluZy1wb2ludHMtdjIiIGJpbmRpbmcgYnV0IHNvbWV0aW1lcwpvcGVyYXRpbmctcG9p
bnRzLXYyLXFjb20tbGV2ZWwgZG9lc24ndCByZXF1aXJlIGl0IEkgZ3Vlc3Mgd2UgbmVlZCB0bwp1
cGRhdGUgdGhlIHNraXAgdGFibGUgb3IgbWFrZSBzb21lIGdlbmVyaWMgcHJvcGVydHkgbGlrZQon
dGhpcy1pcy1ub3QtYS1kZXZpY2UnIHRoYXQgdGhlc2UgdmFyaW91cyBkYXRhIHRhYmxlcyBpbiBE
VCBjYW4gYmUKbWFya2VkIHdpdGggc28gd2UgZG9uJ3QgbWFrZSBwbGF0Zm9ybSBkZXZpY2VzIGZv
ciB0aGVtLgoKUmVnYXJkbGVzcyBvZiB0aGUgYWJvdmUsIHdlIHNob3VsZCB1cGRhdGUgdGhlIGJp
bmRpbmcgZm9yCm9wZXJhdGluZy1wb2ludHMtdjItcWNvbS1sZXZlbCB0byBzYXkgdGhhdCBvcHAt
aHogaXNuJ3QgYWx3YXlzIHJlcXVpcmVkCndoZW4gdGhlIHFjb20tbGV2ZWwgY29tcGF0aWJsZSBp
cyBwcmVzZW50LiBJdCBsb29rcyBsaWtlIGl0IGp1c3Qgc2F5cwp0aGF0IGl0IGJ1aWxkcyBvbiB0
b3Agb2YgdGhlIG9wcCBiaW5kaW5nIHNvIHRoYXQncyBub3Qgb2J2aW91cy4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
