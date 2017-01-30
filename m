From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/4] ARM: gemini: select gemini poweroff
Date: Mon, 30 Jan 2017 20:36:34 +0100
Message-ID: <20170130193635.18644-3-linus.walleij@linaro.org>
References: <20170130193635.18644-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <openwrt-devel-bounces@lists.openwrt.org>
In-Reply-To: <20170130193635.18644-1-linus.walleij@linaro.org>
List-Unsubscribe: <https://lists.openwrt.org/cgi-bin/mailman/options/openwrt-devel>,
 <mailto:openwrt-devel-request@lists.openwrt.org?subject=unsubscribe>
List-Archive: <http://lists.openwrt.org/pipermail/openwrt-devel/>
List-Post: <mailto:openwrt-devel@lists.openwrt.org>
List-Help: <mailto:openwrt-devel-request@lists.openwrt.org?subject=help>
List-Subscribe: <https://lists.openwrt.org/cgi-bin/mailman/listinfo/openwrt-devel>,
 <mailto:openwrt-devel-request@lists.openwrt.org?subject=subscribe>
Errors-To: openwrt-devel-bounces@lists.openwrt.org
Sender: "openwrt-devel" <openwrt-devel-bounces@lists.openwrt.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>
Cc: openwrt-devel@openwrt.org, Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

SXQncyBlc3BlY2lhbGx5IGFubm95aW5nIGlmIHRoZSBzeXN0ZW0gY2Fubm90IGJlIHByb3Blcmx5
CnBvd2VyZWQgZG93biBzbyBzZWxlY3QgdGhlIHBvd2Vyb2ZmIGRyaXZlciBmcm9tIHRoZSBLY29u
ZmlnLgoKQ2M6IEphbm9zIExhdWJlIDxqYW5vcy5kZXZAZ21haWwuY29tPgpDYzogUGF1bGl1cyBa
YWxlY2thcyA8cGF1bGl1cy56YWxlY2thc0BnbWFpbC5jb20+CkNjOiBIYW5zIFVsbGkgS3JvbGwg
PHVsbGkua3JvbGxAZ29vZ2xlbWFpbC5jb20+CkNjOiBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5l
bGxpQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVp
akBsaW5hcm8ub3JnPgotLS0KU2ViYXN0aWFuOiB0aGlzIHBhdGNoIGlzIGp1c3QgZm9yIGNvbnRl
eHQuCkkgd2lsbCBmdW5uZWwgdGhlIEFSTSBwYXJ0cyB0aHJvdWdoIHRoZSBBUk0gU29DIHRyZWUu
Ci0tLQogYXJjaC9hcm0vbWFjaC1nZW1pbmkvS2NvbmZpZyB8IDEgKwogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1nZW1pbmkvS2NvbmZp
ZyBiL2FyY2gvYXJtL21hY2gtZ2VtaW5pL0tjb25maWcKaW5kZXggOTFlYTUyY2NmMTNjLi40YjVj
MDU5ZDYwMmIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtZ2VtaW5pL0tjb25maWcKKysrIGIv
YXJjaC9hcm0vbWFjaC1nZW1pbmkvS2NvbmZpZwpAQCAtNyw2ICs3LDcgQEAgbWVudWNvbmZpZyBB
UkNIX0dFTUlOSQogCXNlbGVjdCBHUElPTElCCiAJc2VsZWN0IE1JR0hUX0hBVkVfUENJCiAJc2Vs
ZWN0IFBPV0VSX1JFU0VUCisJc2VsZWN0IFBPV0VSX1JFU0VUX0dFTUlOSV9QT1dFUk9GRgogCXNl
bGVjdCBQT1dFUl9SRVNFVF9TWVNDT04KIAlzZWxlY3QgU0VSSUFMX09GX1BMQVRGT1JNCiAJaGVs
cAotLSAKMi45LjMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Kb3BlbndydC1kZXZlbCBtYWlsaW5nIGxpc3QKb3BlbndydC1kZXZlbEBsaXN0cy5vcGVud3J0
Lm9yZwpodHRwczovL2xpc3RzLm9wZW53cnQub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9v
cGVud3J0LWRldmVsCg==
