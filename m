From: =?utf-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH 1/2] PM: Wait for console in resume.
Date: Fri, 30 Jan 2009 19:27:38 -0800
Message-ID: <1233372459-6434-1-git-send-email-arve__8933.95445677943$1233372669$gmane$org@android.com>
References: <20090128193047.GA1222@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090128193047.GA1222@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: swetland@google.com
List-Id: linux-pm@vger.kernel.org

QXZvaWRzIGxhdGVyIHdha2luZyB1cCB0byBhIGJsaW5raW5nIGN1cnNvciBpZiB0aGUgZGV2aWNl
Cndva2UgdXAgYW5kIHJldHVybmVkIHRvIHNsZWVwIGJlZm9yZSB0aGUgY29uc29sZSBzd2l0Y2gg
aGFwcGVuZWQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBTd2V0bGFuZCA8c3dldGxhbmRAZ29vZ2xl
LmNvbT4KU2lnbmVkLW9mZi1ieTogQXJ2ZSBIasO4bm5ldsOlZyA8YXJ2ZUBhbmRyb2lkLmNvbT4K
LS0tCiBrZXJuZWwvcG93ZXIvY29uc29sZS5jIHwgICAgNiArKysrKysKIDEgZmlsZXMgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9w
b3dlci9jb25zb2xlLmMgYi9rZXJuZWwvcG93ZXIvY29uc29sZS5jCmluZGV4IGI4NjI4YmUuLmEz
OTYxYjIgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9wb3dlci9jb25zb2xlLmMKKysrIGIva2VybmVsL3Bv
d2VyL2NvbnNvbGUuYwpAQCAtNzgsNiArNzgsMTIgQEAgdm9pZCBwbV9yZXN0b3JlX2NvbnNvbGUo
dm9pZCkKIAl9CiAJc2V0X2NvbnNvbGUob3JpZ19mZ2NvbnNvbGUpOwogCXJlbGVhc2VfY29uc29s
ZV9zZW0oKTsKKworCWlmICh2dF93YWl0YWN0aXZlKG9yaWdfZmdjb25zb2xlKSkgeworCQlwcl9k
ZWJ1ZygiUmVzdW1lOiBDYW4ndCBzd2l0Y2ggVkNzLiIpOworCQlyZXR1cm47CisJfQorCiAJa21z
Z19yZWRpcmVjdCA9IG9yaWdfa21zZzsKIH0KICNlbmRpZgotLSAKMS42LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlz
dApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
