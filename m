From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 5/6] iommu/arm-smmu: Add support for qcom,
 smmu-v2 variant
Date: Fri, 12 Jan 2018 10:59:17 +0530
Message-ID: <e1ef7c93-aba4-e5e7-bb49-552316274439@codeaurora.org>
References: <1515492109-753-1-git-send-email-vivek.gautam@codeaurora.org>
 <1515492109-753-6-git-send-email-vivek.gautam@codeaurora.org>
 <20180111222304.js3c3vrx3u5j3hvj@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180111222304.js3c3vrx3u5j3hvj@rob-hp-laptop>
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
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

SGkgUm9iLAoKCk9uIDAxLzEyLzIwMTggMDM6NTMgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOgo+IE9u
IFR1ZSwgSmFuIDA5LCAyMDE4IGF0IDAzOjMxOjQ4UE0gKzA1MzAsIFZpdmVrIEdhdXRhbSB3cm90
ZToKPj4gcWNvbSxzbW11LXYyIGlzIGFuIGFybSxzbW11LXYyIGltcGxlbWVudGF0aW9uIHdpdGgg
c3BlY2lmaWMKPj4gY2xvY2sgYW5kIHBvd2VyIHJlcXVpcmVtZW50cy4gVGhpcyBzbW11IGNvcmUg
aXMgdXNlZCB3aXRoCj4+IG11bHRpcGxlIG1hc3RlcnMgb24gbXNtODk5Niwgdml6LiBtZHNzLCB2
aWRlbywgZXRjLgo+PiBBZGQgYmluZGluZ3MgZm9yIHRoZSBzYW1lLgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBWaXZlayBHYXV0YW0gPHZpdmVrLmdhdXRhbUBjb2RlYXVyb3JhLm9yZz4KPj4gLS0tCj4+
Cj4+ICAgKiBNYWpvciBjaGFuZ2UgaW4gdGhpcyBwYXRjaCAtCj4+ICAgICBDaGFuZ2VkIGNvbXBh
dGlibGUgc3RyaW5nIGZyb20gJ3Fjb20sbXNtODk5Ni1zbW11LXYyJyB0bwo+PiAgICAgJ3Fjb20s
c21tdS12MicgdG8gcmVmbGVjdCB0aGUgSVAgdmVyc2lvbiByYXRoZXIgdGhhbiB0aGUKPj4gICAg
IHBsYXRmb3JtIG9uIHdoaWNoIGl0IGlzIHVzZWQuCj4gVGhlIGJ1Z3MgYW5kIGhvdyB0aGluZ3Mg
YXJlIGNvbm5lY3RlZCBhcmUgYWxsIHRoZSBzYW1lPyBJJ2Qgc3VnZ2VzdCB5b3UKPiBrZWVwIGJv
dGggc3RyaW5ncy4KClN1cmUsCiAgICAgY29tcGF0aWJsZSA9ICJxY29tLG1zbTg5OTYtc21tdS12
MiIsICJxY29tLHNtbXUtdjIiOwoKPgo+PiAgICAgVGhlIHNhbWUgSVAgaXMgdXNlZCBhY3Jvc3Mg
bXVsdGlwbGUgcGxhdGZvcm1zIGluY2x1ZGluZyBtc204OTk2LAo+PiAgICAgYW5kIHNkbTg0NSBl
dGMuCj4gQnV0IGZvciBvbmx5IDIgb3Igc28gcGxhdGZvcm1zIGEgZmFsbGJhY2sgaXMgbm90IHJl
YWxseSB3b3J0aCBpdC4gWW91J2xsCj4gcHJvYmFibHkgYmUgb24gU01NVXYzIGJlZm9yZSB0b28g
bG9uZy4uLgpSaWdodC4gVGhlcmUncyBtc204OTk4IGFzIHdlbGwsIGJ1dCBhcyB5b3Ugc2FpZCBr
ZWVwaW5nIGJvdGggc3RyaW5ncwp3aWxsIG1ha2UgbW9yZSBzZW5zZS4KVGhhbmtzLgoKQmVzdCBy
ZWdhcmRzClZpdmVrCgpbc25pcF0KCi0tIApUaGUgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIs
IEluYy4gaXMgYSBtZW1iZXIgb2YgQ29kZSBBdXJvcmEgRm9ydW0sCmEgTGludXggRm91bmRhdGlv
biBDb2xsYWJvcmF0aXZlIFByb2plY3QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkZyZWVkcmVubyBtYWlsaW5nIGxpc3QKRnJlZWRyZW5vQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2ZyZWVkcmVubwo=
