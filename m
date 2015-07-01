From: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v5 1/2] dt-bindings: mediatek: Add MT8173 cpufreq driver
 binding
Date: Wed,  1 Jul 2015 10:16:44 +0800
Message-ID: <1435717005-20012-2-git-send-email-pi-cheng.chen@linaro.org>
References: <1435717005-20012-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1435717005-20012-1-git-send-email-pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds device tree binding document for MT8173 cpufreq driver.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-mt8173.txt | 145 +++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
new file mode 100644
index 0000000..65701c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
@@ -0,0 +1,145 @@
+
+Mediatek MT8173 cpufreq driver
+------------------------------
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
+	Please refer to Documentation/devicetree/bindings/clk/clock-bindings.txt for
+	generic clock consumer properties.
+- operating-points: Please refer to Documentation/devicetree/bindings/power/opp.txt for
+		    details.
+- proc-supply: Regulator for Vproc of CPU cluster.
+
+Optional properties:
+- sram-supply: Regulator for Vsram of CPU cluster. When present, the cpufreq driver
+	       needs to do "voltage trace" to step by step scale up/down Vproc and
+	       Vsram to fit SoC specific needs. When absent, the voltage scaling
+	       flow is handled by hardware, hence no software "voltage trace" is
+	       needed.
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
