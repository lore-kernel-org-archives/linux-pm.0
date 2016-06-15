From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v5 1/8] Documentation: arm: define DT cpu capacity-dmips-mhz bindings
Date: Wed, 15 Jun 2016 11:17:50 +0100
Message-ID: <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org, sgurrappadi@nvidia.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

ARM systems may be configured to have cpus with different power/performance
characteristics within the same chip. In this case, additional information
has to be made available to the kernel (the scheduler in particular) for it
to be aware of such differences and take decisions accordingly.

Therefore, this patch aims at standardizing cpu capacities device tree
bindings for ARM platforms. Bindings define cpu capacity-dmips-mhz
parameter, to allow operating systems to retrieve such information from
the device tree and initialize related kernel structures, paving the way
for common code in the kernel to deal with heterogeneity.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---

Changes from v1:
 - removed section regarding capacity-scale
 - added information regarding normalization

Changes from v4:
 - binding changed to capacity-dmips-mhz
 - sections and changelod updated accordingly
---
 .../devicetree/bindings/arm/cpu-capacity.txt       | 236 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
 2 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
new file mode 100644
index 0000000..7582a13
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -0,0 +1,236 @@
+==========================================
+ARM CPUs capacity bindings
+==========================================
+
+==========================================
+1 - Introduction
+==========================================
+
+ARM systems may be configured to have cpus with different power/performance
+characteristics within the same chip. In this case, additional information
+has to be made available to the kernel (the scheduler in particular) for
+it to be aware of such differences and take decisions accordingly.
+
+==========================================
+2 - CPU capacity definition
+==========================================
+
+CPU capacity is a number that provides the scheduler information about CPUs
+heterogeneity. Such heterogeneity can come from micro-architectural differences
+(e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
+(e.g., SMP systems with multiple frequency domains). Heterogeneity in this
+context is about differing performance characteristics; this binding tries to
+capture a first-order approximation of the relative performance of CPUs.
+
+CPU capacities are obtained by running a suitable benchmark. This binding makes
+no aspersions on the validity or suitability of any particular benchmark, the
+final capacity should, however, be:
+
+* A "single-threaded" or CPU affine benchmark
+* Divided by the running frequency of the CPU executing the benchmark
+* Not subject to dynamic frequency scaling of the CPU
+
+For the time being we however advise usage of the Dhrystone benchmark. What
+above thus becomes:
+
+CPU capacities are obtained by running the Dhrystone benchmark on each CPU at
+max frequency. The obtained DMIPS score is then divided by the frequency (in
+MHz) at which the benchmark has been run, so that DMIPS/MHz are obtained.
+Such values are then normalized w.r.t. the highest score obtained in the
+system.
+
+==========================================
+3 - capacity-dmips-mhz
+==========================================
+
+capacity-dmips-mhz is an optional cpu node [1] property: u32 value
+representing CPU capacity expressed in normalized DMIPS/MHz. At boot time, the
+maximum frequency available to the cpu is then used to calculate the capacity
+value internally used by the kernel.
+
+capacity-dmips-mhz property is all-or-nothing: if it is specified for a cpu
+node, it has to be specified for every other cpu nodes, or the system will
+fall back to the default capacity value for every CPU. If cpufreq is not
+available, final capacities are calculated by directly using capacity-dmips-
+mhz values (normalized w.r.t. the highest value found while parsing the DT).
+
+===========================================
+4 - Examples
+===========================================
+
+Example 1 (ARM 64-bit, 6-cpu system, two clusters):
+capacities-dmips-mhz are scaled w.r.t. 1024 (cpu@0 and cpu@1)
+supposing cluster0@max-freq=1100 and custer1@max-freq=850,
+final capacities are 1024 for cluster0 and 446 for cluster1
+
+cpus {
+	#address-cells = <2>;
+	#size-cells = <0>;
+
+	cpu-map {
+		cluster0 {
+			core0 {
+				cpu = <&A57_0>;
+			};
+			core1 {
+				cpu = <&A57_1>;
+			};
+		};
+
+		cluster1 {
+			core0 {
+				cpu = <&A53_0>;
+			};
+			core1 {
+				cpu = <&A53_1>;
+			};
+			core2 {
+				cpu = <&A53_2>;
+			};
+			core3 {
+				cpu = <&A53_3>;
+			};
+		};
+	};
+
+	idle-states {
+		entry-method = "arm,psci";
+
+		CPU_SLEEP_0: cpu-sleep-0 {
+			compatible = "arm,idle-state";
+			arm,psci-suspend-param = <0x0010000>;
+			local-timer-stop;
+			entry-latency-us = <100>;
+			exit-latency-us = <250>;
+			min-residency-us = <150>;
+		};
+
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "arm,idle-state";
+			arm,psci-suspend-param = <0x1010000>;
+			local-timer-stop;
+			entry-latency-us = <800>;
+			exit-latency-us = <700>;
+			min-residency-us = <2500>;
+		};
+	};
+
+	A57_0: cpu@0 {
+		compatible = "arm,cortex-a57","arm,armv8";
+		reg = <0x0 0x0>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A57_L2>;
+		clocks = <&scpi_dvfs 0>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity-dmips-mhz = <1024>;
+	};
+
+	A57_1: cpu@1 {
+		compatible = "arm,cortex-a57","arm,armv8";
+		reg = <0x0 0x1>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A57_L2>;
+		clocks = <&scpi_dvfs 0>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity-dmips-mhz = <1024>;
+	};
+
+	A53_0: cpu@100 {
+		compatible = "arm,cortex-a53","arm,armv8";
+		reg = <0x0 0x100>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A53_L2>;
+		clocks = <&scpi_dvfs 1>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity-dmips-mhz = <578>;
+	};
+
+	A53_1: cpu@101 {
+		compatible = "arm,cortex-a53","arm,armv8";
+		reg = <0x0 0x101>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A53_L2>;
+		clocks = <&scpi_dvfs 1>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity-dmips-mhz = <578>;
+	};
+
+	A53_2: cpu@102 {
+		compatible = "arm,cortex-a53","arm,armv8";
+		reg = <0x0 0x102>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A53_L2>;
+		clocks = <&scpi_dvfs 1>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity-dmips-mhz = <578>;
+	};
+
+	A53_3: cpu@103 {
+		compatible = "arm,cortex-a53","arm,armv8";
+		reg = <0x0 0x103>;
+		device_type = "cpu";
+		enable-method = "psci";
+		next-level-cache = <&A53_L2>;
+		clocks = <&scpi_dvfs 1>;
+		cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+		capacity-dmips-mhz = <578>;
+	};
+
+	A57_L2: l2-cache0 {
+		compatible = "cache";
+	};
+
+	A53_L2: l2-cache1 {
+		compatible = "cache";
+	};
+};
+
+Example 2 (ARM 32-bit, 4-cpu system, two clusters,
+	   cpus 0,1@1GHz, cpus 2,3@500MHz):
+capacities-dmips-mhz are scaled w.r.t. 2 (cpu@0 and cpu@1), this means that first
+cpu@0 and cpu@1 are twice fast than cpu@2 and cpu@3 (at the same frequency)
+
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cpu0: cpu@0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0>;
+		capacity-dmips-mhz = <2>;
+	};
+
+	cpu1: cpu@1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <1>;
+		capacity-dmips-mhz = <2>;
+	};
+
+	cpu2: cpu@2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x100>;
+		capacity-dmips-mhz = <1>;
+	};
+
+	cpu3: cpu@3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a15";
+		reg = <0x101>;
+		capacity-dmips-mhz = <1>;
+	};
+};
+
+===========================================
+5 - References
+===========================================
+
+[1] ARM Linux Kernel documentation - CPUs bindings
+    Documentation/devicetree/bindings/arm/cpus.txt
diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 3f0cbbb..d79442d 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -238,6 +238,14 @@ nodes to be present and contain the properties described below.
 			# List of phandles to idle state nodes supported
 			  by this cpu [3].
 
+	- capacity-dmips-mhz
+		Usage: Optional
+		Value type: <u32>
+		Definition:
+			# u32 value representing CPU capacity [3] in
+			  DMIPS/MHz, relative to highest capacity-dmips-mhz
+			  in the system.
+
 	- rockchip,pmu
 		Usage: optional for systems that have an "enable-method"
 		       property value of "rockchip,rk3066-smp"
@@ -461,3 +469,5 @@ cpus {
 [2] arm/msm/qcom,kpss-acc.txt
 [3] ARM Linux kernel documentation - idle states bindings
     Documentation/devicetree/bindings/arm/idle-states.txt
+[3] ARM Linux kernel documentation - cpu capacity bindings
+    Documentation/devicetree/bindings/arm/cpu-capacity.txt
-- 
2.7.0
