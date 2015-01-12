From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv8 6/9] ARM: dts: Add PPMU dt node for Exynos4 SoCs
Date: Mon, 12 Jan 2015 21:34:54 +0900
Message-ID: <1421066097-26237-7-git-send-email-cw00.choi@samsung.com>
References: <1421066097-26237-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1421066097-26237-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, robh+dt@kernel.org, cw00.choi@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch add PPMU (Platform Performance Monitoring Unit) dt node for Exynos4
(Exynos4210/4212/4412) SoC. PPMU dt node is used to monitor the utilization of
each IP.

The Exynos4210/Exynos4212/Exynos4412 SoC includes following PPMUs:
- PPMU_DMC0      0x106A_0000
- PPMU_DMC1      0x106B_0000
- PPMU_CPU       0x106C_0000
- PPMU_ACP       0x10AE_0000
- PPMU_RIGHT_BUS 0x112A_0000
- PPMU_LEFT_BUS  0x116A_0000
- PPMU_FSYS      0x1263_0000
- PPMU_LCD0      0x11E4_0000
- PPMU_CAMIF     0x11AC_0000
- PPMU_IMAGE     0x12AA_0000
- PPMU_TV        0x12E4_0000
- PPMU_3D        0x1322_0000
- PPMU_MFC_LEFT  0x1366_0000
- PPMU_MFC_RIGHT 0x1367_0000

Additionally, the Exynos4210 SoC includes following PPMUs:
- PPMU_LCD1      0x1224_0000

Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi    | 108 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi |   8 +++
 2 files changed, 116 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index b8168f1..70064dc 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -645,4 +645,112 @@
 		samsung,sysreg = <&sys_reg>;
 		status = "disabled";
 	};
+
+	ppmu_dmc0: ppmu_dmc0@106a0000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x106a0000 0x2000>;
+		clocks = <&clock CLK_PPMUDMC0>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_dmc1: ppmu_dmc1@106b0000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x106b0000 0x2000>;
+		clocks = <&clock CLK_PPMUDMC1>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_cpu: ppmu_cpu@106c0000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x106c0000 0x2000>;
+		clocks = <&clock CLK_PPMUCPU>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_acp: ppmu_acp@10ae0000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x106e0000 0x2000>;
+		status = "disabled";
+	};
+
+	ppmu_rightbus: ppmu_rightbus@112a0000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x112a0000 0x2000>;
+		clocks = <&clock CLK_PPMURIGHT>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_leftbus: ppmu_leftbus0@116a0000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x116a0000 0x2000>;
+		clocks = <&clock CLK_PPMULEFT>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_camif: ppmu_camif@11ac0000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x11ac0000 0x2000>;
+		clocks = <&clock CLK_PPMUCAMIF>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_lcd0: ppmu_lcd0@11e40000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x11e40000 0x2000>;
+		clocks = <&clock CLK_PPMULCD0>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_fsys: ppmu_g3d@12630000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x12630000 0x2000>;
+		status = "disabled";
+	};
+
+	ppmu_image: ppmu_image@12aa0000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x12aa0000 0x2000>;
+		clocks = <&clock CLK_PPMUIMAGE>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_tv: ppmu_tv@12e40000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x12e40000 0x2000>;
+		clocks = <&clock CLK_PPMUTV>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_g3d: ppmu_g3d@13220000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x13220000 0x2000>;
+		clocks = <&clock CLK_PPMUG3D>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_mfc_left: ppmu_mfc_left@13660000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x13660000 0x2000>;
+		clocks = <&clock CLK_PPMUMFC_L>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
+
+	ppmu_mfc_right: ppmu_mfc_right@13670000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x13670000 0x2000>;
+		clocks = <&clock CLK_PPMUMFC_R>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index bcc9e63..b2598de 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -192,4 +192,12 @@
 			samsung,lcd-wb;
 		};
 	};
+
+	ppmu_lcd1: ppmu_lcd1@12240000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x12240000 0x2000>;
+		clocks = <&clock CLK_PPMULCD1>;
+		clock-names = "ppmu";
+		status = "disabled";
+	};
 };
-- 
1.8.5.5
