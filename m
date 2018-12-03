From: Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add
 pm_runtime/sleep ops
Date: Mon, 03 Dec 2018 15:44:34 -0800
Message-ID: <154388067496.88331.314679235652159449@swboyd.mtv.corp.google.com>
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
 <20181127101145.7682-2-vivek.gautam@codeaurora.org>
 <154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
 <0d76b669-6c4f-7c3b-50a1-084201f2c07a@arm.com>
 <CAFp+6iEC8hobAdVF5nLdhQdCUqbi1xa4Vi-NLugGshV=dg+h1A@mail.gmail.com>
 <20181130181536.GA15274@arm.com>
 <CAFp+6iH-T3KsUH8SDoLDfmJ6x_iHxtHGDySuKib0L_u46G6h6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFp+6iH-T3KsUH8SDoLDfmJ6x_iHxtHGDySuKib0L_u46G6h6w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

UXVvdGluZyBWaXZlayBHYXV0YW0gKDIwMTgtMTItMDIgMjI6NDM6MzgpCj4gT24gRnJpLCBOb3Yg
MzAsIDIwMTggYXQgMTE6NDUgUE0gV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+IHdy
b3RlOgo+ID4KPiA+IE9uIFRodSwgTm92IDI5LCAyMDE4IGF0IDA4OjI1OjIwUE0gKzA1MzAsIFZp
dmVrIEdhdXRhbSB3cm90ZToKPiA+ID4gY2xrX2J1bGtfZ2V0X2FsbCgpIHNlZW1zIGxpa2UgZ29p
bmcgb25seSB0aGUgT0Ygd2F5Lgo+ID4gPiBJcyB0aGVyZSBhbm90aGVyIHdheSBoZXJlIHRvIGhh
dmUgc29tZXRoaW5nIGNvbW1vbiBiZXR3ZWVuIEFDUEkKPiA+ID4gYW5kIE9GLCBhbmQgdGhlbiBk
byB0aGUgY2xrX2J1bGtfZ2V0Pwo+ID4KPiA+IEknZCBzYXkganVzdCBnbyB3aXRoIGNsa19idWxr
X2dldF9hbGwoKSBhbmQgaWYgc29tZWJvZHkgcmVhbGx5IHdhbnRzIHRvCj4gPiBtZXNzIHdpdGgg
dGhlIFNNTVUgY2xvY2tzIG9uIGEgc3lzdGVtIGJvb3RlZCB2aWEgQUNQSSwgdGhlbiBpdCdzIHRo
ZWlyCj4gPiBwcm9ibGVtIHRvIHNvbHZlLiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIGRl
c2lnbiBvZiBJT1JUIG1ha2VzIHRoaXMKPiA+IG5leHQgdG8gaW1wb3NzaWJsZSB0byBzb2x2ZSBh
bnl3YXksIGJlY2F1c2UgYSBzdGF0aWMgdGFibGUgaXMgdXNlZCBhbmQKPiA+IHRoZXJlZm9yZSB3
ZSdyZSB1bmFibGUgdG8gcnVuIHdoYXRldmVyIEFTTCBtZXRob2RzIG5lZWQgdG8gYmUgaW52b2tl
ZCB0bwo+ID4gbWVzcyB3aXRoIHRoZSBjbG9ja3MuCj4gCj4gU3VyZSB0aGVuLiBJIHdpbGwgcmVz
cGluIHRoaXMgcGF0Y2gtc2VyaWVzLgo+IAoKUmlnaHQuIFRoZSBpZGVhIGlzIHRvIGFkZCBub24t
T0Ygc3VwcG9ydCB0byBjbGtfYnVsa19nZXRfYWxsKCkgaWYvd2hlbgp3ZSBnZXQgdGhlIHJlcXVp
cmVtZW50LiBTb3VuZHMgbGlrZSB3ZSBjYW4ga2VlcCB3YWl0aW5nIGEgbGl0dGxlIGxvbmdlcgpm
b3IgdGhhdCB0byBoYXBwZW4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpGcmVlZHJlbm8gbWFpbGluZyBsaXN0CkZyZWVkcmVub0BsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9m
cmVlZHJlbm8K
