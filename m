From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC v3 3/7] arm64: dts: Add idle-states for Juno
Date: Tue, 27 Oct 2015 18:40:52 +0100
Message-ID: <1445967656-28292-4-git-send-email-mtitinger+renesas@baylibre.com>
References: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
In-Reply-To: <20151019205825.GA82426@linaro.org>
References: <20151019205825.GA82426@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lina.iyer@linaro.org
Cc: rjw@rjwysocki.net, khilman@kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Medhurst <tixy@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Jon Medhurst <tixy@linaro.org>

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 arch/arm64/boot/dts/arm/juno.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 53442b5..b3fcee8 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -60,6 +60,29 @@
 			};
 		};
 
+		idle-states {
+
+			entry-method = "arm,psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010000>;
+				local-timer-stop;
+				entry-latency-us = <100>;
+				exit-latency-us = <250>;
+				min-residency-us = <2000>;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x1010000>;
+				local-timer-stop;
+				entry-latency-us = <800>;
+				exit-latency-us = <700>;
+				min-residency-us = <2500>;
+			};
+		};
+
 		A57_0: cpu@0 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x0 0x0>;
@@ -67,6 +90,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A57_1: cpu@1 {
@@ -76,6 +100,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_0: cpu@100 {
@@ -85,6 +110,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_1: cpu@101 {
@@ -94,6 +120,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_2: cpu@102 {
@@ -103,6 +130,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A53_3: cpu@103 {
@@ -112,6 +140,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
+			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
 		};
 
 		A57_L2: l2-cache0 {
-- 
1.9.1
