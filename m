From: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v7 6/6] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Wed, 9 Jan 2019 15:02:17 +0530
Message-ID: <ead09599-f4f7-d505-8e22-4eb1869f9cf1@codeaurora.org>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-7-jcrouse@codeaurora.org>
 <CAD=FV=VRv82aHfd1dQ_8mjtFFu-u_=JxNGz1qYG+5apTsmBz2Q@mail.gmail.com>
 <CAD=FV=WZkOV95Ka2MVtHtUAYLjzKAZwwe=H87LJCefbm06ogeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAD=FV=WZkOV95Ka2MVtHtUAYLjzKAZwwe=H87LJCefbm06ogeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Georgi Djakov <georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

CgpPbiAxLzkvMjAxOSAxMDo1MCBBTSwgRG91ZyBBbmRlcnNvbiB3cm90ZToKPiAuLi5idXQgaW4g
dGhlIG1lYW50aW1lIFJhamVuZHJhIGhhcyBoYWQgdG8gY2hhbmdlIGhpcyBiaW5kaW5ncywgc28g
eW91Cj4gc3RpbGwgbmVlZCB0byBzcGluIHRoaXMgdG8gYWNjb3VudCBmb3IgUmFqZW5kcmEncyB2
OSBiaW5kaW5ncyBbMl0uCj4gU3BlY2lmaWNhbGx5IHlvdSBuZWVkIHRvIG1ha2UgY2hhbmdlcyBs
aWtlOgo+IAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJv
cGVyYXRpbmctcG9pbnRzLXYyLXFjb20tbGV2ZWwiOwo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJvcGVyYXRpbmctcG9pbnRzLXYyLWxldmVsIjsKCnNvIHRo
ZXJlJ3Mgbm93IGEgdjEwIFsxXSBhbmQgdGhlIG5ldyBjb21wYXRpYmxlIGlzIGNvbXBsZXRlbHkg
ZHJvcHBlZCBhbmQgb3BwLWxldmVsCmlzIG5vdyBhbiBvcHRpb25hbCBwcm9wZXJ0eSB1c2luZyB0
aGUgZGVmYXVsdCAib3BlcmF0aW5nLXBvaW50cy12MiIKCnNvIHRoZSBjaGFuZ2Ugc2hvdWxkIGJl
Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJvcGVyYXRpbmct
cG9pbnRzLXYyLXFjb20tbGV2ZWwiOworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAib3BlcmF0aW5nLXBvaW50cy12MiI7CgpbMV0gaHR0cHM6Ly9sa21sLm9yZy9s
a21sLzIwMTkvMS85LzE1MgoKLS0gClFVQUxDT01NIElORElBLCBvbiBiZWhhbGYgb2YgUXVhbGNv
bW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMgYSBtZW1iZXIKb2YgQ29kZSBBdXJvcmEgRm9y
dW0sIGhvc3RlZCBieSBUaGUgTGludXggRm91bmRhdGlvbgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpGcmVlZHJlbm8gbWFpbGluZyBsaXN0CkZyZWVkcmVu
b0BsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9mcmVlZHJlbm8K
