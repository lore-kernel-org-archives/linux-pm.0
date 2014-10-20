From: Chander Kashyap <k.chander@samsung.com>
Subject: [PATCH v2] arm64: dts: exynos7: add support for cpuidle core power down
Date: Mon, 20 Oct 2014 15:28:27 +0530
Message-ID: <1413799107-12307-1-git-send-email-k.chander@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <k.chander@samsung.com>
List-Id: linux-pm@vger.kernel.org

Exynos7 has core power down state where cores can be powered off independently.
This patch adds support for this state.

Signed-off-by: Chander Kashyap <k.chander@samsung.com>
---
This patch has following dependencies:
	- [PATCH v5 0/8] arch: arm64: Enable support for Samsung Exynos7 SoC
		http://www.spinics.net/lists/linux-samsung-soc/msg37047.html
Changes in v2:
	- Moved the cpu-idle-state property after reg property
	- removed the status property.

 arch/arm64/boot/dts/exynos/exynos7.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 50ae936..444dde1 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -37,6 +37,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			enable-method = "psci";
 			reg = <0x0>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
 		cpu@1 {
@@ -44,6 +45,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			enable-method = "psci";
 			reg = <0x1>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
 		cpu@2 {
@@ -51,6 +53,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			enable-method = "psci";
 			reg = <0x2>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
 		cpu@3 {
@@ -58,6 +61,20 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			enable-method = "psci";
 			reg = <0x3>;
+			cpu-idle-states = <&CPU_SLEEP>;
+		};
+
+		idle-states {
+			entry-method = "arm,psci";
+
+			CPU_SLEEP: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x0010000>;
+				entry-latency-us = <20>;
+				exit-latency-us = <150>;
+				min-residency-us = <2100>;
+			};
 		};
 	};
 
-- 
1.7.9.5
