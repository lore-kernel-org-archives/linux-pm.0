From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v16 2/5] iommu/arm-smmu: Invoke pm_runtime
 during probe, add/remove device
Date: Tue, 2 Oct 2018 09:44:54 +0530
Message-ID: <CAFp+6iGkudBtZFfk4ST+k9OMRSGgU=pzVGC4QaSmPb+Xkdp3Xw@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-3-vivek.gautam@codeaurora.org>
 <20181001125854.GB31488@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181001125854.GB31488-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

SGkgV2lsbCwKCk9uIE1vbiwgT2N0IDEsIDIwMTggYXQgNjoyOSBQTSBXaWxsIERlYWNvbiA8d2ls
bC5kZWFjb25AYXJtLmNvbT4gd3JvdGU6Cj4KPiBIaSBWaXZlaywKPgo+IE9uIFRodSwgQXVnIDMw
LCAyMDE4IGF0IDA4OjE1OjM4UE0gKzA1MzAsIFZpdmVrIEdhdXRhbSB3cm90ZToKPiA+IEZyb206
IFNyaWNoYXJhbiBSIDxzcmljaGFyYW5AY29kZWF1cm9yYS5vcmc+Cj4gPgo+ID4gVGhlIHNtbXUg
ZGV2aWNlIHByb2JlL3JlbW92ZSBhbmQgYWRkL3JlbW92ZSBtYXN0ZXIgZGV2aWNlIGNhbGxiYWNr
cwo+ID4gZ2V0cyBjYWxsZWQgd2hlbiB0aGUgc21tdSBpcyBub3QgbGlua2VkIHRvIGl0cyBtYXN0
ZXIsIHRoYXQgaXMgd2l0aG91dAo+ID4gdGhlIGNvbnRleHQgb2YgdGhlIG1hc3RlciBkZXZpY2Uu
IFNvIGNhbGxpbmcgcnVudGltZSBhcGlzIGluIHRob3NlIHBsYWNlcwo+ID4gc2VwYXJhdGVseS4K
PiA+IEdsb2JhbCBsb2NrcyBhcmUgYWxzbyBpbml0aWFsaXplZCBiZWZvcmUgZW5hYmxpbmcgcnVu
dGltZSBwbSBhcyB0aGUKPiA+IHJ1bnRpbWVfcmVzdW1lKCkgY2FsbHMgZGV2aWNlX3Jlc2V0KCkg
d2hpY2ggZG9lcyB0bGJfc3luY19nbG9iYWwoKQo+ID4gdGhhdCB1bHRpbWF0ZWx5IHJlcXVpcmVz
IGxvY2tzIHRvIGJlIGluaXRpYWxpemVkLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFNyaWNoYXJh
biBSIDxzcmljaGFyYW5AY29kZWF1cm9yYS5vcmc+Cj4gPiBbdml2ZWs6IENsZWFudXAgcG0gcnVu
dGltZSBjYWxsc10KPiA+IFNpZ25lZC1vZmYtYnk6IFZpdmVrIEdhdXRhbSA8dml2ZWsuZ2F1dGFt
QGNvZGVhdXJvcmEub3JnPgo+ID4gUmV2aWV3ZWQtYnk6IFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJv
bWl1bS5vcmc+Cj4gPiBUZXN0ZWQtYnk6IFNyaW5pdmFzIEthbmRhZ2F0bGEgPHNyaW5pdmFzLmth
bmRhZ2F0bGFAbGluYXJvLm9yZz4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvaW9tbXUvYXJtLXNtbXUu
YyB8IDg5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Cj4g
VGhpcyBkb2Vzbid0IGFwcGx5IG9uIG15IHRyZWVbMV0sIHBvc3NpYmx5IGJlY2F1c2UgSSd2ZSBn
b3QgUm9iaW4ncyBub24tc3RyaWN0Cj4gaW52YWxpZGF0aW9uIHF1ZXVlZCB0aGVyZS4gSG93ZXZl
ciwgdGhhdCBnb3QgbWUgdGhpbmtpbmcgLS0gaG93IGRvZXMgdGhpcwo+IHdvcmsgaW4gY29uanVu
Y3Rpb24gd2l0aCB0aGUgdGltZXItYmFzZWQgVExCIGludmFsaWRhdGlvbj8gRG8gd2UgbmVlZCB0
bwo+IHJwbV97Z2V0LHB1dH0gYXJvdW5kIGZsdXNoX2lvdGxiX2FsbCgpPyBJZiBzbywgZG8gd2Ug
c3RpbGwgbmVlZCB0aGUgY2FsbHMKPiBpbiBtYXAvdW5tYXAgd2hlbiBub24tc3RyaWN0IG1vZGUg
aXMgaW4gdXNlPwoKSSBoYXZlbid0IHRlc3RlZCB0aGluZ3Mgd2l0aCBmbHVzaCBxdWV1ZXMsIGJ1
dCBmcm9tIHdoYXQgaXQgbG9va3MgbGlrZQpib3RoIC5mbHVzaF9pb3RsYl9hbGwsIGFuZCAuaW90
bGJfc3luYyBjYWxsYmFja3MgbmVlZCBycG1fZ2V0L3B1dCgpLgpJIHdpbGwgcmVzcGluIHRoZSBw
YXRjaGVzLgoKVGhhbmtzClZpdmVrCj4KPiBXaWxsCj4KPiBbMV0gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvd2lsbC9saW51eC5naXQvbG9nLz9oPWZvci1q
b2VyZy9hcm0tc21tdS91cGRhdGVzCgoKCi0tIApRVUFMQ09NTSBJTkRJQSwgb24gYmVoYWxmIG9m
IFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIGlzIGEgbWVtYmVyCm9mIENvZGUgQXVy
b3JhIEZvcnVtLCBob3N0ZWQgYnkgVGhlIExpbnV4IEZvdW5kYXRpb24KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApG
cmVlZHJlbm9AbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZnJlZWRyZW5vCg==
