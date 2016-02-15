From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 06/11] ARM: dts: r8a7779: Add SYSC PM domains
Date: Mon, 15 Feb 2016 22:16:55 +0100
Message-ID: <1455571020-18968-7-git-send-email-geert+renesas@glider.be>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:60583 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbcBOVRM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 16:17:12 -0500
In-Reply-To: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up ARM CPU cores 1-3 to their respective PM domains.
Note that ARM CPU core 0 cannot be shut off.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Correct sysc "reg" property (#address/size-cells = 1, not 2),
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7779.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index a0cc08e6295b0396..14b28c225bb3587c 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -34,18 +34,21 @@
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			clock-frequency = <1000000000>;
+			power-domains = <&pd_arm1>;
 		};
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
 			clock-frequency = <1000000000>;
+			power-domains = <&pd_arm2>;
 		};
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
 			clock-frequency = <1000000000>;
+			power-domains = <&pd_arm3>;
 		};
 	};
 
@@ -591,4 +594,49 @@
 				"mmc1", "mmc0";
 		};
 	};
+
+	sysc: system-controller@ffd85000 {
+		compatible = "renesas,r8a7779-sysc";
+		reg = <0xffd85000 0x0200>;
+
+		pm-domains {
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			pd_arm1: cpu@1 {
+				reg = <1 0x41>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_arm2: cpu@2 {
+				reg = <2 0x42>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_arm3: cpu@3 {
+				reg = <3 0x43>;
+				#power-domain-cells = <0>;
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
+
+			pd_vdp: vdp@21 {
+				reg = <21 0x100>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_imp: imp@24 {
+				reg = <24 0x140>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
 };
-- 
1.9.1

