From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v2 0/2] arm64: dts: sdm845: Add sdm845 GPU
 interconnect
Date: Fri, 14 Dec 2018 15:16:38 -0700
Message-ID: <20181214221640.25354-1-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

VHdvIHF1aWNrIHBhdGNoZXMgdG8gZG9jdW1lbnQgYW5kIGFkZCBhbiBpbnRlcmNvbm5lY3QgcG9y
dCBkZWZpbml0aW9uCmZvciB0aGUgc2RtODQ1IEdQVS4KClRoaXMgaXMgYmFzZWQgb24gdGhlIGJh
c2UgR1BVIERUIGNoYW5nZXM6Cmh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJp
ZXMvMzkzMDgvCgpBcyB3ZWxsIGFzIHRoZSBEVCBub2RlcyBmcm9tIEdlb3JnaToKaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDcxOTQ4My8KCnYyOiBGaXggaW50ZXJjb25uZWN0
IHN1cHBsaWVyIHRvIG1hdGNoIGxhdGVzdCBwZXIgRG91ZyBBbmRlcnNvbgoqKiogQkxVUkIgSEVS
RSAqKioKCkpvcmRhbiBDcm91c2UgKDIpOgogIGR0LWJpbmRpbmdzOiBkcm0vbXNtL2E2eHg6IERv
Y3VtZW50IGludGVyY29ubmVjdCBwcm9wZXJ0aWVzIGZvciBHUFUKICBhcm02NDogZHRzOiBzZG04
NDU6IEFkZCBpbnRlcmNvbm5lY3QgZm9yIEdQVQoKIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9kaXNwbGF5L21zbS9ncHUudHh0IHwgNiArKysrKysKIGFyY2gvYXJtNjQvYm9vdC9k
dHMvcWNvbS9zZG04NDUuZHRzaSAgICAgICAgICAgICAgICAgIHwgMyArKysKIDIgZmlsZXMgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspCgotLSAKMi4xOC4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpGcmVlZHJlbm8gbWFpbGluZyBsaXN0CkZyZWVkcmVu
b0BsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9mcmVlZHJlbm8K
