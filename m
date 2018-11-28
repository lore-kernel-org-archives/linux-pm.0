From: Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add
 pm_runtime/sleep ops
Date: Wed, 28 Nov 2018 08:24:19 -0800
Message-ID: <154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
 <20181127101145.7682-2-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181127101145.7682-2-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

UXVvdGluZyBWaXZlayBHYXV0YW0gKDIwMTgtMTEtMjcgMDI6MTE6NDEpCj4gQEAgLTE5NjYsNiAr
MTk3MCwyMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhcm1fc21tdV9vZl9t
YXRjaFtdID0gewo+ICB9Owo+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhcm1fc21tdV9vZl9t
YXRjaCk7Cj4gIAo+ICtzdGF0aWMgdm9pZCBhcm1fc21tdV9maWxsX2Nsa19kYXRhKHN0cnVjdCBh
cm1fc21tdV9kZXZpY2UgKnNtbXUsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBjaGFyICogY29uc3QgKmNsa3MpCj4gK3sKPiArICAgICAgIGludCBpOwo+ICsKPiAr
ICAgICAgIGlmIChzbW11LT5udW1fY2xrcyA8IDEpCj4gKyAgICAgICAgICAgICAgIHJldHVybjsK
PiArCj4gKyAgICAgICBzbW11LT5jbGtzID0gZGV2bV9rY2FsbG9jKHNtbXUtPmRldiwgc21tdS0+
bnVtX2Nsa3MsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZigqc21t
dS0+Y2xrcyksIEdGUF9LRVJORUwpOwo+ICsgICAgICAgaWYgKCFzbW11LT5jbGtzKQo+ICsgICAg
ICAgICAgICAgICByZXR1cm47Cj4gKwo+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IHNtbXUtPm51
bV9jbGtzOyBpKyspCj4gKyAgICAgICAgICAgICAgIHNtbXUtPmNsa3NbaV0uaWQgPSBjbGtzW2ld
OwoKSXMgdGhpcyBjbGtfYnVsa19nZXRfYWxsKCk/CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpGcmVlZHJlbm8gbWFpbGluZyBsaXN0CkZyZWVkcmVub0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9mcmVlZHJlbm8K
