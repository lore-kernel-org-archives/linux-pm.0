From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v7 3/6] ARM: dts: qcom: Removed unused
 interrupt-names from GPU node
Date: Tue, 18 Dec 2018 11:32:38 -0700
Message-ID: <20181218183241.12830-4-jcrouse@codeaurora.org>
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
Lm9yZz4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9xY29tLWFwcTgwNjQuZHRzaSB8IDEgLQogMSBm
aWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9xY29tLWFwcTgwNjQuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3Fjb20tYXBxODA2NC5kdHNp
CmluZGV4IDQ4YzNjZjQyNzYxMC4uMGE5ODYyNzI5YzgwIDEwMDY0NAotLS0gYS9hcmNoL2FybS9i
b290L2R0cy9xY29tLWFwcTgwNjQuZHRzaQorKysgYi9hcmNoL2FybS9ib290L2R0cy9xY29tLWFw
cTgwNjQuZHRzaQpAQCAtMTE4Niw3ICsxMTg2LDYgQEAKIAkJCXJlZyA9IDwweDA0MzAwMDAwIDB4
MjAwMDA+OwogCQkJcmVnLW5hbWVzID0gImtnc2xfM2QwX3JlZ19tZW1vcnkiOwogCQkJaW50ZXJy
dXB0cyA9IDxHSUNfU1BJIDgwIElSUV9UWVBFX0xFVkVMX0hJR0g+OwotCQkJaW50ZXJydXB0LW5h
bWVzID0gImtnc2xfM2QwX2lycSI7CiAJCQljbG9jay1uYW1lcyA9CiAJCQkgICAgImNvcmVfY2xr
IiwKIAkJCSAgICAiaWZhY2VfY2xrIiwKLS0gCjIuMTguMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJl
bm9AbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZnJlZWRyZW5vCg==
