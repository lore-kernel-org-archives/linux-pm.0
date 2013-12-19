From: Anson Huang <b20788@freescale.com>
Subject: [PATCH V4 3/3] cpufreq: imx6: Add device tree binding document
Date: Thu, 19 Dec 2013 09:16:49 -0500
Message-ID: <1387462609-13013-3-git-send-email-b20788@freescale.com>
References: <1387462609-13013-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:48243
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752187Ab3LSCTK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 21:19:10 -0500
In-Reply-To: <1387462609-13013-1-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shawn.guo@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This device tree binding document describes the imx6 cpufreq
DT bindings. This document lists all required and optional properties
for imx6 cpufreq.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 .../devicetree/bindings/cpufreq/cpufreq-imx6.txt   |   56 ++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
new file mode 100644
index 0000000..a14b895
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-imx6.txt
@@ -0,0 +1,56 @@
+i.MX6 cpufreq driver
+-------------------
+
+i.MX6 SoC cpufreq driver for CPU frequency scaling.
+
+This binding doc defines properties that must be put in the /cpus/cpu@0 node,
+please refer to Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
+for detail.
+
+Required properties:
+- operating-points: Refer to Documentation/devicetree/bindings/power/opp.txt
+  for details.
+- clocks: Specify clocks that need to be used when cpu frequency is scaled,
+  refer to Documentation/devicetree/bindings/clock/clock-bindings.txt for
+  details.
+- clock-names: List of clock input name strings sorted in the same order as the
+  clocks property, refer to Documentation/devicetree/bindings/clock/clock-bindings.txt
+  for details.
+- xxx-supply: Input voltage supply regulator, refer to
+  Documentation/devicetree/bindings/regulator/regulator.txt for details.
+  arm-supply: regulator node supplying arm.
+  pu-supply: regulator node supplying pu.
+  soc-supply: regulator node supplying soc.
+
+Optional properties:
+- fsl,soc-operating-points: Specify vddsoc/pu voltage settings that must
+  go with cpu0's operating-points.
+- clock-latency: Specify the possible maximum transition latency for clock,
+  in unit of nanoseconds.
+
+Examples:
+
+	cpu@0 {
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
-- 
1.7.9.5


