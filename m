From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v7 4/6] arm64: dts: qcom: msm8916: Remove unused
 interrupt-names from GPU
Date: Tue, 18 Dec 2018 11:32:39 -0700
Message-ID: <20181218183241.12830-5-jcrouse@codeaurora.org>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181218183241.12830-1-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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

J2ludGVycnVwdC1uYW1lcycgc2hvdWxkbid0IGJlIHVzZWQgaW4gY2FzZXMgd2hlbiB0aGVyZSBp
cyBvbmx5Cm9uZSBpbnRlcnJ1cHQgYW5kIGl0IGlzIG5vdCBvdGhlcndpc2UgdXNlZCBpbiB0aGUg
ZHJpdmVyLgoKU2lnbmVkLW9mZi1ieTogSm9yZGFuIENyb3VzZSA8amNyb3VzZUBjb2RlYXVyb3Jh
Lm9yZz4KLS0tCiBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vbXNtODkxNi5kdHNpIHwgMSAtCiAx
IGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvcWNvbS9tc204OTE2LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vbXNtODkx
Ni5kdHNpCmluZGV4IGM1MzQ4YzNkYTVhMi4uODQ2ZGUxMDQzZTRkIDEwMDY0NAotLS0gYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL3Fjb20vbXNtODkxNi5kdHNpCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvcWNvbS9tc204OTE2LmR0c2kKQEAgLTg4MCw3ICs4ODAsNiBAQAogCQkJcmVnID0gPDB4MDFj
MDAwMDAgMHgyMDAwMD47CiAJCQlyZWctbmFtZXMgPSAia2dzbF8zZDBfcmVnX21lbW9yeSI7CiAJ
CQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzMgSVJRX1RZUEVfTEVWRUxfSElHSD47Ci0JCQlpbnRl
cnJ1cHQtbmFtZXMgPSAia2dzbF8zZDBfaXJxIjsKIAkJCWNsb2NrLW5hbWVzID0KIAkJCSAgICAi
Y29yZSIsCiAJCQkgICAgImlmYWNlIiwKLS0gCjIuMTguMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJl
bm9AbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZnJlZWRyZW5vCg==
