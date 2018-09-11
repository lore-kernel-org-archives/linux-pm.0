From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v16 4/5] dt-bindings: arm-smmu: Add bindings
 for qcom, smmu-v2
Date: Tue, 11 Sep 2018 14:04:19 +0530
Message-ID: <CAFp+6iHxe2bRY57ZhpOKbXuR9E9+9JtMhuO-PazRPTsiSZDnQg@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-5-vivek.gautam@codeaurora.org>
 <20180910180224.GA22566@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180910180224.GA22566@bogus>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBTZXAgMTAsIDIwMTggYXQgMTE6MzIgUE0gUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVs
Lm9yZz4gd3JvdGU6Cj4KPiBPbiBUaHUsIDMwIEF1ZyAyMDE4IDIwOjE1OjQwICswNTMwLCBWaXZl
ayBHYXV0YW0gd3JvdGU6Cj4gPiBBZGQgYmluZGluZ3MgZG9jIGZvciBRY29tJ3Mgc21tdS12MiBp
bXBsZW1lbnRhdGlvbi4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXZlayBHYXV0YW0gPHZpdmVr
LmdhdXRhbUBjb2RlYXVyb3JhLm9yZz4KPiA+IFJldmlld2VkLWJ5OiBUb21hc3ogRmlnYSA8dGZp
Z2FAY2hyb21pdW0ub3JnPgo+ID4gVGVzdGVkLWJ5OiBTcmluaXZhcyBLYW5kYWdhdGxhIDxzcmlu
aXZhcy5rYW5kYWdhdGxhQGxpbmFyby5vcmc+Cj4gPiAtLS0KPiA+ICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9pb21tdS9hcm0sc21tdS50eHQgICAgICAgICB8IDM5ICsrKysrKysrKysrKysrKysr
KysrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKQo+ID4KPgo+IFJldmll
d2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgoKVGhhbmtzIFJvYi4KCkJlc3Qg
cmVnYXJkcwpWaXZlawoKCi0tIApRVUFMQ09NTSBJTkRJQSwgb24gYmVoYWxmIG9mIFF1YWxjb21t
IElubm92YXRpb24gQ2VudGVyLCBJbmMuIGlzIGEgbWVtYmVyCm9mIENvZGUgQXVyb3JhIEZvcnVt
LCBob3N0ZWQgYnkgVGhlIExpbnV4IEZvdW5kYXRpb24KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9A
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZnJlZWRyZW5vCg==
