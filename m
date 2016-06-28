From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 13/13] ARM: dts: r8a7793: Add APMU node and second CPU core
Date: Tue, 28 Jun 2016 16:10:42 +0200
Message-ID: <1467123042-8468-14-git-send-email-geert+renesas@glider.be>
References: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add DT nodes for the Advanced Power Management Unit (APMU) and the
second CPU core.  Use the enable-method to point out that the APMU
should be used for SMP support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - Add missing power-domains property to cpu1 node,

v4:
  - Improve patch description,
  - Use "renesas,<soctype>-apmu" instead of "renesas,apmu-<soctype>",

v3:
  - New.
---
 arch/arm/boot/dts/r8a7793.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 9b55c1c6ee31a49d..8d02aacf28926271 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -35,6 +35,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
@@ -56,6 +57,14 @@
 			next-level-cache = <&L2_CA15>;
 		};
 
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1500000000>;
+			power-domains = <&sysc R8A7793_PD_CA15_CPU1>;
+		};
+
 		L2_CA15: cache-controller@0 {
 			compatible = "cache";
 			reg = <0>;
@@ -65,6 +74,12 @@
 		};
 	};
 
+	apmu@e6152000 {
+		compatible = "renesas,r8a7793-apmu", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x188>;
+		cpus = <&cpu0 &cpu1>;
+	};
+
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
 			polling-delay-passive	= <0>;
-- 
1.9.1
