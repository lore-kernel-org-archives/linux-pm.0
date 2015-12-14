From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 04/20] ARM: dts: Add DMC bus frequency for
 exynos3250-rinato/monk
Date: Mon, 14 Dec 2015 15:38:08 +0900
Message-ID: <1450075104-13705-5-git-send-email-cw00.choi@samsung.com>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the DMC (Dynamic Memory Controller) bus frequency node
which includes the devfreq-events and regulator properties. The bus
frequency support the DVFS (Dynamic Voltage Frequency Scaling) feature
with ondemand governor.

The devfreq-events (ppmu_dmc0*) can monitor the utilization of DMC bus
on runtime and the buck1_reg (VDD_MIF power line) supplies the power to
the DMC block.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts   | 6 ++++++
 arch/arm/boot/dts/exynos3250-rinato.dts | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 443a35085846..456844a81189 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -156,6 +156,12 @@
 	};
 };
 
+&bus_dmc {
+	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	vdd-supply = <&buck1_reg>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu0-supply = <&buck2_reg>;
 };
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 3e64d5dcdd60..d6bb990ce931 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -147,6 +147,12 @@
 	};
 };
 
+&bus_dmc {
+	devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+	vdd-supply = <&buck1_reg>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu0-supply = <&buck2_reg>;
 };
-- 
1.9.1
