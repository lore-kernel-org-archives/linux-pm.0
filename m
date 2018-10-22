From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Mon, 22 Oct 2018 16:08:11 +0530
Message-ID: <20181022103811.ywvyasnshjtdzjki@vireshk-i7>
References: <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
 <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
 <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
 <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
 <20181010145139.nvalsr2ij2lj53dh@vireshk-i7>
 <20181010151006.GD9977@jcrouse-lnx.qualcomm.com>
 <20181011050216.4ba5i3ghh5rbvjbl@vireshk-i7>
 <20181011145456.GG9977@jcrouse-lnx.qualcomm.com>
 <20181015100327.qoojonf46lh6g3sh@vireshk-i7>
 <20181015143444.GA4751@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181015143444.GA4751-9PYrDHPZ2Orvke4nUoYGnHL1okKdlPRT@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, niklas.cassel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gMTUtMTAtMTgsIDA4OjM0LCBKb3JkYW4gQ3JvdXNlIHdyb3RlOgo+IEkgYWdyZWUgdGhhdCBj
b25zaXN0ZW5jeSBpcyBnb29kLiBCdXQgdGhlIEdQVSBpcyBieSBkZXNpZ24gb3V0c2lkZSBvZiB0
aGUKPiBjb250cm9sIG9mIHRoZSBnZW5wZCB1bml2ZXJzZSBzbyBpdCBpcyBieSBkZXNpZ24gbm90
IHVzaW5nIHRoZSBzYW1lIGZlYXR1cmVzLgo+IEl0IHVuZm9ydHVuYXRlbHkgZG9lcyBoYXBwZW4g
dG8gdXNlIGEgc2ltaWxhciBudW1iZXIgaW4gYW4gT1BQIGJpbmRpbmcgdG8KPiBjb25zdHJ1Y3Qg
dGhlIGxldmVsIG1hcHBpbmcgYnV0IHNpbmNlIHdlIGNhbid0IHJlYWQgdGhlIGNtZC1kYiBmcm9t
IHRoZSBHTVUKPiBzcGFjZSB0aGlzIGlzIGEgbmVjZXNzYXJ5IGV2aWwuCgpXaGVyZSBkbyB5b3Ug
ZGVmaW5lIGhvdyB0byB1c2UgdGhpcyBiaW5kaW5nIGluIGNhc2Ugb2YgR1BVPyBJIG1lYW4Kc29t
ZSBEVCBiaW5kaW5nIGRvYyBtdXN0IGhhdmUgc29tZSBpbmZvcm1hdGlvbiB0byBhdm9pZCBjb25m
dXNpb24gYXMKYWxsIG90aGVyIHVzZXJzIHdpbGwgaGF2ZSB0aGUgcWNvbSxsZXZlbCB0aGluZyBp
biB0aGUgZ2VucGQncyBPUFAKdGFibGUgd2hpY2ggR1BVIHdpbGwgaGF2ZSBpdCBkaXJlY3RseSB3
aXRoaW4gaXRzIE9QUCB0YWJsZS4KCi0tIAp2aXJlc2gKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9A
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZnJlZWRyZW5vCg==
