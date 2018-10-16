From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: stm32: add thermal sensor support on
  STM32MP157c
Date: Tue, 16 Oct 2018 17:40:09 -0500
Message-ID: <20181016224009.GA24851@bogus>
References: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
 <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 5 Oct 2018 10:08:46 +0000, David HERNANDEZ SANCHEZ wrote:
> QWRkIGNvbmZpZ3VyYXRpb24gb24gRFQgZm9yIHRoZXJtYWwgc2Vuc29yIGRyaXZlcg0KDQpTaWdu
> ZWQtb2ZmLWJ5OiBEYXZpZCBIZXJuYW5kZXogU2FuY2hleiA8ZGF2aWQuaGVybmFuZGV6c2FuY2hl
> ekBzdC5jb20+DQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy5k
> dHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MuZHRzaQ0KaW5kZXggNjYxYmU5NC4u
> ZTkwYjlmNiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kN
> CisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kNCkBAIC04NCw2ICs4NCwz
> MSBAQA0KIAkJfTsNCiAJfTsNCg0KKwl0aGVybWFsLXpvbmVzIHsNCisJCWNwdV90aGVybWFsOiBj
> cHUtdGhlcm1hbCB7DQorCQkJcG9sbGluZy1kZWxheS1wYXNzaXZlID0gPDA+Ow0KKwkJCXBvbGxp
> bmctZGVsYXkgPSA8MD47DQorCQkJdGhlcm1hbC1zZW5zb3JzID0gPCZkdHM+Ow0KKw0KKwkJCXRy
> aXBzIHsNCisJCQkJY3B1X2FsZXJ0MTogY3B1LWFsZXJ0MSB7DQorCQkJCQl0ZW1wZXJhdHVyZSA9
> IDw4NTAwMD47DQorCQkJCQloeXN0ZXJlc2lzID0gPDA+Ow0KKwkJCQkJdHlwZSA9ICJwYXNzaXZl
> IjsNCisJCQkJfTsNCisNCisJCQkJY3B1LWNyaXQgew0KKwkJCQkJdGVtcGVyYXR1cmUgPSA8MTIw
> MDAwPjsNCisJCQkJCWh5c3RlcmVzaXMgPSA8MD47DQorCQkJCQl0eXBlID0gImNyaXRpY2FsIjsN
> CisJCQkJfTsNCisJCQl9Ow0KKw0KKwkJCWNvb2xpbmctbWFwcyB7DQorCQkJfTsNCisJCX07DQor
> CX07DQorDQogCXNvYyB7DQogCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KIAkJI2FkZHJl
> c3MtY2VsbHMgPSA8MT47DQpAQCAtOTA4LDYgKzkzMywxNiBAQA0KIAkJCXN0YXR1cyA9ICJkaXNh
> YmxlZCI7DQogCQl9Ow0KDQorCQlkdHM6IHRoZXJtYWxANTAwMjgwMDAgew0KKwkJCWNvbXBhdGli
> bGUgPSAic3Qsc3RtMzItdGhlcm1hbCI7DQorCQkJcmVnID0gPDB4NTAwMjgwMDAgMHgxMDA+Ow0K
> KwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxNDcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkJ
> Y2xvY2tzID0gPCZyY2MgVE1QU0VOUz47DQorCQkJY2xvY2stbmFtZXMgPSAicGNsayI7DQorCQkJ
> I3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDA+Ow0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQor
> CQl9Ow0KKw0KIAkJY3J5cDE6IGNyeXBANTQwMDEwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAic3Qs
> c3RtMzJtcDEtY3J5cCI7DQogCQkJcmVnID0gPDB4NTQwMDEwMDAgMHg0MDA+Ow0KLS0NCjIuNy40
> DQo=
> 

Reviewed-by: Rob Herring <robh@kernel.org>
