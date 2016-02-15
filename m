From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 10/11] ARM: dts: r8a7794: Add SYSC PM domains
Date: Mon, 15 Feb 2016 22:16:59 +0100
Message-ID: <1455571020-18968-11-git-send-email-geert+renesas@glider.be>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:59155 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbcBOVRL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 16:17:11 -0500
In-Reply-To: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up the Cortex-A7 CPU cores and the Cortex-A7 L2 cache/SCU to their
respective PM domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7794.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 21a02df3609b24aa..d0fc735571242fd1 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -40,6 +40,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
+			power-domains = <&pd_ca7_cpu0>;
 			next-level-cache = <&L2_CA7>;
 		};
 
@@ -48,12 +49,14 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			power-domains = <&pd_ca7_cpu1>;
 			next-level-cache = <&L2_CA7>;
 		};
 	};
 
 	L2_CA7: cache-controller@1 {
 		compatible = "cache";
+		power-domains = <&pd_ca7_scu>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -1152,6 +1155,43 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7794-sysc", "renesas,rcar-gen2-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+
+		pm-domains {
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			pd_ca7_scu: scu@21 {
+				reg = <21 0x100>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_ca7_cpu0: cpu@5 {
+					reg = <5 0x1c0>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca7_cpu1: cpu@6 {
+					reg = <6 0x1c0>;
+					#power-domain-cells = <0>;
+				};
+			};
+
+			pd_sh: sh@16 {
+				reg = <16 0x80>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sgx: sgx@20 {
+				reg = <20 0xc0>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
 	ipmmu_sy0: mmu@e6280000 {
 		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
-- 
1.9.1

