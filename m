From: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Subject: [PATCH] thermal: stm32: read factory settings inside
 stm_thermal_prepare
Date: Thu, 6 Dec 2018 13:23:32 +0000
Message-ID: <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
References: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Content-Language: en-US
Content-ID: <8A51B9C2EFA6614BAFFAA4D04E97DAB8@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
List-Id: linux-pm@vger.kernel.org

Q2FsbGluZyBzdG1fdGhlcm1hbF9yZWFkX2ZhY3Rvcnlfc2V0dGluZ3MgYmVmb3JlIGNsb2NraW5n
DQppbnRlcm5hbCBwZXJpcGhlcmFsIGNhdXNlcyBiYWQgcmVnaXN0ZXIgdmFsdWVzIGFuZCBtYWtl
cw0KdGVtcGVyYXR1cmUgY29tcHV0YXRpb24gd3JvbmcuDQoNCkNhbGxpbmcgc3RtX3RoZXJtYWxf
cmVhZF9mYWN0b3J5X3NldHRpbmdzIGluc2lkZQ0Kc3RtX3RoZXJtYWxfcHJlcGFyZSBmaXhlcyB0
aGlzIHByb2JsZW0gYXMgaW50ZXJuYWwNCnBlcmlwaGVyYWwgaXMgd2VsbCBjbG9ja2VkIGF0IHRo
aXMgc3RhZ2UuDQoNClNpZ25lZC1vZmYtYnk6IERhdmlkIEhlcm5hbmRleiBTYW5jaGV6IDxkYXZp
ZC5oZXJuYW5kZXpzYW5jaGV6QHN0LmNvbT4NCkZpeGVzOiAxZDY5MzE1NSAoInRoZXJtYWw6IGFk
ZCBzdG0zMiB0aGVybWFsIGRyaXZlciIpDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwv
c3Qvc3RtX3RoZXJtYWwuYyBiL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5jDQppbmRl
eCA0NzYyM2RhLi5kYWExMjU3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy90aGVybWFsL3N0L3N0bV90
aGVybWFsLmMNCisrKyBiL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5jDQpAQCAtNTMy
LDYgKzUzMiwxMCBAQCBzdGF0aWMgaW50IHN0bV90aGVybWFsX3ByZXBhcmUoc3RydWN0IHN0bV90
aGVybWFsX3NlbnNvciAqc2Vuc29yKQ0KIAlpZiAocmV0KQ0KIAkJcmV0dXJuIHJldDsNCiANCisJ
cmV0ID0gc3RtX3RoZXJtYWxfcmVhZF9mYWN0b3J5X3NldHRpbmdzKHNlbnNvcik7DQorCWlmIChy
ZXQpDQorCQlnb3RvIHRoZXJtYWxfdW5wcmVwYXJlOw0KKw0KIAlyZXQgPSBzdG1fdGhlcm1hbF9j
YWxpYnJhdGlvbihzZW5zb3IpOw0KIAlpZiAocmV0KQ0KIAkJZ290byB0aGVybWFsX3VucHJlcGFy
ZTsNCkBAIC02MzYsMTAgKzY0MCw2IEBAIHN0YXRpYyBpbnQgc3RtX3RoZXJtYWxfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJLyogUG9wdWxhdGUgc2Vuc29yICovDQogCXNl
bnNvci0+YmFzZSA9IGJhc2U7DQogDQotCXJldCA9IHN0bV90aGVybWFsX3JlYWRfZmFjdG9yeV9z
ZXR0aW5ncyhzZW5zb3IpOw0KLQlpZiAocmV0KQ0KLQkJcmV0dXJuIHJldDsNCi0NCiAJc2Vuc29y
LT5jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgInBjbGsiKTsNCiAJaWYgKElTX0VSUihz
ZW5zb3ItPmNsaykpIHsNCiAJCWRldl9lcnIoJnBkZXYtPmRldiwgIiVzOiBmYWlsZWQgdG8gZmV0
Y2ggUENMSyBjbG9ja1xuIiwNCi0tIA0KMi43LjQNCg==
