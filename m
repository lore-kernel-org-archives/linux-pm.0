From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/msm: Add A6XX device support
Date: Mon, 5 Mar 2018 10:09:38 +0530
Message-ID: <20180305043938.GB23018@vireshk-i7>
References: <20180302214329.1086-1-jcrouse@codeaurora.org>
 <20180302214329.1086-4-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180302214329.1086-4-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: nm-l0cyMroinI0@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gMDItMDMtMTgsIDE0OjQzLCBKb3JkYW4gQ3JvdXNlIHdyb3RlOgo+ICtzdGF0aWMgaW50IGE2
eHhfZ211X2J1aWxkX2ZyZXFfdGFibGUoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBsb25n
ICpmcmVxcywKPiArCQl1MzIgc2l6ZSkKPiArewo+ICsJaW50IGNvdW50ID0gZGV2X3BtX29wcF9n
ZXRfb3BwX2NvdW50KGRldik7Cj4gKwlzdHJ1Y3QgZGV2X3BtX29wcCAqb3BwOwo+ICsJaW50IGks
IGluZGV4ID0gMDsKPiArCXVuc2lnbmVkIGxvbmcgZnJlcSA9IDE7Cj4gKwo+ICsJLyoKPiArCSAq
IFRoZSBPUFAgdGFibGUgZG9lc24ndCBjb250YWluIHRoZSAib2ZmIiBmcmVxdWVuY3kgbGV2ZWwg
c28gd2UgbmVlZCB0bwo+ICsJICogYWRkIDEgdG8gdGhlIHRhYmxlIHNpemUgdG8gYWNjb3VudCBm
b3IgaXQKPiArCSAqLwo+ICsKPiArCWlmIChXQVJOKGNvdW50ICsgMSA+IHNpemUsCj4gKwkJIlRo
ZSBHTVUgZnJlcXVlbmN5IHRhYmxlIGlzIGJlaW5nIHRydW5jYXRlZFxuIikpCj4gKwkJY291bnQg
PSBzaXplIC0gMTsKPiArCj4gKwkvKiBTZXQgdGhlICJvZmYiIGZyZXF1ZW5jeSAqLwo+ICsJZnJl
cXNbaW5kZXgrK10gPSAwOwo+ICsKPiArCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7Cj4g
KwkJb3BwID0gZGV2X3BtX29wcF9maW5kX2ZyZXFfY2VpbChkZXYsICZmcmVxKTsKPiArCQlpZiAo
SVNfRVJSKG9wcCkpCj4gKwkJCWJyZWFrOwo+ICsKPiArCQlmcmVxc1tpbmRleCsrXSA9IGZyZXEr
KzsKCglkZXZfcG1fb3BwX3B1dChvcHApID8KCj4gKwl9Cj4gKwo+ICsJcmV0dXJuIGluZGV4Owo+
ICt9Cj4gKwotLSAKdmlyZXNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkZyZWVkcmVubyBtYWlsaW5nIGxpc3QKRnJlZWRyZW5vQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Zy
ZWVkcmVubwo=
