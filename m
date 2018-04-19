From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH v2 2/2] ARM: dts: imx6ull: add operating points
Date: Thu, 19 Apr 2018 09:19:42 +0200
Message-ID: <20180419071942.14828-2-sebastien.szymanski@armadeus.com>
References: <20180419071942.14828-1-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180419071942.14828-1-sebastien.szymanski@armadeus.com>
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
Cc: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Stefan Agner <stefan@agner.ch>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

aS5NWDZVTEwgaGFzIGRpZmZlcmVudCBvcGVyYXRpbmcgcmFuZ2VzIHRoYW4gaS5NWDZVTCBzbyBh
ZGQgdGhlCm9wZXJhdGluZyBwb2ludHMgZm9yIHRoZSBpLk1YNlVMTC4gQSAyNW1WIG9mZnNldCBp
cyBhZGRlZCB0byB0aGUgbWluaW11bQphbGxvd2VkIHZhbHVlcyBsaWtlIGZvciB0aGUgaS5NWDZV
TC4KClNpZ25lZC1vZmYtYnk6IFPDqWJhc3RpZW4gU3p5bWFuc2tpIDxzZWJhc3RpZW4uc3p5bWFu
c2tpQGFybWFkZXVzLmNvbT4KLS0tCgpDaGFuZ2VzIGZvciB2MjoKIC0gRml4IHNvYy1vcGVyYXRp
bmctcG9pbnRzIHZvbHRhZ2UgZm9yIDc5Mk1IeiBhbmQgOTAwTUh6CgogYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnVsbC5kdHNpIHwgMTkgKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDE5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxs
LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLmR0c2kKaW5kZXggNTcxZGRkNzFjZGJh
Li41MzBkNTUyNmI4OTAgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwuZHRz
aQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLmR0c2kKQEAgLTQ2LDYgKzQ2LDI1IEBA
CiAvKiBEZWxldGUgVUFSVDggaW4gQUlQUy0xIChpLk1YNlVMIHNwZWNpZmljKSAqLwogL2RlbGV0
ZS1ub2RlLyAmdWFydDg7CiAKKyZjcHUwIHsKKwlvcGVyYXRpbmctcG9pbnRzID0gPAorCQkvKiBr
SHoJdVYgKi8KKwkJOTAwMDAwCTEyNzUwMDAKKwkJNzkyMDAwCTEyMjUwMDAKKwkJNTI4MDAwCTEx
NzUwMDAKKwkJMzk2MDAwCTEwMjUwMDAKKwkJMTk4MDAwCTk1MDAwMAorCT47CisJZnNsLHNvYy1v
cGVyYXRpbmctcG9pbnRzID0gPAorCQkvKiBLSHoJdVYgKi8KKwkJOTAwMDAwCTExNzUwMDAKKwkJ
NzkyMDAwCTExNzUwMDAKKwkJNTI4MDAwCTExNzUwMDAKKwkJMzk2MDAwCTExNzUwMDAKKwkJMTk4
MDAwCTExNzUwMDAKKwk+OworfTsKKwogLyB7CiAJc29jIHsKIAkJYWlwczM6IGFpcHMtYnVzQDIy
MDAwMDAgewotLSAKMi4xNi4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
