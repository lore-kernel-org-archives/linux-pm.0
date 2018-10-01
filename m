From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v16 4/5] dt-bindings: arm-smmu: Add bindings
 for qcom, smmu-v2
Date: Mon, 1 Oct 2018 18:45:04 +0100
Message-ID: <20181001174503.GA14755@arm.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-5-vivek.gautam@codeaurora.org>
 <20181001121857.GA31488@arm.com>
 <CAL_Jsq+dSGXCiWsjLt00wu=s-ZW8M1pkQqKFWboc54M8gHFTYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+dSGXCiWsjLt00wu=s-ZW8M1pkQqKFWboc54M8gHFTYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBPY3QgMDEsIDIwMTggYXQgMTI6MzY6MDlQTSAtMDUwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6Cj4gT24gTW9uLCBPY3QgMSwgMjAxOCBhdCA3OjE4IEFNIFdpbGwgRGVhY29uIDx3aWxsLmRl
YWNvbkBhcm0uY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBUaHUsIEF1ZyAzMCwgMjAxOCBhdCAwODox
NTo0MFBNICswNTMwLCBWaXZlayBHYXV0YW0gd3JvdGU6Cj4gPiA+IEFkZCBiaW5kaW5ncyBkb2Mg
Zm9yIFFjb20ncyBzbW11LXYyIGltcGxlbWVudGF0aW9uLgo+ID4gPgo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBWaXZlayBHYXV0YW0gPHZpdmVrLmdhdXRhbUBjb2RlYXVyb3JhLm9yZz4KPiA+ID4gUmV2
aWV3ZWQtYnk6IFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJvbWl1bS5vcmc+Cj4gPiA+IFRlc3RlZC1i
eTogU3Jpbml2YXMgS2FuZGFnYXRsYSA8c3Jpbml2YXMua2FuZGFnYXRsYUBsaW5hcm8ub3JnPgo+
ID4gPiAtLS0KPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L2FybSxzbW11LnR4
dCAgICAgICAgIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDM5IGluc2VydGlvbnMoKykKPiA+Cj4gPiBJdCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgYW4g
QWNrIGZyb20gYSBEVCBtYWludGFpbmVyIG9uIHRoaXMsIHNpbmNlIGl0J3MKPiA+IGFkZGluZyBu
ZXcgY29tcGF0aWJsZSBzdHJpbmdzLi4uCj4gCj4gSSBkaWQuLi4KCk9vcHMsIHNvcnJ5LCBtaXNz
ZWQgdGhhdC4KCldpbGwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZnJlZWRy
ZW5vCg==
