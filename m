From: Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v7 5/9] arm64: dts: allwinner: a64: pinebook: enable power supplies
Date: Sat,  8 Dec 2018 19:36:14 +0200
Message-ID: <20181208173618.31395-6-oskari@lemmela.net>
References: <20181208173618.31395-1-oskari@lemmela.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181208173618.31395-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@bootlin.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vasily Khoruzhick <anarsoul@gmail.com>, Oskari Lemmela <oskari@lemmela.net>
List-Id: linux-pm@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Pinebook has ACIN connector and 10000 mAh battery.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 77fac84797e9..6a1402bf0362 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -148,6 +148,14 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
-- 
2.17.1
