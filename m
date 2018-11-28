From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add
 pm_runtime/sleep ops
Date: Wed, 28 Nov 2018 16:36:36 +0000
Message-ID: <0d76b669-6c4f-7c3b-50a1-084201f2c07a@arm.com>
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
 <20181127101145.7682-2-vivek.gautam@codeaurora.org>
 <154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <154342225921.88331.14467967828250776155-n1Xw8LXHxjTHt/MElyovVYaSKrA+ACpX0E9HWUfgJXw@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gMjgvMTEvMjAxOCAxNjoyNCwgU3RlcGhlbiBCb3lkIHdyb3RlOgo+IFF1b3RpbmcgVml2ZWsg
R2F1dGFtICgyMDE4LTExLTI3IDAyOjExOjQxKQo+PiBAQCAtMTk2Niw2ICsxOTcwLDIzIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGFybV9zbW11X29mX21hdGNoW10gPSB7Cj4+
ICAgfTsKPj4gICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhcm1fc21tdV9vZl9tYXRjaCk7Cj4+
ICAgCj4+ICtzdGF0aWMgdm9pZCBhcm1fc21tdV9maWxsX2Nsa19kYXRhKHN0cnVjdCBhcm1fc21t
dV9kZXZpY2UgKnNtbXUsCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3QgY2hhciAqIGNvbnN0ICpjbGtzKQo+PiArewo+PiArICAgICAgIGludCBpOwo+PiArCj4+ICsg
ICAgICAgaWYgKHNtbXUtPm51bV9jbGtzIDwgMSkKPj4gKyAgICAgICAgICAgICAgIHJldHVybjsK
Pj4gKwo+PiArICAgICAgIHNtbXUtPmNsa3MgPSBkZXZtX2tjYWxsb2Moc21tdS0+ZGV2LCBzbW11
LT5udW1fY2xrcywKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZigq
c21tdS0+Y2xrcyksIEdGUF9LRVJORUwpOwo+PiArICAgICAgIGlmICghc21tdS0+Y2xrcykKPj4g
KyAgICAgICAgICAgICAgIHJldHVybjsKPj4gKwo+PiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBz
bW11LT5udW1fY2xrczsgaSsrKQo+PiArICAgICAgICAgICAgICAgc21tdS0+Y2xrc1tpXS5pZCA9
IGNsa3NbaV07Cj4gCj4gSXMgdGhpcyBjbGtfYnVsa19nZXRfYWxsKCk/CgpPb2gsIGRpZCB0aGF0
IGZpbmFsbHkgZ2V0IG1lcmdlZCB3aGlsZSB3ZSB3ZXJlbid0IGxvb2tpbmc/IEdyZWF0IQoKTXVj
aCBhcyBJIGRvbid0IHdhbnQgdG8gZHJhZyB0aGlzIHNlcmllcyBvdXQgdG8gYSB2MTksIGl0ICp3
b3VsZCogYmUgCm5lYXQgaWYgd2Ugbm8gbG9uZ2VyIG5lZWQgdG8gb3Blbi1jb2RlIHRoYXQgYml0
Li4uCgpSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZnJlZWRyZW5v
Cg==
