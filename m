From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Wed, 10 Oct 2018 20:21:39 +0530
Message-ID: <20181010145139.nvalsr2ij2lj53dh@vireshk-i7>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-6-jcrouse@codeaurora.org>
 <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
 <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
 <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
 <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181010144856.GC9977-9PYrDHPZ2Orvke4nUoYGnHL1okKdlPRT@public.gmane.org>
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

T24gMTAtMTAtMTgsIDA4OjQ4LCBKb3JkYW4gQ3JvdXNlIHdyb3RlOgo+IHFjb20sbGV2ZWwgY29t
ZXMgc3RyYWlnaHQgZnJvbToKPiAKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTgw
NjI3MDQ1MjM0LjI3NDAzLTItcm5heWFrQGNvZGVhdXJvcmEub3JnLwo+IAo+IEJ1dCBpbiB0aGlz
IGNhc2UgaW5zdGVhZCBvZiB1c2luZyB0aGUgQ1BVIHRvIHByb2dyYW0gdGhlIFJQTWggd2UgYXJl
IHBhc3NpbmcKPiB0aGUgdmFsdWUgdG8gYSBtaWNyb3Byb2Nlc3NvciAodGhlIEdNVSkgYW5kIHRo
YXQgd2lsbCBkbyB0aGUgdm90ZSBvbiBvdXIgYmVoYWxmCj4gKFRlY2huaWNhbGx5IHdlIHVzZSB0
aGUgdmFsdWUgdG8gbG9vayB1cCB0aGUgdm90ZSBpbiB0aGUgY21kLWRiIGRhdGFiYXNlIGFuZAo+
IHBhc3MgdGhhdCB0byB0aGUgR01VKQo+IAo+IFRoaXMgaXMgd2h5IHRoZSBxY29tLGxldmVsIHdh
cyBhZGRlZCBpbiB0aGUgZmlyc3QgcGxhY2Ugc28gd2UgY291bGQgYXQgbGVhc3QKPiBzaGFyZSB0
aGUgbm9tZW5jbGF0dXJlIHdpdGggdGhlIHJwbWhkIGlmIG5vdCB0aGUgaW1wbGVtZW50YXRpb24u
CgpIb3cgeW91IGFjdHVhbGx5IHBhc3MgdGhlIHZvdGUgdG8gdGhlIHVuZGVybHlpbmcgaGFyZHdh
cmUsIFJQTWggb3IKR01VLCBpcyBpcnJlbGV2YW50IHRvIHRoZSB3aG9sZSB0aGluZy4gV2hhdCBp
cyBpbXBvcnRhbnQgaXMgaG93IHdlCmRlc2NyaWJlIHRoYXQgaW4gRFQgYW5kIGhvdyB3ZSByZXBy
ZXNlbnQgdGhlIHdob2xlIHRoaW5nLgoKV2UgaGF2ZSBjaG9zZW4gZ2VucGQgKyBPUFAgdG8gZG8g
dGhpcyBhbmQgc2FtZSBzaG91bGQgYmUgdXNlZCBieSB5b3UKYXMgd2VsbC4gQW5vdGhlciBiZW5l
Zml0IGlzIHRoYXQgdGhlIGdlbnBkIGNvcmUgd2lsbCBkbyB2b3RlCmFnZ3JlZ2F0aW9uIGZvciB5
b3UgaGVyZS4KCi0tIAp2aXJlc2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZnJlZWRyZW5vCg==
