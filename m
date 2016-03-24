From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 20/21] ARM: dts: Expand the voltage range of buck1/3
 regulator for exynos4412-odroidu3
Date: Thu, 24 Mar 2016 13:25:29 +0900
Message-ID: <1458793530-31897-21-git-send-email-cw00.choi@samsung.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, tjakobi@math.uni-bielefeld.de, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch expands the voltage range of buck1/3 regulator due to as following:
- MIF (Memory Interface) bus frequency needs the range of '900 - 1100 mV'.
- INT (Internal) bus frequency needs the range of '900 - 1050 mV'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index cba37c974703..b4983cbc4f8c 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -356,8 +356,8 @@
 
 			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
@@ -372,8 +372,8 @@
 
 			buck3_reg: BUCK3 {
 				regulator-name = "vdd_int";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1050000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
-- 
1.9.1
