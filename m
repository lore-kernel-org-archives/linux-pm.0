From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC] cpufreq: Add bindings for CPU clock sharing topology
Date: Fri, 18 Jul 2014 11:05:55 +0530
Message-ID: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34902 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbaGRFgH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 01:36:07 -0400
Received: by mail-qc0-f175.google.com with SMTP id w7so3020695qcr.34
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2014 22:36:06 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, mike.turquette@linaro.org, rob.herring@linaro.org, grant.likely@linaro.org
Cc: linaro-kernel@lists.linaro.org, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, santosh.shilimkar@ti.com, Lorenzo.Pieralisi@arm.com, arvind.chauhan@arm.com, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Clock lines may or may not be shared among different CPUs on a platform. When
clock lines are shared between CPUs, they change DVFS state together.

Possible configurations:

1.) All CPUs share a single clock line.
2.) All CPUs have independent clock lines.
3.) CPUs within a group/cluster share clock line but each group/cluster have a
    separate line for itself.

There is no generic way available today to detect which CPUs share clock lines
and so this is an attempt towards that.

Much of the information is present in the commit and so no point duplicating it
here.

These are obviously not finalized yet and this is an attempt to initiate a
discussion around this.

Please share your valuable feedback.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
I wasn't sure about the path/name of this file, so please don't blast me on that
:)

 .../devicetree/bindings/cpufreq/cpu_clocks.txt     | 159 +++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt b/Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt
new file mode 100644
index 0000000..30ce9ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpu_clocks.txt
@@ -0,0 +1,159 @@
+* Generic CPUFreq clock bindings
+
+Clock lines may or may not be shared among different CPUs on a platform.
+
+Possible configurations:
+1.) All CPUs share a single clock line
+2.) All CPUs have independent clock lines
+3.) CPUs within a group/cluster share clock line but each group/cluster have a
+    separate line for itself
+
+Optional Properties:
+- clock-master: This declares cpu as clock master. Other CPUs can either define
+  "clock-ganged" or "clock-master" property, but shouldn't be missing both.
+
+- clock-ganged: Should have phandle of a cpu declared as "clock-master".
+
+If any cpu node, doesn't have both "clock-master" and "clock-ganged" properties
+defined, it would be assumed that all CPUs on that platform share a single clock
+line. This will help supporting already upstreamed platforms.
+
+
+Examples:
+1.) All CPUs share a single clock line
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpu0: cpu@0 {
+		compatible = "arm,cortex-a15";
+		reg = <0>;
+		next-level-cache = <&L2>;
+		clock-master;
+		operating-points = <
+			/* kHz    uV */
+			792000  1100000
+			396000  950000
+			198000  850000
+		>;
+		clock-latency = <61036>; /* two CLK32 periods */
+	};
+
+	cpu1: cpu@1 {
+		compatible = "arm,cortex-a15";
+		reg = <1>;
+		next-level-cache = <&L2>;
+		clock-ganged = <&cpu0>;
+	};
+};
+
+OR (clock-master/ganged aren't defined)
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpu0: cpu@0 {
+		compatible = "arm,cortex-a15";
+		reg = <0>;
+		next-level-cache = <&L2>;
+		operating-points = <
+			/* kHz    uV */
+			792000  1100000
+			396000  950000
+			198000  850000
+		>;
+		clock-latency = <61036>; /* two CLK32 periods */
+	};
+
+	cpu1: cpu@1 {
+		compatible = "arm,cortex-a15";
+		reg = <1>;
+		next-level-cache = <&L2>;
+	};
+};
+
+2.) All CPUs have independent clock lines
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpu0: cpu@0 {
+		compatible = "arm,cortex-a15";
+		reg = <0>;
+		next-level-cache = <&L2>;
+		clock-master;
+		operating-points = <
+			/* kHz    uV */
+			792000  1100000
+			396000  950000
+			198000  850000
+		>;
+		clock-latency = <61036>; /* two CLK32 periods */
+	};
+
+	cpu1: cpu@1 {
+		compatible = "arm,cortex-a15";
+		reg = <1>;
+		next-level-cache = <&L2>;
+		clock-master;
+		operating-points = <
+			/* kHz    uV */
+			792000  1100000
+			396000  950000
+			198000  850000
+		>;
+		clock-latency = <61036>; /* two CLK32 periods */
+	};
+};
+
+3.) CPUs within a group/cluster share single clock line but each group/cluster
+have a separate line for itself
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpu0: cpu@0 {
+		compatible = "arm,cortex-a15";
+		reg = <0>;
+		next-level-cache = <&L2>;
+		clock-master;
+		operating-points = <
+			/* kHz    uV */
+			792000  1100000
+			396000  950000
+			198000  850000
+		>;
+		clock-latency = <61036>; /* two CLK32 periods */
+	};
+
+	cpu1: cpu@1 {
+		compatible = "arm,cortex-a15";
+		reg = <1>;
+		next-level-cache = <&L2>;
+		clock-ganged = <&cpu0>;
+	};
+
+	cpu2: cpu@100 {
+		compatible = "arm,cortex-a7";
+		reg = <100>;
+		next-level-cache = <&L2>;
+		clock-master;
+		operating-points = <
+			/* kHz    uV */
+			792000  950000
+			396000  750000
+			198000  450000
+		>;
+		clock-latency = <61036>; /* two CLK32 periods */
+	};
+
+	cpu3: cpu@101 {
+		compatible = "arm,cortex-a7";
+		reg = <101>;
+		next-level-cache = <&L2>;
+		clock-ganged = <&cpu2>;
+	};
+};
-- 
2.0.0.rc2

