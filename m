From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 2/7] arm64: Juno: declare generic power domains for both clusters.
Date: Fri, 25 Sep 2015 15:04:04 +0200
Message-ID: <1443186249-14596-3-git-send-email-mtitinger+renesas@baylibre.com>
References: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, lina.iyer@linaro.org, Marc Titinger <mtitinger@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Marc Titinger <mtitinger@baylibre.com>

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 arch/arm64/boot/dts/arm/juno.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 342bb99..499f035 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -63,6 +63,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a57_pd>;
 		};
 
 		A57_1: cpu@1 {
@@ -72,6 +73,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A57_L2>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a57_pd>;
 		};
 
 		A53_0: cpu@100 {
@@ -81,6 +83,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a53_pd>;
 		};
 
 		A53_1: cpu@101 {
@@ -90,6 +93,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a53_pd>;
 		};
 
 		A53_2: cpu@102 {
@@ -99,6 +103,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a53_pd>;
 		};
 
 		A53_3: cpu@103 {
@@ -108,6 +113,7 @@
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a53_pd>;
 		};
 
 		A57_L2: l2-cache0 {
@@ -119,6 +125,19 @@
 		};
 	};
 
+	pm-domains {
+
+		a57_pd: a57_pd@ {
+			compatible = "arm,pd";
+			#power-domain-cells = <0>;
+		};
+
+		a53_pd: a53_pd@ {
+			compatible = "arm,pd";
+			#power-domain-cells = <0>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1
