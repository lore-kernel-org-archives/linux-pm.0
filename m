From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Support GPU/GMU
Date: Fri, 9 Mar 2018 09:13:32 +0530
Message-ID: <20180309034332.GO6842@vireshk-i7>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
 <20180302215638.6145-3-jcrouse@codeaurora.org>
 <20180305044221.GC23018@vireshk-i7>
 <20180305152818.GC15200@jcrouse-lnx.qualcomm.com>
 <20180306042656.GJ23018@vireshk-i7>
 <20180306153757.GD15200@jcrouse-lnx.qualcomm.com>
 <20180307050624.GR23018@vireshk-i7>
 <20180308201438.GA10589@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180308201438.GA10589-9PYrDHPZ2Orvke4nUoYGnHL1okKdlPRT@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gMDgtMDMtMTgsIDEzOjE0LCBKb3JkYW4gQ3JvdXNlIHdyb3RlOgo+IEl0IHNlZW1zIHRvIG1l
IHRoYXQgcGVyZm9ybWFuY2Vfc3RhdGUgaGFzIGEgZGlyZWN0IHJlbGF0aW9uc2hpcCB3aXRoIGdl
bnBkCj4gd2hpY2ggaXMgZ29vZCBmb3IgQ1BVIHZvdGVzIGJ1dCBpbiB0aGlzIGNhc2UsIHdlJ3Jl
IGp1c3QgcGFzc2luZyBhbG9uZyByYXcgZGF0YQo+IHRvIGFuIGluZGVwZW5kZW50IG1pY3JvY29u
dHJvbGxlci4gVGhlICdxY29tLGFyYy1sZXZlbCcgaXMgdXNlZCB0byBjb25zdHJ1Y3QKPiB0aGUg
YWN0dWFsIHZhbHVlcyB0aGF0IHRoZSBHTVUgd2lsbCBwcm9ncmFtIGludG8gdGhlIFJQTWguIFNp
bmNlIHRoZXNlIGFyZQoKVGhlICJnZW5wZCIgaGVyZSBpcyBjcmVhdGVkIHNwZWNpYWxseSBmb3Ig
dGhpcyBSUE0uIFRoZSBwZXJmb3JtYW5jZS1zdGF0ZSB0aGluZwppcyBkZXNpZ25lZCB0byBzb2x2
ZSB0aGlzIHZlcnkgc3BlY2lmaWMgcHJvYmxlbSBvZiBxdWFsY29tbSBTb0NzIGFuZCB0aGVyZSBp
cyBubwp3YXkgd2UgYXJlIGdvaW5nIHRvIGFkZCBhbm90aGVyIHByb3BlcnR5IGZvciB0aGlzIG5v
dy4KCj4gaW5mb3JtYXRpb25hbCAoZnJvbSB0aGUgQ1BVIHBlcnNwZWN0aXZlKSByYXRoZXIgdGhh
biBmdW5jdGlvbmFsIEkgZmVlbCBsaWtlCj4gdGhhdCB1c2luZyBwZXJmb3JtYW5jZV9zdGF0ZSBm
b3IgdGhpcyB3b3VsZCBiZSBhcyBoYWNreSBhcyB1c2luZyBvcHAtbWljcm92b2x0Cj4gb3Igc29t
ZXRoaW5nIGVsc2UuCgpUaGVyZSBpcyBzb21lIFdJUCBzdHVmZiBoZXJlIFJhamVuZHJhIGlzIHRl
c3RpbmcgY3VycmVudGx5LgoKc3NoOi8vZ2l0QGdpdC5saW5hcm8ub3JnL3Blb3BsZS92aXJlc2gu
a3VtYXIvbXlsaW51eC5naXQgb3BwL2dlbnBkL3Fjb20KClBsZWFzZSBoYXZlIGEgdGFsayB3aXRo
IFJhamVuZHJhIHdobyBjYW4gaGVscCB5b3UgdW5kZXJzdGFuZCBvbiBob3cgdGhpcyBjYW4gYmUK
dXNlZCBmb3IgR1BVcy4KCi0tIAp2aXJlc2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZnJlZWRyZW5vCg==
