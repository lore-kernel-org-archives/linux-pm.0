From: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v6 2/4] dt-bindings: mediatek: Add MT8173 cpufreq driver bindings
Date: Thu,  9 Jul 2015 18:27:39 +0800
Message-ID: <1436437661-17606-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436437661-17606-1-git-send-email-pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds device tree binding document for MT8173 cpufreq driver.
The clock and regulator consumer properties are documented in
Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt and
referenced by this document.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-mt8173.txt | 134 +++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
new file mode 100644
index 0000000..f23873f
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
@@ -0,0 +1,134 @@
+
+Mediatek MT8173 cpufreq driver
+------------------------------
+
+Mediatek MT8173 cpufreq driver for CPU frequency scaling.
+
+Please refer to Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt for details
+about the regulator and clock consumer properties.
+
+Required properties:
+- operating-points: Please refer to Documentation/devicetree/bindings/power/opp.txt for
+		    details.
+
+Optional properties:
+- #cooling-cells:
+- cooling-min-level:
+- cooling-max-level:
+	Please refer to Documentation/devicetree/bindings/thermal/thermal.txt.
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
+		operating-points = <
+			507000	859000
+			702000	908000
+			1001000	983000
+			1105000	1009000
+			1183000	1028000
+			1404000	1083000
+			1508000	1109000
+			1573000	1125000
+		>;
+		#cooling-cells = <2>;
+		cooling-min-level = <0>;
+		cooling-max-level = <7>;
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
+		operating-points = <
+			507000	859000
+			702000	908000
+			1001000	983000
+			1105000	1009000
+			1183000	1028000
+			1404000	1083000
+			1508000	1109000
+			1573000	1125000
+		>;
+		#cooling-cells = <2>;
+		cooling-min-level = <0>;
+		cooling-max-level = <7>;
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
+		operating-points = <
+			507000	828000
+			702000	867000
+			1001000	927000
+			1209000	968000
+			1404000	1007000
+			1612000	1049000
+			1807000	1089000
+			1989000	1125000
+		>;
+		#cooling-cells = <2>;
+		cooling-min-level = <0>;
+		cooling-max-level = <7>;
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
+		operating-points = <
+			507000	828000
+			702000	867000
+			1001000	927000
+			1209000	968000
+			1404000	1007000
+			1612000	1049000
+			1807000	1089000
+			1989000	1125000
+		>;
+		#cooling-cells = <2>;
+		cooling-min-level = <0>;
+		cooling-max-level = <7>;
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
