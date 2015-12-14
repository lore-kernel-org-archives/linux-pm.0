From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 19/20] ARM: dts: Expand the voltage range of buck1/3
 regulator for exynos4412-odroidu3
Date: Mon, 14 Dec 2015 15:38:23 +0900
Message-ID: <1450075104-13705-20-git-send-email-cw00.choi@samsung.com>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch expands the voltage range of buck1/3 regulator due to as following:
- MIF (Memory Interface) bus frequency needs the range of '900 - 1050 mV'.
- INT (Internal) bus frequency needs the range of '900 - 1000 mV'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
[linux.amoon: Tested on Odroid U3]
Tested-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index cda1ec86dfba..7bd65026761e 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -356,8 +356,8 @@
 
 			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1050000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
@@ -372,7 +372,7 @@
 
 			buck3_reg: BUCK3 {
 				regulator-name = "vdd_int";
-				regulator-min-microvolt = <1000000>;
+				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 				regulator-boot-on;
-- 
1.9.1
