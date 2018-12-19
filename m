From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Wed, 19 Dec 2018 10:19:01 +0530
Message-ID: <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
 <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
 <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
 <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gMTgtMTItMTgsIDExOjA1LCBEb3VnIEFuZGVyc29uIHdyb3RlOgo+IE9LLCBpdCdzIGZpbmUg
d2l0aCBtZSB0byBoYXZlIHRoZSBmYWxsYmFjaywgYnV0IGlmIHdlIGRvIHdlIHNob3VsZCBiZQo+
IGNvbnNpc3RlbnQgYWJvdXQgaXQgYW5kIG1ha2Ugc3VyZSBpdCdzIGluIGFsbCB0aGUgYmluZGlu
Z3MgYW5kIGRldmljZQo+IHRyZWUgZmlsZXMuLi4KClN1cmUuCgpJIGFtIG5vdCBzdXJlIHdoYXQn
cyB0aGUgcmlnaHQgd2F5IHRvIGRvIGl0IGlzLCBpLmUuIHNob3VsZCB3ZSBrZWVwIHRoZQoib3Bl
cmF0aW5nLXBvaW50cy12MiIgc3RyaW5nIG9yIG5vdC4gQW5vdGhlciBleGFtcGxlIEkgc2VlIGlz
ICh3aGljaCBjYW4gYmUKY29tcGFyZWQgaGVyZSkgaXMgdGhlIGJvYXJkIHNwZWNpZmljIERUIGZp
bGVzLiBOb3JtYWxseSB0aGUgcm9vdCBub2RlJ3MKY29tcGF0aWJsZSBpcyBhIGxvbmcgbGlzdCBv
ZiBzdHJpbmdzIGxpa2U6Cgpjb21wYXRpYmxlID0gIm52aWRpYSxwMjM3MS0yMTgwIiwgIm52aWRp
YSxwMjE4MCIsICJudmlkaWEsdGVncmEyMTAiOwoKd2hpY2ggc3RhcnRzIGZyb20gcGxhdGZvcm0t
c3BlY2lmaWMgc3RyaW5nLCB0aGVuIG1hY2gsIHRoZW4gYm9hcmQsIGV0Yy4uCgpXZSBkbyBrZWVw
IGFsbCBvZiB0aGVtIGluIHRob3NlIGNhc2VzIGFuZCB0aGF0IG1ha2VzIG1lIHdvbmRlciB3aHkg
dGhlIHNhbWUKc2hvdWxkbid0IGJlIGRvbmUgZm9yIE9QUCBiaW5kaW5ncy4KCi0tIAp2aXJlc2gK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5v
IG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZnJlZWRyZW5vCg==
