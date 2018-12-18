From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 5/6] dt-bindings: drm/msm/a6xx: Document
 GMU and update GPU bindings
Date: Tue, 18 Dec 2018 16:34:11 -0600
Message-ID: <20181218223411.GA12855@bogus>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-6-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181218183241.12830-6-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gVHVlLCAxOCBEZWMgMjAxOCAxMTozMjo0MCAtMDcwMCwgSm9yZGFuIENyb3VzZSB3cm90ZToK
PiBVcGRhdGUgdGhlIEdQVSBiaW5kaW5ncyBhbmQgZG9jdW1lbnQgdGhlIG5ldyBiaW5kaW5ncyBm
b3IgdGhlIEdNVQo+IGRldmljZSBmb3VuZCB3aXRoIEFkcmVubyBhNnh4IHRhcmdldHMuCj4gCj4g
U2lnbmVkLW9mZi1ieTogSm9yZGFuIENyb3VzZSA8amNyb3VzZUBjb2RlYXVyb3JhLm9yZz4KPiAt
LS0KPiAKPiB2NzogVXBkYXRlZCB0aGUgR01VIGNvbXBhdGlibGUgc3RyaW5nIGFuZCBjbGFyaWZp
ZWQgZGV0YWlscyBhYm91dCB3aGVuIGNsb2Nrcwo+IGNhbiBiZSBvcHRpb25hbCBvbiB0aGUgR1BV
Cj4gCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbXNtL2dtdS50eHQgICB8IDU5
ICsrKysrKysrKysrKysrKysrKysKPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9t
c20vZ3B1LnR4dCAgIHwgNDIgKysrKysrKysrKysrLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDk4IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tc20vZ211LnR4dAo+IAoKUmV2aWV3
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyZWVkcmVubyBtYWlsaW5nIGxpc3QKRnJlZWRy
ZW5vQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2ZyZWVkcmVubwo=
