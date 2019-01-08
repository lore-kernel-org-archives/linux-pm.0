From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 1/4] ARM: dts: s5pv210: Add dmc nodes
Date: Tue,  8 Jan 2019 21:05:06 +0100
Message-ID: <20190108200509.30494-2-pawel.mikolaj.chmiel@gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kgene@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux@armlinux.org.uk, krzk@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-pm@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyBkbWMgbm9kZXMsIHdoaWNoIGFyZSBuZWVkZWQgYnkgczVwdjIxMCBj
cHVmcmVxIGRyaXZlcgp0byB3b3JrLgoKU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3
ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYy
MTAuZHRzaSB8IDEyICsrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0c2kgYi9hcmNoL2Fy
bS9ib290L2R0cy9zNXB2MjEwLmR0c2kKaW5kZXggZTk2MTM0MTgyMjhkLi4yZDU1YTNhNmU3OWUg
MTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAuZHRzaQorKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9zNXB2MjEwLmR0c2kKQEAgLTI1LDYgKzI1LDggQEAKIAogCWFsaWFzZXMgewog
CQljc2lzMCA9ICZjc2lzMDsKKwkJZG1jMCA9ICZkbWMwOworCQlkbWMxID0gJmRtYzE7CiAJCWZp
bWMwID0gJmZpbWMwOwogCQlmaW1jMSA9ICZmaW1jMTsKIAkJZmltYzIgPSAmZmltYzI7CkBAIC01
MjEsNiArNTIzLDE2IEBACiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwogCQl9OwogCisJCWRtYzA6
IGRtY0BmMDAwMDAwMCB7CisJCQljb21wYXRpYmxlID0gInNhbXN1bmcsczVwdjIxMC1kbWMiOwor
CQkJcmVnID0gPDB4ZjAwMDAwMDAgMHgxMDAwPjsKKwkJfTsKKworCQlkbWMxOiBkbWNAZjE0MDAw
MDAgeworCQkJY29tcGF0aWJsZSA9ICJzYW1zdW5nLHM1cHYyMTAtZG1jIjsKKwkJCXJlZyA9IDww
eGYxNDAwMDAwIDB4MTAwMD47CisJCX07CisKIAkJZzJkOiBnMmRAZmEwMDAwMDAgewogCQkJY29t
cGF0aWJsZSA9ICJzYW1zdW5nLHM1cHYyMTAtZzJkIjsKIAkJCXJlZyA9IDwweGZhMDAwMDAwIDB4
MTAwMD47Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
