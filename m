From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7 1/6] drm/msm/gpu: Remove hardcoded
 interrupt name
Date: Tue, 18 Dec 2018 14:54:13 -0800
Message-ID: <CAD=FV=VU+7LNkDke59cbXXcF=tEExALW+N24iEZn3vXMBuMZAg@mail.gmail.com>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-2-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181218183241.12830-2-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Georgi Djakov <georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

SGksCgpPbiBUdWUsIERlYyAxOCwgMjAxOCBhdCAxMDozMiBBTSBKb3JkYW4gQ3JvdXNlIDxqY3Jv
dXNlQGNvZGVhdXJvcmEub3JnPiB3cm90ZToKPgo+IEV2ZXJ5IEdQVSBjb3JlIG9ubHkgaGFzIG9u
ZSBpbnRlcnJ1cHQgc28gdGhlcmUgaXNuJ3QgYW55Cj4gdmFsdWUgaW4gbG9va2luZyB1cCB0aGUg
aW50ZXJydXB0IGJ5IG5hbWUuIFJlbW92ZSB0aGUgbmFtZSAod2hpY2gKPiBpcyBsZWdhY3kgYW55
d2F5KSBhbmQgdXNlIHBsYXRmb3JtX2dldF9pcnEoKSBpbnN0ZWFkLgo+Cj4gU2lnbmVkLW9mZi1i
eTogSm9yZGFuIENyb3VzZSA8amNyb3VzZUBjb2RlYXVyb3JhLm9yZz4KPiAtLS0KPiAgZHJpdmVy
cy9ncHUvZHJtL21zbS9hZHJlbm8vYWRyZW5vX2dwdS5jIHwgMSAtCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tc20vbXNtX2dwdS5jICAgICAgICAgICB8IDIgKy0KPiAgZHJpdmVycy9ncHUvZHJtL21zbS9t
c21fZ3B1LmggICAgICAgICAgIHwgMSAtCj4gIDMgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDMgZGVsZXRpb25zKC0pCgpSZXZpZXdlZC1ieTogRG91Z2xhcyBBbmRlcnNvbiA8ZGlhbmRl
cnNAY2hyb21pdW0ub3JnPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpGcmVlZHJlbm8gbWFpbGluZyBsaXN0CkZyZWVkcmVub0BsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9mcmVl
ZHJlbm8K
