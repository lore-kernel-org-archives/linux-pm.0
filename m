From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v6 5/6] iommu/arm-smmu: Add support for qcom,
 smmu-v2 variant
Date: Wed, 31 Jan 2018 17:30:34 +0530
Message-ID: <794c2b00-4430-1f82-01d2-cecd6df7b223@codeaurora.org>
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
 <1516362223-22946-6-git-send-email-vivek.gautam@codeaurora.org>
 <20180129194251.3iypqdd4tz7zti6w@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180129194251.3iypqdd4tz7zti6w@rob-hp-laptop>
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
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

CgpPbiAxLzMwLzIwMTggMToxMiBBTSwgUm9iIEhlcnJpbmcgd3JvdGU6Cj4gT24gRnJpLCBKYW4g
MTksIDIwMTggYXQgMDU6MTM6NDJQTSArMDUzMCwgVml2ZWsgR2F1dGFtIHdyb3RlOgo+PiBxY29t
LHNtbXUtdjIgaXMgYW4gYXJtLHNtbXUtdjIgaW1wbGVtZW50YXRpb24gd2l0aCBzcGVjaWZpYwo+
PiBjbG9jayBhbmQgcG93ZXIgcmVxdWlyZW1lbnRzLiBUaGlzIHNtbXUgY29yZSBpcyB1c2VkIHdp
dGgKPj4gbXVsdGlwbGUgbWFzdGVycyBvbiBtc204OTk2LCB2aXouIG1kc3MsIHZpZGVvLCBldGMu
Cj4+IEFkZCBiaW5kaW5ncyBmb3IgdGhlIHNhbWUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFZpdmVr
IEdhdXRhbSA8dml2ZWsuZ2F1dGFtQGNvZGVhdXJvcmEub3JnPgo+PiAtLS0KPj4gICAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9pb21tdS9hcm0sc21tdS50eHQgICAgICAgICB8IDQzICsrKysrKysr
KysrKysrKysrKysrKysKPj4gICBkcml2ZXJzL2lvbW11L2FybS1zbW11LmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDEzICsrKysrKysKPj4gICAyIGZpbGVzIGNoYW5nZWQsIDU2IGluc2Vy
dGlvbnMoKykKPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KClRo
YW5rcyBSb2IuCgo+IC0tCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhl
IGxpbmUgInVuc3Vic2NyaWJlIGxpbnV4LWFybS1tc20iIGluCj4gdGhlIGJvZHkgb2YgYSBtZXNz
YWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcKPiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0
ICBodHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyZWVkcmVubyBtYWlsaW5nIGxp
c3QKRnJlZWRyZW5vQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ZyZWVkcmVubwo=
