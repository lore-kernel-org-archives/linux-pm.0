From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 18/20] ARM: dts: Add support of bus frequency using VDD_INT
 for exynos3250-rinato
Date: Mon, 14 Dec 2015 15:38:22 +0900
Message-ID: <1450075104-13705-19-git-send-email-cw00.choi@samsung.com>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the bus device-tree nodes of INT (internal) block
to enable the bus frequency scaling. The following sub-blocks share
the VDD_INT power source:
- LEFTBUS (parent device)
- RIGHTBUS
- PERIL
- LCD0
- FSYS
- MCUISP / ISP
- MFC

The LEFTBUS is parent device with devfreq ondemand governor
and the rest of devices depend on the LEFTBUS device.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 2a1c22598fdc..c29d5533ec1f 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -154,6 +154,47 @@
 	status = "okay";
 };
 
+&bus_leftbus {
+	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+	vdd-supply = <&buck3_reg>;
+	status = "okay";
+};
+
+&bus_rightbus {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_lcd0 {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_fsys {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_mcuisp {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_isp {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_peril {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
+&bus_mfc {
+	devfreq = <&bus_leftbus>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu0-supply = <&buck2_reg>;
 };
-- 
1.9.1
