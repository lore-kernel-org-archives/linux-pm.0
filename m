From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 11/13] ARM: dts: r8a7790: Add APMU nodes
Date: Tue, 28 Jun 2016 16:10:40 +0200
Message-ID: <1467123042-8468-12-git-send-email-geert+renesas@glider.be>
References: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1467123042-8468-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add DT nodes for the Advanced Power Management Units (APMU), and use the
enable-method to point out that the APMU should be used for SMP
support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - No changes,

v4:
  - Improve patch description,
  - Use "renesas,<soctype>-apmu" instead of "renesas,apmu-<soctype>",

v3:
  - No changes,

v2:
  - New.
---
 arch/arm/boot/dts/r8a7790.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 9997e7dfabe2250c..d18558f211022826 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -44,6 +44,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
@@ -164,6 +165,18 @@
 		};
 	};
 
+	apmu@e6151000 {
+		compatible = "renesas,r8a7790-apmu", "renesas,apmu";
+		reg = <0 0xe6151000 0 0x188>;
+		cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
+	};
+
+	apmu@e6152000 {
+		compatible = "renesas,r8a7790-apmu", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x188>;
+		cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
1.9.1
