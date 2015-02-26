From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] dt-bindings: cpufreq: document for hisilicon acpu driver
Date: Thu, 26 Feb 2015 21:21:39 +0800
Message-ID: <1424956899-8891-3-git-send-email-leo.yan@linaro.org>
References: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dan Zhao <dan.zhao@hisilicon.com>, zhenwei.wang@hisilicon.com, mohaoju@hisilicon.com
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

This adds documentation for hisilicon acpu's cpufreq driver.

OPP library is used for device tree parsing to get frequency list;
Furthermore, this driver can bind all CPUs to change frequency together,
or the two clusters can trigger the frequency change independently. This
is controlled by the dtb flag "hisilicon,coupled-clusters".

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../bindings/cpufreq/cpufreq-hisi-acpu.txt         | 112 +++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-hisi-acpu.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-hisi-acpu.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-hisi-acpu.txt
new file mode 100644
index 0000000..547e7339
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-hisi-acpu.txt
@@ -0,0 +1,112 @@
+Hisilicon acpu cpufreq driver
+-----------------------------
+
+Hisilicon ACPU cpufreq driver for CPU frequency scaling.
+
+Required properties:
+- operating-points: Table of frequencies and voltage CPU could be transitioned
+	into. Frequency should be in KHz units and voltage should be in
+	microvolts; This must be defined under node /cpus/cpu@x. Where x is
+	the first cpu inside a cluster.
+
+Optional properties:
+- hisilicon,coupled-clusters: Specify whether all clusters share one clock
+	source. This must be defined under node cpufreq.
+
+Example 1: all clusters share one clock source
+----------------------------------------------
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpu@0 {
+		compatible = "arm,cortex-a53", "arm,armv8";
+		device_type = "cpu";
+		reg = <0x0 0x0>;
+		operating-points = <
+			/* kHz  uV */
+			1200000  0
+			960000   0
+			729000   0
+			432000   0
+			208000   0
+		>;
+	};
+
+	cpu@1 {
+		compatible = "arm,cortex-a53", "arm,armv8";
+		device_type = "cpu";
+		reg = <0x0 0x1>;
+	};
+
+	cpu@100 {
+		compatible = "arm,cortex-a53", "arm,armv8";
+		device_type = "cpu";
+		reg = <0x0 0x100>;
+	};
+
+	cpu@101 {
+		compatible = "arm,cortex-a53", "arm,armv8";
+		device_type = "cpu";
+		reg = <0x0 0x101>;
+	};
+};
+
+cpufreq {
+	compatible = "hisilicon,hisi-acpu-cpufreq";
+	hisilicon,coupled-clusters = <1>;
+};
+
+
+Example 2: every cluster has dedicated clock source
+---------------------------------------------------
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpu@0 {
+		compatible = "arm,cortex-a53", "arm,armv8";
+		device_type = "cpu";
+		reg = <0x0 0x0>;
+		operating-points = <
+			/* kHz  uV */
+			1200000  0
+			960000   0
+			729000   0
+			432000   0
+			208000   0
+		>;
+	};
+
+	cpu@1 {
+		compatible = "arm,cortex-a53", "arm,armv8";
+		device_type = "cpu";
+		reg = <0x0 0x1>;
+	};
+
+	cpu@100 {
+		compatible = "arm,cortex-a53", "arm,armv8";
+		device_type = "cpu";
+		reg = <0x0 0x100>;
+		operating-points = <
+			/* kHz  uV */
+			1200000  0
+			960000   0
+			729000   0
+			432000   0
+			208000   0
+		>;
+	};
+
+	cpu@101 {
+		compatible = "arm,cortex-a53", "arm,armv8";
+		device_type = "cpu";
+		reg = <0x0 0x101>;
+	};
+};
+
+cpufreq {
+	compatible = "hisilicon,hisi-acpu-cpufreq";
+};
-- 
1.9.1
