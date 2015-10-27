From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC v3 4/7] arm64: Juno: declare generic power domains for both clusters.
Date: Tue, 27 Oct 2015 18:40:53 +0100
Message-ID: <1445967656-28292-5-git-send-email-mtitinger+renesas@baylibre.com>
References: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
In-Reply-To: <20151019205825.GA82426@linaro.org>
References: <20151019205825.GA82426@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lina.iyer@linaro.org
Cc: rjw@rjwysocki.net, khilman@kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Marc Titinger <mtitinger@baylibre.com>

Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
---
 arch/arm64/boot/dts/arm/juno.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index b3fcee8..0a72c07 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -91,6 +91,7 @@
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a57_pd>;
 		};
 
 		A57_1: cpu@1 {
@@ -101,6 +102,7 @@
 			next-level-cache = <&A57_L2>;
 			clocks = <&scpi_dvfs 0>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a57_pd>;
 		};
 
 		A53_0: cpu@100 {
@@ -111,6 +113,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a53_pd>;
 		};
 
 		A53_1: cpu@101 {
@@ -121,6 +124,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a53_pd>;
 		};
 
 		A53_2: cpu@102 {
@@ -131,6 +135,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a53_pd>;
 		};
 
 		A53_3: cpu@103 {
@@ -141,6 +146,7 @@
 			next-level-cache = <&A53_L2>;
 			clocks = <&scpi_dvfs 1>;
 			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
+			power-domains = <&a53_pd>;
 		};
 
 		A57_L2: l2-cache0 {
@@ -152,6 +158,19 @@
 		};
 	};
 
+	CPU_PD: cpu-domains {
+
+		a57_pd: a57_pd@ {
+			compatible = "arm,cpu-pd";
+			#power-domain-cells = <0>;
+		};
+
+		a53_pd: a53_pd@ {
+			compatible = "arm,cpu-pd";
+			#power-domain-cells = <0>;
+		};
+	};
+
 	pmu_a57 {
 		compatible = "arm,cortex-a57-pmu";
 		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1
