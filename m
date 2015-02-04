From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] ARM: shmobile: r8a73a4 dtsi: Add PM domain support
Date: Wed,  4 Feb 2015 14:52:45 +0100
Message-ID: <1423057966-23321-3-git-send-email-geert+renesas@glider.be>
References: <1423057966-23321-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:36734 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbbBDNxA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 08:53:00 -0500
In-Reply-To: <1423057966-23321-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up all devices to their respective PM domains.

Add a minimal device node for the Coresight-ETM hardware block, and
hook it up to the D4 PM domain, so the R-Mobile System Controller
driver can keep the domain powered, until the new Coresight code
handles runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 177 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 77bd35cd89113df7..0129a3782e8beba6 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -28,9 +28,15 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1500000000>;
+			power-domains = <&pd_a2sl>;
 		};
 	};
 
+	ptm {
+		compatible = "arm,coresight-etm3x";
+		power-domains = <&pd_d4>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -42,11 +48,13 @@
 	dbsc1: memory-controller@e6790000 {
 		compatible = "renesas,dbsc-r8a73a4";
 		reg = <0 0xe6790000 0 0x10000>;
+		power-domains = <&pd_a3bc>;
 	};
 
 	dbsc2: memory-controller@e67a0000 {
 		compatible = "renesas,dbsc-r8a73a4";
 		reg = <0 0xe67a0000 0 0x10000>;
+		power-domains = <&pd_a3bc>;
 	};
 
 	dmac: dma-multiplexer {
@@ -89,6 +97,7 @@
 					"ch12", "ch13", "ch14", "ch15",
 					"ch16", "ch17", "ch18", "ch19";
 			clocks = <&mstp2_clks R8A73A4_CLK_DMAC>;
+			power-domains = <&pd_a3sp>;
 		};
 	};
 
@@ -113,6 +122,7 @@
 			<&irqc1 16 0>, <&irqc1 17 0>, <&irqc1 18 0>, <&irqc1 19 0>,
 			<&irqc1 20 0>, <&irqc1 21 0>, <&irqc1 22 0>, <&irqc1 23 0>,
 			<&irqc1 24 0>, <&irqc1 25 0>;
+		power-domains = <&pd_c5>;
 	};
 
 	i2c5: i2c@e60b0000 {
@@ -122,6 +132,7 @@
 		reg = <0 0xe60b0000 0 0x428>;
 		interrupts = <0 179 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IIC5>;
+		power-domains = <&pd_a3sp>;
 
 		status = "disabled";
 	};
@@ -132,6 +143,7 @@
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
 		clock-names = "fck";
+		power-domains = <&pd_c5>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -175,6 +187,7 @@
 			     <0 29 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 30 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd_c4>;
 	};
 
 	irqc1: interrupt-controller@e61c0200 {
@@ -208,6 +221,7 @@
 			     <0 55 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 56 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 57 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pd_c4>;
 	};
 
 	thermal@e61f0000 {
@@ -216,6 +230,7 @@
 			 <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A73A4_CLK_THERMAL>;
+		power-domains = <&pd_c5>;
 	};
 
 	i2c0: i2c@e6500000 {
@@ -225,6 +240,7 @@
 		reg = <0 0xe6500000 0 0x428>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC0>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -235,6 +251,7 @@
 		reg = <0 0xe6510000 0 0x428>;
 		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC1>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -245,6 +262,7 @@
 		reg = <0 0xe6520000 0 0x428>;
 		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC2>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -255,6 +273,7 @@
 		reg = <0 0xe6530000 0 0x428>;
 		interrupts = <0 177 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IIC3>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -265,6 +284,7 @@
 		reg = <0 0xe6540000 0 0x428>;
 		interrupts = <0 178 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A73A4_CLK_IIC4>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -275,6 +295,7 @@
 		reg = <0 0xe6550000 0 0x428>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC6>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -285,6 +306,7 @@
 		reg = <0 0xe6560000 0 0x428>;
 		interrupts = <0 185 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_IIC7>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -295,6 +317,7 @@
 		reg = <0 0xe6570000 0 0x428>;
 		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A73A4_CLK_IIC8>;
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -304,6 +327,7 @@
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB0>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -313,6 +337,7 @@
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB1>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -322,6 +347,7 @@
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -331,6 +357,7 @@
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -340,6 +367,7 @@
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB2>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
 
@@ -349,6 +377,7 @@
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB3>;
 		clock-names = "sci_ick";
+		power-domains = <&pd_c4>;
 		status = "disabled";
 	};
 
@@ -357,6 +386,7 @@
 		reg = <0 0xee100000 0 0x100>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_SDHI0>;
+		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -366,6 +396,7 @@
 		reg = <0 0xee120000 0 0x100>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_SDHI1>;
+		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -375,6 +406,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_SDHI2>;
+		power-domains = <&pd_a3sp>;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -384,6 +416,7 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF0>;
+		power-domains = <&pd_a3sp>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -393,6 +426,7 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_MMCIF1>;
+		power-domains = <&pd_a3sp>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -417,6 +451,7 @@
 		ranges = <0 0 0 0x20000000>;
 		reg = <0 0xfec10000 0 0x400>;
 		clocks = <&zb_clk>;
+		power-domains = <&pd_c4>;
 	};
 
 	clocks {
@@ -711,4 +746,146 @@
 				"thermal", "iic8";
 		};
 	};
+
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,sysc-r8a73a4", "renesas,sysc-rmobile";
+		reg = <0 0xe6180000 0 0x8000>, <0 0xe6188000 0 0x8000>;
+
+		pm-domains {
+			pd_c5: c5 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_c4: c4@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3sg: a3sg@16 {
+						reg = <16>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a3ex: a3ex@17 {
+						reg = <17>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a3sp: a3sp@18 {
+						reg = <18>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <0>;
+
+						pd_a2us: a2us@19 {
+							reg = <19>;
+							#power-domain-cells = <0>;
+						};
+					};
+
+					pd_a3sm: a3sm@20 {
+						reg = <20>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <0>;
+
+						pd_a2sl: a2sl@21 {
+							reg = <21>;
+							#power-domain-cells = <0>;
+						};
+					};
+
+					pd_a3km: a3km@22 {
+						reg = <22>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <0>;
+
+						pd_a2kl: a2kl@23 {
+							reg = <23>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				pd_c4ma: c4ma@1 {
+					reg = <1>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_c4cl: c4cl@2 {
+					reg = <2>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_d4: d4@3 {
+					reg = <3>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4bc: a4bc@4 {
+					reg = <4>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3bc: a3bc@5 {
+						reg = <5>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				pd_a4l: a4l@6 {
+					reg = <6>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4lc: a4lc@7 {
+					reg = <7>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a4mp: a4mp@8 {
+					reg = <8>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a3mp: a3mp@9 {
+						reg = <9>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a3vc: a3vc@10 {
+						reg = <10>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				pd_a4sf: a4sf@11 {
+					reg = <11>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a3r: a3r@12 {
+					reg = <12>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a2rv: a2rv@13 {
+						reg = <13>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a2is: a2is@14 {
+						reg = <14>;
+						#power-domain-cells = <0>;
+					};
+				};
+			};
+		};
+	};
 };
-- 
1.9.1

