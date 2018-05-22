From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH v3 2/3] ARM: dts: imx6ull: add operating points
Date: Tue, 22 May 2018 08:28:52 +0200
Message-ID: <20180522062853.24799-2-sebastien.szymanski@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

aS5NWDZVTEwgaGFzIGRpZmZlcmVudCBvcGVyYXRpbmcgcmFuZ2VzIHRoYW4gaS5NWDZVTCBzbyBh
ZGQgdGhlCm9wZXJhdGluZyBwb2ludHMgZm9yIHRoZSBpLk1YNlVMTC4gQSAyNW1WIG9mZnNldCBp
cyBhZGRlZCB0byB0aGUgbWluaW11bQphbGxvd2VkIHZhbHVlcyBsaWtlIGZvciB0aGUgaS5NWDZV
TC4KClNpZ25lZC1vZmYtYnk6IFPDqWJhc3RpZW4gU3p5bWFuc2tpIDxzZWJhc3RpZW4uc3p5bWFu
c2tpQGFybWFkZXVzLmNvbT4KLS0tCgpDaGFuZ2VzIGZvciB2MzoKIC0gbm9uZQoKQ2hhbmdlcyBm
b3IgdjI6CiAtIEZpeCBzb2Mtb3BlcmF0aW5nLXBvaW50cyB2b2x0YWdlIGZvciA3OTJNSHogYW5k
IDkwME1IegoKIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwuZHRzaSB8IDE5ICsrKysrKysrKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVs
bC5kdHNpCmluZGV4IDU3MWRkZDcxY2RiYS4uNTMwZDU1MjZiODkwIDEwMDY0NAotLS0gYS9hcmNo
L2FybS9ib290L2R0cy9pbXg2dWxsLmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVs
bC5kdHNpCkBAIC00Niw2ICs0NiwyNSBAQAogLyogRGVsZXRlIFVBUlQ4IGluIEFJUFMtMSAoaS5N
WDZVTCBzcGVjaWZpYykgKi8KIC9kZWxldGUtbm9kZS8gJnVhcnQ4OwogCismY3B1MCB7CisJb3Bl
cmF0aW5nLXBvaW50cyA9IDwKKwkJLyoga0h6CXVWICovCisJCTkwMDAwMAkxMjc1MDAwCisJCTc5
MjAwMAkxMjI1MDAwCisJCTUyODAwMAkxMTc1MDAwCisJCTM5NjAwMAkxMDI1MDAwCisJCTE5ODAw
MAk5NTAwMDAKKwk+OworCWZzbCxzb2Mtb3BlcmF0aW5nLXBvaW50cyA9IDwKKwkJLyogS0h6CXVW
ICovCisJCTkwMDAwMAkxMTc1MDAwCisJCTc5MjAwMAkxMTc1MDAwCisJCTUyODAwMAkxMTc1MDAw
CisJCTM5NjAwMAkxMTc1MDAwCisJCTE5ODAwMAkxMTc1MDAwCisJPjsKK307CisKIC8gewogCXNv
YyB7CiAJCWFpcHMzOiBhaXBzLWJ1c0AyMjAwMDAwIHsKLS0gCjIuMTYuMQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
