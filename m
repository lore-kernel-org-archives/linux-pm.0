From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 8/8] devfreq: exynos4: Add busfreq driver for
 exynos4210/exynos4x12
Date: Thu, 13 Mar 2014 17:17:29 +0900
Message-ID: <1394698649-20996-9-git-send-email-cw00.choi@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch add busfreq driver for Exynos4210/Exynos4x12 memory interface
and bus to support DVFS(Dynamic Voltage Frequency Scaling) according to PPMU
counters. PPMU (Performance Profiling Monitorings Units) of Exynos4 SoC provides
PPMU counters for DMC(Dynamic Memory Controller) to check memory bus utilization
and then busfreq driver adjusts dynamically the operating frequency/voltage
by using DEVFREQ Subsystem.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../devicetree/bindings/devfreq/exynos4_bus.txt    | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt

diff --git a/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
new file mode 100644
index 0000000..2a83fcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
@@ -0,0 +1,49 @@
+
+Exynos4210/4x12 busfreq driver
+-----------------------------
+
+Exynos4210/4x12 Soc busfreq driver with devfreq for Memory bus frequency/voltage
+scaling according to PPMU counters of memory controllers
+
+Required properties:
+- compatible	: should contain Exynos4 SoC type as follwoing:
+		  - "samsung,exynos4x12-busfreq" for Exynos4x12
+		  - "samsung,exynos4210-busfreq" for Exynos4210
+- reg		: offset and length of the ppmudmc0/1
+		  - PPMU (Performance Profiling Monitoring Units)
+		  : It is to profile performance event of DMC(Dynamic Memory
+		  Controller) So, exynos4_bus.c can check memory bus utilization
+		  by using PPMU of Exynos4 SoC.
+- clocks	: clock number of ppmudmc0/1
+- clock-names	: clock name of ppmudmc0/1
+- vdd_int-supply: regulator for interface block of Exynos4
+
+Optional properties:
+- vdd_mif-supply: regulator for DMC block of Exynos4x12 if Exynos4x12 Soc
+- regs-name	: register name of ppmudmc0/1
+
+All the required listed above must be defined under code busfreq with devfreq
+
+Exmaple:
+For Exynos4210 busfreq,
+	busfreq@106A0000 {
+		compatible = "samsung,exynos4210-busfreq";
+		reg = <0x106A0000 0x2000>, <0x106B0000 0x2000>;
+		regs-name = "PPMU_DMC0", "PPMU_DMC1";
+		clocks = <&clock CLK_PPMUDMC0>, <&clock CLK_PPMUDMC1>;
+		clock-names = "ppmudmc0", "ppmudmc1";
+
+		vdd_int-supply = <&buck3_reg>;
+	};
+
+For Exynos4x12 busfreq,
+	busfreq@106A0000 {
+		compatible = "samsung,exynos4x12-busfreq";
+		reg = <0x106A0000 0x2000>, <0x106B0000 0x2000>;
+		regs-name = "PPMU_DMC0", "PPMU_DMC1";
+		clocks = <&clock CLK_PPMUDMC0>, <&clock CLK_PPMUDMC1>;
+		clock-names = "ppmudmc0", "ppmudmc1";
+
+		vdd_mif-suppy = <&buck1_reg>;
+		vdd_int-supply = <&buck3_reg>;
+	};
-- 
1.8.0
