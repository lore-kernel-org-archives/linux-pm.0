From: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Subject: [PATCH 0/3] Introduce STM32 thermal driver
Date: Fri, 5 Oct 2018 10:08:44 +0000
Message-ID: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <2F86A427D7D4744EB8EA4FD180BDA474@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
List-Id: linux-pm@vger.kernel.org

VGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBTVE1pY3JvZWxlY3Ryb25pY3MgRGlnaXRhbCBU
ZW1wZXJhdHVyZQ0KU2Vuc29yIChEVFMpLCB1c2VkIG9uIHNvbWUgU1RNMzIgU29Dcy4NCg0KRHJp
dmVyIGlzIGJhc2VkIG9uIHRoZXJtYWwgc3lzZnMgYW5kIGl0IGhhcyBiZWVuIHRlc3RlZCBPSyBv
biBhIDQuMTktcmM1IGxpbnV4DQpyZWxlYXNlLg0KDQpQbGVhc2UgZmVlbCBmcmVlIHRvIGNvbnRh
Y3QgbWUgYmFjayBmb3IgZnVydGhlciBpbmZvcm1hdGlvbg0KYW5kIHRvIGRpc2N1c3MgYWJvdXQg
dGhpcyBpbXBsZW1lbnRhdGlvbi4NCg0KQnIsDQpEYXZpZCBIRVJOQU5ERVogU0FOQ0hFWg0KDQpE
YXZpZCBIZXJuYW5kZXogU2FuY2hleiAoMyk6DQogIGR0LWJpbmRpbmdzOiBzdG0zMi10aGVybWFs
OiBhZGQgYmluZGluZyBkb2N1bWVudGF0aW9uDQogIHRoZXJtYWw6IGFkZCBzdG0zMiB0aGVybWFs
IGRyaXZlcg0KICBBUk06IGR0czogc3RtMzI6IGFkZCB0aGVybWFsIHNlbnNvciBzdXBwb3J0IG9u
IFNUTTMyTVAxNTdjDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3N0bTMyLXRo
ZXJtYWwudHh0ICB8ICA2MSArKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kg
ICAgICAgICAgICAgICAgIHwgIDM1ICsNCiBkcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KIGRyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQogZHJpdmVycy90aGVybWFsL3N0L0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQgKw0KIGRyaXZlcnMvdGhlcm1hbC9z
dC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL3RoZXJt
YWwvc3Qvc3RtX3RoZXJtYWwuYyAgICAgICAgICAgICAgICAgICB8IDc2MCArKysrKysrKysrKysr
KysrKysrKysNCiA3IGZpbGVzIGNoYW5nZWQsIDg3MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdGhlcm1hbC9zdG0zMi10aGVybWFsLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3RoZXJtYWwvc3Qvc3RtX3RoZXJtYWwuYw0KDQotLQ0KMi43LjQNCg==
