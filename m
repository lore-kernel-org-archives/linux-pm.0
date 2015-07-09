From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH v6 1/4] dt-bindings: mediatek: Add MT8173 CPU DVFS clock bindings
Date: Thu,  9 Jul 2015 18:27:38 +0800
Message-ID: <1436437661-17606-2-git-send-email-pi-cheng.chen@linaro.org>
References: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds the clock and regulator consumer properties part of
document for CPU DVFS clocks on Mediatek MT8173 SoC.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
 .../devicetree/bindings/clock/mt8173-cpu-dvfs.txt  | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt

diff --git a/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt b/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
new file mode 100644
index 0000000..27b3521
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
@@ -0,0 +1,83 @@
+Device Tree Clock bindings for CPU DVFS clock of Mediatek MT8173 SoC
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
1.9.1
