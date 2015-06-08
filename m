From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH 1/2] dt-bindings: mediatek: Add MT8173 cpufreq driver binding
Date: Mon,  8 Jun 2015 20:29:20 +0800
Message-ID: <1433766561-1330-2-git-send-email-pi-cheng.chen@linaro.org>
References: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35648 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbbFHM3l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 08:29:41 -0400
Received: by pdbnf5 with SMTP id nf5so103962665pdb.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2015 05:29:40 -0700 (PDT)
In-Reply-To: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: "pi-cheng.chen" <pi-cheng.chen@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org

This patch adds device tree binding document for MT8173 cpufreq driver.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-mt8173.txt | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
new file mode 100644
index 0000000..7708a65
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
@@ -0,0 +1,127 @@
+
+Mediatek MT8173 cpufreq driver
+-------------------
+
+Mediatek MT8173 cpufreq driver for CPU frequency scaling.
+
+Required properties:
+- clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock names.
+- clock-names: Should contain the following:
+	"cpu"		- The multiplexer for clock input of CPU cluster.
+	"intermediate"	- A parent of "cpu" clock which is used as "intermediate" clock
+			  source (usually MAINPLL) when the original CPU PLL is under
+			  transition and not stable yet.
+- operating-points: Table of frequencies and voltage CPU could be transitioned into,
+		    Frequency should be in KHz units and voltage should be in microvolts.
+- proc-supply: Regulator for Vproc of CPU cluster.
+
+Optional properties:
+- sram-supply: Regulator for Vsram of CPU cluster. When present, the cpufreq driver
+	       needs to do "voltage trace" to step by step scale up/down Vproc and
+	       Vsram to fit SoC specific needs. When absent, the voltage scaling
+	       flow is handled by hardware, hence no software "voltage trace" is
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

