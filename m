From: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Subject: [PATCH] thermal: stm32: Fix stm_thermal_read_factory_settings
Date: Thu, 6 Dec 2018 13:23:32 +0000
Message-ID: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <902B145001845D4A86B32CFF0A0C3EEE@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
List-Id: linux-pm@vger.kernel.org

QWRkaW5nIGJyYWNrZXRzIGFsbG93cyB0byBtdWx0aXBseSB0aGUgcmVnaXN0ZXIgdmFsdWUsDQpt
YXNrZWQgYnkgVFMxX1JBTVBfQ09FRkZfTUFTSywgYnkgYW4gQURKVVNUIHZhbHVlDQpwcm9wZXJs
eSBhbmQgbm90IHRvIG11bHRpcGx5IEFESlVTVCBieSByZWdpc3RlciB2YWx1ZSBhbmQNCnRoZW4g
bWFzayB0aGUgd2hvbGUuDQoNClNpZ25lZC1vZmYtYnk6IERhdmlkIEhlcm5hbmRleiBTYW5jaGV6
IDxkYXZpZC5oZXJuYW5kZXpzYW5jaGV6QHN0LmNvbT4NCkZpeGVzOiAxZDY5MzE1NSAoInRoZXJt
YWw6IGFkZCBzdG0zMiB0aGVybWFsIGRyaXZlciIpDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Ro
ZXJtYWwvc3Qvc3RtX3RoZXJtYWwuYyBiL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5j
DQppbmRleCBkYWExMjU3Li5iYmQ3M2M1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy90aGVybWFsL3N0
L3N0bV90aGVybWFsLmMNCisrKyBiL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5jDQpA
QCAtMjQxLDggKzI0MSw4IEBAIHN0YXRpYyBpbnQgc3RtX3RoZXJtYWxfcmVhZF9mYWN0b3J5X3Nl
dHRpbmdzKHN0cnVjdCBzdG1fdGhlcm1hbF9zZW5zb3IgKnNlbnNvcikNCiAJCXNlbnNvci0+dDAg
PSBUUzFfVDBfVkFMMTsNCiANCiAJLyogUmV0cmlldmUgZm10MCBhbmQgcHV0IGl0IG9uIEh6ICov
DQotCXNlbnNvci0+Zm10MCA9IEFESlVTVCAqIHJlYWRsX3JlbGF4ZWQoc2Vuc29yLT5iYXNlICsg
RFRTX1QwVkFMUjFfT0ZGU0VUKQ0KLQkJCQkJICAgICAgJiBUUzFfRk1UMF9NQVNLOw0KKwlzZW5z
b3ItPmZtdDAgPSBBREpVU1QgKiAocmVhZGxfcmVsYXhlZChzZW5zb3ItPmJhc2UgKw0KKwkJCQkg
RFRTX1QwVkFMUjFfT0ZGU0VUKSAmIFRTMV9GTVQwX01BU0spOw0KIA0KIAkvKiBSZXRyaWV2ZSBy
YW1wIGNvZWZmaWNpZW50ICovDQogCXNlbnNvci0+cmFtcF9jb2VmZiA9IHJlYWRsX3JlbGF4ZWQo
c2Vuc29yLT5iYXNlICsgRFRTX1JBTVBWQUxSX09GRlNFVCkgJg0KLS0gDQoyLjcuNA0K
