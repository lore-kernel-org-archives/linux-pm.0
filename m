From: Anson Huang <b20788@freescale.com>
Subject: [PATCH V2 1/2] ARM: imx: add vddsoc/pu setpoint info into dts
Date: Tue, 17 Dec 2013 17:08:21 -0500
Message-ID: <1387318102-11070-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: shawn.guo@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

i.MX6Q needs to update vddarm, vddsoc/pu regulators when cpu freq
is changed, each setpoint has different voltage, so we need to
pass vddarm, vddsoc/pu's freq-voltage info from dts together.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 .../devicetree/bindings/cpufreq/cpufreq-imx6.txt   |   39 ++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi                       |    7 ++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
new file mode 100644
index 0000000..0c71dbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
@@ -0,0 +1,39 @@
+i.MX6 cpufreq driver
+-------------------
+
+i.MX6 SoC cpufreq driver for CPU frequency scaling.
+
+Optional properties:
+-fsl,soc-operating-points: Specify vddsoc/pu voltage settings that must
+ go with cpu0's operating-points.
+
+Examples:
+
+	cpu@0 {
+		compatible = "arm,cortex-a9";
+		device_type = "cpu";
+		reg = <0>;
+		next-level-cache = <&L2>;
+		operating-points = <
+			/* kHz    uV */
+			1200000 1275000
+			996000  1250000
+			792000  1150000
+			396000  975000
+		>;
+		fsl,soc-operating-points = <
+			/* ARM kHz  SOC-PU uV */
+			1200000 1275000
+			996000	1250000
+			792000	1175000
+			396000	1175000
+		>;
+		clock-latency = <61036>; /* two CLK32 periods */
+		clocks = <&clks 104>, <&clks 6>, <&clks 16>,
+			 <&clks 17>, <&clks 170>;
+		clock-names = "arm", "pll2_pfd2_396m", "step",
+			      "pll1_sw", "pll1_sys";
+		arm-supply = <&reg_arm>;
+		pu-supply = <&reg_pu>;
+		soc-supply = <&reg_soc>;
+	};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e7e8332..021e0cb 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -30,6 +30,13 @@
 				792000  1150000
 				396000  975000
 			>;
+			fsl,soc-operating-points = <
+				/* ARM kHz  SOC-PU uV */
+				1200000 1275000
+				996000	1250000
+				792000	1175000
+				396000	1175000
+			>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
 				 <&clks 17>, <&clks 170>;
-- 
1.7.9.5


