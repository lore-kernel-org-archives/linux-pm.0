From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 18/19] ARM: dts: Expand the voltage range of buck1/3
 regulator for exynos4412-odroidu3
Date: Wed, 09 Dec 2015 13:08:10 +0900
Message-ID: <1449634091-1842-19-git-send-email-cw00.choi@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch expands the voltage range of buck1/3 regulator due to as following:
- MIF (Memory Interface) bus frequency needs the 90000uV ~ 1050000uV V.
- INT (Internal) bus frequency needs 90000uV ~ 1000000uV.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 90800a6da14b..171dea1e3e4a 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -359,8 +359,8 @@
 
 			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1050000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
@@ -375,7 +375,7 @@
 
 			buck3_reg: BUCK3 {
 				regulator-name = "vdd_int";
-				regulator-min-microvolt = <1000000>;
+				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 				regulator-boot-on;
-- 
1.9.1
