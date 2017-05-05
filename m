From: <sean.wang@mediatek.com>
Subject: [PATCH 5/6] dt-bindings: cpufreq: move Mediatek cpufreq dt-bindings document to proper place
Date: Fri, 5 May 2017 23:26:13 +0800
Message-ID: <1493997974-17699-6-git-send-email-sean.wang@mediatek.com>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The old place is Documentation/devicetree/bindings/clock/ that would
let people hard to find how to use Mediatek cpufreq driver, so moving
it to the new place as other cpufreq dirvers are done would be better.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../devicetree/bindings/clock/mt8173-cpu-dvfs.txt  | 83 ----------------------
 .../bindings/cpufreq/cpufreq-mediatek.txt          | 83 ++++++++++++++++++++++
 2 files changed, 83 insertions(+), 83 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt

diff --git a/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt b/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
deleted file mode 100644
index 52b457c..0000000
--- a/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-Device Tree Clock bindins for CPU DVFS of Mediatek MT8173 SoC
-
-Required properties:
-- clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock names.
-- clock-names: Should contain the following:
-	"cpu"		- The multiplexer for clock input of CPU cluster.
-	"intermediate"	- A parent of "cpu" clock which is used as "intermediate" clock
-			  source (usually MAINPLL) when the original CPU PLL is under
-			  transition and not stable yet.
-	Please refer to Documentation/devicetree/bindings/clk/clock-bindings.txt for
-	generic clock consumer properties.
-- proc-supply: Regulator for Vproc of CPU cluster.
-
-Optional properties:
-- sram-supply: Regulator for Vsram of CPU cluster. When present, the cpufreq driver
-	       needs to do "voltage tracking" to step by step scale up/down Vproc and
-	       Vsram to fit SoC specific needs. When absent, the voltage scaling
-	       flow is handled by hardware, hence no software "voltage tracking" is
-	       needed.
-
-Example:
---------
-	cpu0: cpu@0 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a53";
-		reg = <0x000>;
-		enable-method = "psci";
-		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA53SEL>,
-			 <&apmixedsys CLK_APMIXED_MAINPLL>;
-		clock-names = "cpu", "intermediate";
-	};
-
-	cpu1: cpu@1 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a53";
-		reg = <0x001>;
-		enable-method = "psci";
-		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA53SEL>,
-			 <&apmixedsys CLK_APMIXED_MAINPLL>;
-		clock-names = "cpu", "intermediate";
-	};
-
-	cpu2: cpu@100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x100>;
-		enable-method = "psci";
-		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA57SEL>,
-			 <&apmixedsys CLK_APMIXED_MAINPLL>;
-		clock-names = "cpu", "intermediate";
-	};
-
-	cpu3: cpu@101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x101>;
-		enable-method = "psci";
-		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA57SEL>,
-			 <&apmixedsys CLK_APMIXED_MAINPLL>;
-		clock-names = "cpu", "intermediate";
-	};
-
-	&cpu0 {
-		proc-supply = <&mt6397_vpca15_reg>;
-	};
-
-	&cpu1 {
-		proc-supply = <&mt6397_vpca15_reg>;
-	};
-
-	&cpu2 {
-		proc-supply = <&da9211_vcpu_reg>;
-		sram-supply = <&mt6397_vsramca7_reg>;
-	};
-
-	&cpu3 {
-		proc-supply = <&da9211_vcpu_reg>;
-		sram-supply = <&mt6397_vsramca7_reg>;
-	};
diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
new file mode 100644
index 0000000..52b457c
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
@@ -0,0 +1,83 @@
+Device Tree Clock bindins for CPU DVFS of Mediatek MT8173 SoC
+
+Required properties:
+- clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock names.
+- clock-names: Should contain the following:
+	"cpu"		- The multiplexer for clock input of CPU cluster.
+	"intermediate"	- A parent of "cpu" clock which is used as "intermediate" clock
+			  source (usually MAINPLL) when the original CPU PLL is under
+			  transition and not stable yet.
+	Please refer to Documentation/devicetree/bindings/clk/clock-bindings.txt for
+	generic clock consumer properties.
+- proc-supply: Regulator for Vproc of CPU cluster.
+
+Optional properties:
+- sram-supply: Regulator for Vsram of CPU cluster. When present, the cpufreq driver
+	       needs to do "voltage tracking" to step by step scale up/down Vproc and
+	       Vsram to fit SoC specific needs. When absent, the voltage scaling
+	       flow is handled by hardware, hence no software "voltage tracking" is
+	       needed.
+
+Example:
+--------
+	cpu0: cpu@0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x000>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+		clocks = <&infracfg CLK_INFRA_CA53SEL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>;
+		clock-names = "cpu", "intermediate";
+	};
+
+	cpu1: cpu@1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x001>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+		clocks = <&infracfg CLK_INFRA_CA53SEL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>;
+		clock-names = "cpu", "intermediate";
+	};
+
+	cpu2: cpu@100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+		clocks = <&infracfg CLK_INFRA_CA57SEL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>;
+		clock-names = "cpu", "intermediate";
+	};
+
+	cpu3: cpu@101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+		clocks = <&infracfg CLK_INFRA_CA57SEL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>;
+		clock-names = "cpu", "intermediate";
+	};
+
+	&cpu0 {
+		proc-supply = <&mt6397_vpca15_reg>;
+	};
+
+	&cpu1 {
+		proc-supply = <&mt6397_vpca15_reg>;
+	};
+
+	&cpu2 {
+		proc-supply = <&da9211_vcpu_reg>;
+		sram-supply = <&mt6397_vsramca7_reg>;
+	};
+
+	&cpu3 {
+		proc-supply = <&da9211_vcpu_reg>;
+		sram-supply = <&mt6397_vsramca7_reg>;
+	};
-- 
2.7.4
