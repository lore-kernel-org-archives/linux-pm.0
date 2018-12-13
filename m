From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 2/2] arm64: dts: sdm845: Add interconnect for GPU
Date: Thu, 13 Dec 2018 10:31:49 -0700
Message-ID: <20181213173149.6975-3-jcrouse@codeaurora.org>
References: <20181213173149.6975-1-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181213173149.6975-1-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
NDUuZHRzaQppbmRleCAwYTVkZGZjNGM1OWIuLjkzMjNmMjExY2E0MCAxMDA2NDQKLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9xY29tL3NkbTg0NS5kdHNpCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvcWNvbS9zZG04NDUuZHRzaQpAQCAtMTM3MCw2ICsxMzcwLDkgQEAKIAogCQkJb3BlcmF0aW5n
LXBvaW50cy12MiA9IDwmZ3B1X29wcF90YWJsZT47CiAKKwkJCWludGVyY29ubmVjdHMgPSA8JnFu
b2MgTUFTVEVSX0dGWDNEICZxbm9jIFNMQVZFX0VCSTE+OworCQkJaW50ZXJjb25uZWN0LW5hbWVz
ID0gImdmeC1tZW0iOworCiAJCQlxY29tLGdtdSA9IDwmZ211PjsKIAogCQkJZ3B1X29wcF90YWJs
ZTogb3BwLXRhYmxlIHsKLS0gCjIuMTguMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZnJlZWRyZW5vCg==
