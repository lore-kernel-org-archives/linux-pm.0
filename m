From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V1 1/8] cpufreq: Reuse "compatible" binding to probe cpufreq drivers
Date: Mon,  1 Dec 2014 17:11:22 +0530
Message-ID: <3f559b4093fed13f96da928882839f6f1353d07f.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38229 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbaLALlx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 06:41:53 -0500
Received: by mail-pa0-f45.google.com with SMTP id lj1so10964453pab.32
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 03:41:52 -0800 (PST)
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, santosh shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, k.chander@samsung.com, olof@lixom.net, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>

DT based cpufreq drivers doesn't require much support from platform code now a
days as most of the stuff is moved behind generic APIs. Like clk APIs for
changing clock rates, regulator APIs for changing voltages, etc.

One of the bottleneck still left was how to select which cpufreq driver to probe
for a given platform as there might be multiple drivers available.

Traditionally, we used to create platform devices from machine specific code
which binds with a cpufreq driver. And while we moved towards DT based device
creation, these devices stayed as is.

The problem is getting worse now as we have architectures now with Zero platform
specific code. Forcefully these platforms have to create a new file in
drivers/cpufreq/ to just add these platform devices in order to use the generic
drivers like cpufreq-dt.c.

This has been discussed again and again, but with no solution yet. Last it was
discussed here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256154.html

This patch is an attempt towards getting the bindings.

We only need to have cpufreq drivers name string present in "compatible"
property for the root node.. If a cpufreq driver with DT support exists with
that name, then cpufreq core will create a platform device for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/cpufreq/drivers.txt        | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/drivers.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/drivers.txt b/Documentation/devicetree/bindings/cpufreq/drivers.txt
new file mode 100644
index 0000000..6a33150
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/drivers.txt
@@ -0,0 +1,46 @@
+Binding to select which cpufreq driver to register
+--------------------------------------------------
+
+This presents generic DT binding for selecting which cpufreq-driver to probe for
+platforms.
+
+The property listed below must be defined in root nodes compatible list. We
+don't support multiple CPUFreq driver currently for different cluster and so
+this information isn't required to be present in cpu nodes.
+
+Required properties:
+- None
+
+Optional properties:
+- compatible: CPUFreq driver to probe. For example: "arm-bL-cpufreq-dt",
+  "cpufreq-dt", etc. A platform device will be created with this name by cpufreq
+  core.
+
+Examples:
+
+/ {
+	compatible = "samsung,exynos5250", "cpufreq-dt";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			next-level-cache = <&L2>;
+			operating-points = <
+				/* kHz    uV */
+				792000  1100000
+				396000  950000
+				198000  850000
+				>;
+		};
+
+		...
+
+	};
+
+	...
+
+}
-- 
2.0.3.693.g996b0fd

