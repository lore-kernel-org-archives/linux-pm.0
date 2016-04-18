From: Jia Hongtao <hongtao.jia@nxp.com>
Subject: [PATCH 2/2] cpufreq: qoriq: Don't show cooling device messages if
 THERMAL_OF undefined
Date: Mon, 18 Apr 2016 15:59:32 +0800
Message-ID: <1460966372-4877-2-git-send-email-hongtao.jia@nxp.com>
References: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Cc: hongtao.jia@nxp.com, yuantian.tang@nxp.com, linuxppc-dev@lists.ozlabs.org, scott.wood@nxp.com
List-Id: linux-pm@vger.kernel.org

V2hlbiBUSEVSTUFMX09GIGlzIHVuZGVmaW5lZCB0aGUgY29vbGluZyBkZXZpY2UgbWVzc2FnZXMg
c2hvdWxkIG5vdCBiZQpzaG93bi4gLUVOT1NZUyBpcyByZXR1cm5lZCBmcm9tIG9mX2NwdWZyZXFf
Y29vbGluZ19yZWdpc3RlcigpIHdoZW4KVEhFUk1BTF9PRiBpcyB1bmRlZmluZWQuCgpTaWduZWQt
b2ZmLWJ5OiBKaWEgSG9uZ3RhbyA8aG9uZ3Rhby5qaWFAbnhwLmNvbT4KLS0tCiBkcml2ZXJzL2Nw
dWZyZXEvcW9yaXEtY3B1ZnJlcS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9xb3Jp
cS1jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEvcW9yaXEtY3B1ZnJlcS5jCmluZGV4IDFjMmZk
YzEuLmZmOGRhODMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9xb3JpcS1jcHVmcmVxLmMK
KysrIGIvZHJpdmVycy9jcHVmcmVxL3FvcmlxLWNwdWZyZXEuYwpAQCAtMzQwLDggKzM0MCw4IEBA
IHN0YXRpYyB2b2lkIHFvcmlxX2NwdWZyZXFfcmVhZHkoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpw
b2xpY3kpCiAJCWNwdWQtPmNkZXYgPSBvZl9jcHVmcmVxX2Nvb2xpbmdfcmVnaXN0ZXIobnAsCiAJ
CQkJCQkJIHBvbGljeS0+cmVsYXRlZF9jcHVzKTsKIAotCQlpZiAoSVNfRVJSKGNwdWQtPmNkZXYp
KSB7Ci0JCQlwcl9lcnIoIkZhaWxlZCB0byByZWdpc3RlciBjb29saW5nIGRldmljZSBjcHUlZDog
JWxkXG4iLAorCQlpZiAoSVNfRVJSKGNwdWQtPmNkZXYpICYmIFBUUl9FUlIoY3B1ZC0+Y2Rldikg
IT0gLUVOT1NZUykgeworCQkJcHJfZXJyKCJjcHUlZCBpcyBub3QgcnVubmluZyBhcyBjb29saW5n
IGRldmljZTogJWxkXG4iLAogCQkJCQlwb2xpY3ktPmNwdSwgUFRSX0VSUihjcHVkLT5jZGV2KSk7
CiAKIAkJCWNwdWQtPmNkZXYgPSBOVUxMOwotLSAKMi4xLjAuMjcuZzk2ZGIzMjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWls
aW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxh
YnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
