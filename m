From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [v2 PATCH 0/2] arm64: dts: Add sdm845 GPU/GMU and
 SMMU
Date: Tue, 20 Mar 2018 11:44:50 +0800
Message-ID: <20180320034450.tw4lcw6jv6wktmef@vireshk-mac-ubuntu>
References: <20180316185152.32020-1-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180316185152.32020-1-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gMTYtMDMtMTgsIDEyOjUxLCBKb3JkYW4gQ3JvdXNlIHdyb3RlOgo+IChyZXNlbmQgYmVjYXVz
ZSBJIGZvcmdvdCB0byBDQyBldmVyeWJvZHkgb24gdGhlIHBhdGNoZXMpCj4gCj4gQWRkIERUIG5v
ZGVzIGZvciB0aGUgc2RtODQ1IEdQVS9HTVUgKGdyYXBoaWNzIG1hbmFnZW1lbnQgdW5pdCkgYW5k
IHRoZSBjb21wYW5pb24KPiBhcm0tc21tdS12MiBjb21wYXRpYmxlIFNNTVUuCj4gCj4gVGhpcyBi
dWlsZHMgb24gdGhlIGZvbGxvd2luZyBkZXBlbmRlbmNpZXMgLQo+IGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcGF0Y2gvMTAyODYzNjkvIC0gYmluZGluZ3MgZm9yIHFjb20sbGV2ZWwKPiBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwMjgxNTk5LyAtIHFjb20sc21tdS12
MiBiaW5kaW5ncwo+IAo+IFBsZWFzZSByZWZlciB0byBodHRwczovL3BhdGNod29yay5mcmVlZGVz
a3RvcC5vcmcvc2VyaWVzLzM3NDI4LyBmb3IgdGhlIGRyaXZlcgo+IGNvZGUuCj4gCj4gW3YyIC0g
Y2hhbmdlZCBxY29tLGFyYy1sZXZlbCB0byBxY29tLGxldmVsIGZvbGxvd2luZyBkaXNjdXNzaW9u
IHdpdGggVmlyZXNoOwo+IGNoYW5nZSBnbXUgcGhhbmRsZSB0byBxY29tLGdtdSBwZXIgUm9iXQo+
IAo+IEpvcmRhbiBDcm91c2UgKDIpOgo+ICAgZHQtYmluZGluZ3M6IERvY3VtZW50IHFjb20sYWRy
ZW5vLWdtdQo+ICAgYXJtNjQ6IGR0czogc2RtODQ1OiBBZGQgZ3B1IGFuZCBnbXUgZGV2aWNlIG5v
ZGVzCgpBY2tlZC1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4KCi0t
IAp2aXJlc2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
RnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZnJlZWRyZW5vCg==
