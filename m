From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/6] ARM: Tegra: Add CPU's OPPs for using cpufreq-cpu0 driver
Date: Wed,  7 Aug 2013 20:16:44 +0530
Message-ID: <d4cd498d9b63d761039b025216e65278dc8e0e37.1375886595.git.viresh.kumar@linaro.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1375886595.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375886595.git.viresh.kumar@linaro.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, swarren@nvidia.com
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

cpufreq-cpu0 driver needs OPPs to be present in DT which can be probed by it to
get frequency table. This patch adds OPPs and clock-latency to tegra cpu0 node
for multiple SoCs.

Voltage levels aren't used until now for tegra and so a flat value which would
eventually be ignored is used to represent voltage.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/tegra114.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/tegra20.dtsi  | 12 ++++++++++++
 arch/arm/boot/dts/tegra30.dtsi  | 12 ++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index abf6c40..730e0d9 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -438,6 +438,18 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+			operating-points = <
+				/* kHz    ignored */
+				 216000   1000000
+				 312000   1000000
+				 456000   1000000
+				 608000   1000000
+				 760000   1000000
+				 816000   1000000
+				 912000   1000000
+				 1000000  1000000
+			>;
+			clock-latency = <300000>;
 		};
 
 		cpu@1 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9653fd8..5696f98 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -577,6 +577,18 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			operating-points = <
+				/* kHz    ignored */
+				 216000   1000000
+				 312000   1000000
+				 456000   1000000
+				 608000   1000000
+				 760000   1000000
+				 816000   1000000
+				 912000   1000000
+				 1000000  1000000
+			>;
+			clock-latency = <300000>;
 		};
 
 		cpu@1 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index d8783f0..5930290 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -569,6 +569,18 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			operating-points = <
+				/* kHz    ignored */
+				 216000   1000000
+				 312000   1000000
+				 456000   1000000
+				 608000   1000000
+				 760000   1000000
+				 816000   1000000
+				 912000   1000000
+				 1000000  1000000
+			>;
+			clock-latency = <300000>;
 		};
 
 		cpu@1 {
-- 
1.7.12.rc2.18.g61b472e

