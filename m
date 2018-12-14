From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v2 2/2] arm64: dts: sdm845: Add interconnect for
 GPU
Date: Fri, 14 Dec 2018 15:16:40 -0700
Message-ID: <20181214221640.25354-3-jcrouse@codeaurora.org>
References: <20181214221640.25354-1-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181214221640.25354-1-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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

RGVmaW5lIGFuIGludGVyY29ubmVjdCBwb3J0IGZvciB0aGUgR1BVIHRvIHNldCBidXMKY2FwYWJp
bGl0aWVzLgoKU2lnbmVkLW9mZi1ieTogSm9yZGFuIENyb3VzZSA8amNyb3VzZUBjb2RlYXVyb3Jh
Lm9yZz4KLS0tCiBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2RtODQ1LmR0c2kgfCAzICsrKwog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvcWNvbS9zZG04NDUuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04
NDUuZHRzaQppbmRleCAwYTVkZGZjNGM1OWIuLjJhY2ZlYTg3NzE2YyAxMDA2NDQKLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9xY29tL3NkbTg0NS5kdHNpCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvcWNvbS9zZG04NDUuZHRzaQpAQCAtMTM3MCw2ICsxMzcwLDkgQEAKIAogCQkJb3BlcmF0aW5n
LXBvaW50cy12MiA9IDwmZ3B1X29wcF90YWJsZT47CiAKKwkJCWludGVyY29ubmVjdHMgPSA8JnJz
Y19obG9zIE1BU1RFUl9HRlgzRCAmcnNjX2hsb3MgU0xBVkVfRUJJMT47CisJCQlpbnRlcmNvbm5l
Y3QtbmFtZXMgPSAiZ2Z4LW1lbSI7CisKIAkJCXFjb20sZ211ID0gPCZnbXU+OwogCiAJCQlncHVf
b3BwX3RhYmxlOiBvcHAtdGFibGUgewotLSAKMi4xOC4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpGcmVlZHJlbm8gbWFpbGluZyBsaXN0CkZyZWVkcmVu
b0BsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9mcmVlZHJlbm8K
