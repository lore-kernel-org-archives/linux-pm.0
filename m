From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 8/8] Documentation: dt: devfreq: Add device tree binding of
 Exynos4 busfreq
Date: Fri, 14 Mar 2014 18:30:08 +0900
Message-ID: <1394789408-14648-9-git-send-email-cw00.choi@samsung.com>
References: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch introduce device tree binding for the Exynos4's busfreq driver.
The Exynos4's busfreq driver support DVFS(Dynamic Voltage Frequency Scaling)
of Exynos4 memory bus to optimize power-consumption on runtime state.
Exynos4's busfreq driver need the utilization of memory bus. So, busfreq driver
use PPMU_DMC0/PPMU_DMC1 IP among various PPMU(Performance Profiling Monitoring
Units) which provide the data of read/write counters on memory bus. This driver
adjust the frequency/voltage of memory bus according to PPMU_DMC0/PPMU_DMC1
counters.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../devicetree/bindings/devfreq/exynos4_bus.txt    | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt

diff --git a/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
new file mode 100644
index 0000000..bd397ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
@@ -0,0 +1,50 @@
+
+Exynos4 Memory Bus frequency driver
+-----------------------------------
+
+Exynos4 SoC need Busfreq (Memory Bus frequency) driver to support DVFS (Dynamic
+Voltage Frequency Scaling) of Exynos4 SoC's memory bus. This driver controls
+dynamically the frequency/voltage of memory bus to optimize power-consumption
+of memory bus. When checking the utilization of memory bus, Exynos4's busfreq
+driver uses PPMU_DMC0/PPMU_DMC1 (Performance Profiling Monitoring Units)
+which provide the data of read/write counters on memory bus.
+
+Required properties:
+- compatible	: should contain Exynos4 SoC type as following:
+		  - "samsung,exynos4210-busfreq" for Exynos4210
+		  - "samsung,exynos4x12-busfreq" for Exynos4x12
+- reg		: physical address of PPMU_DMC0/PPMU_DMC1 register and length
+		  for memory mapping
+- clocks	: phandles to clock-controller and clock number of PPMU_DMC0
+		  /PPMU_DMC1
+- clock-names	: clock names for PPMU_DMC0/PPMU_DMC1
+		  - "ppmudmc0" for PPMU_DMC0
+		  - "ppmudmc1" for PPMU_DMC1
+- vdd_int-supply: regulator for interface block of Exynos4 SoC
+
+Optional properties:
+- vdd_mif-supply: regulator for DMC block if using Exynos4x12 SoC
+
+Example:
+For Exynos4210 busfreq,
+
+	busfreq@106A0000 {
+		compatible = "samsung,exynos4210-busfreq";
+		reg = <0x106A0000 0x2000>, <0x106B0000 0x2000>;
+		clocks = <&clock CLK_PPMUDMC0>, <&clock CLK_PPMUDMC1>;
+		clock-names = "ppmudmc0", "ppmudmc1";
+
+		vdd_int-supply = <&buck3_reg>;
+	};
+
+For Exynos4x12 busfreq,
+
+	busfreq@106A0000 {
+		compatible = "samsung,exynos4x12-busfreq";
+		reg = <0x106A0000 0x2000>, <0x106B0000 0x2000>;
+		clocks = <&clock CLK_PPMUDMC0>, <&clock CLK_PPMUDMC1>;
+		clock-names = "ppmudmc0", "ppmudmc1";
+
+		vdd_int-supply = <&buck3_reg>;
+		vdd_mif-suppy = <&buck1_reg>;
+	};
-- 
1.8.0
