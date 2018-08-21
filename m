From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v14 0/4] iommu/arm-smmu: Add runtime
 pm/sleep support
Date: Tue, 21 Aug 2018 14:03:44 +0100
Message-ID: <afc4be51-56b1-6455-71e1-d2fddd622426@linaro.org>
References: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180727070224.23966-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

CgpPbiAyNy8wNy8xOCAwODowMiwgVml2ZWsgR2F1dGFtIHdyb3RlOgo+IFNyaWNoYXJhbiBSICgz
KToKPiAgICBpb21tdS9hcm0tc21tdTogQWRkIHBtX3J1bnRpbWUvc2xlZXAgb3BzCj4gICAgaW9t
bXUvYXJtLXNtbXU6IEludm9rZSBwbV9ydW50aW1lIGR1cmluZyBwcm9iZSwgYWRkL3JlbW92ZSBk
ZXZpY2UKPiAgICBpb21tdS9hcm0tc21tdTogQWRkIHRoZSBkZXZpY2VfbGluayBiZXR3ZWVuIG1h
c3RlcnMgYW5kIHNtbXUKPiAKPiBWaXZlayBHYXV0YW0gKDEpOgo+ICAgIGlvbW11L2FybS1zbW11
OiBBZGQgc3VwcG9ydCBmb3IgcWNvbSxzbW11LXYyIHZhcmlhbnQKPiAKPiAgIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2lvbW11L2FybSxzbW11LnR4dCAgICAgICAgIHwgIDQyICsrKysrCj4gICBk
cml2ZXJzL2lvbW11L2FybS1zbW11LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE5NCAr
KysrKysrKysrKysrKysrKysrLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjI1IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQpNU004ODk2IGF1ZGlvIGFuZCBkaXNwbGF5IG9uIHRvcCBvZiBt
YWlubGluZSB0b3RhbGx5IGRlcGVuZHMgb24gdGhpcyAKcGF0Y2hlcywgSSBoYXZlIGJlZW4gdGVz
dGluZyB2YXJpb3VzIHZlcnNpb24gdGhpcyBzZXJpZXMgb24gREI4MjBjIGZvciAKYm90aCBkaXNw
bGF5IGFuZCBhdWRpby4KClRlc3RlZC1ieTogU3Jpbml2YXMgS2FuZGFnYXRsYSA8c3Jpbml2YXMu
a2FuZGFnYXRsYUBsaW5hcm8ub3JnPgoKCi0tc3JpbmkKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9A
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZnJlZWRyZW5vCg==
