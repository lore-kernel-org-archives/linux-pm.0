From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC v2 11/11] arm64: dts: r8a7795: Add SYSC PM domains
Date: Mon, 15 Feb 2016 22:17:00 +0100
Message-ID: <1455571020-18968-12-git-send-email-geert+renesas@glider.be>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455571020-18968-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up the Cortex-A57 CPU cores and the Cortex-A57 and Cortex A53 L2
caches/SCUs to their respective PM domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
The SH core was dropped in datasheet rev. 0.5E?

v2:
  - New.
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 142 +++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c572527afec3403a..69f400e0d478b285 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -39,6 +39,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x0>;
 			device_type = "cpu";
+			power-domains = <&pd_ca57_cpu0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
@@ -47,6 +48,7 @@
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x1>;
 			device_type = "cpu";
+			power-domains = <&pd_ca57_cpu1>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
@@ -54,6 +56,7 @@
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x2>;
 			device_type = "cpu";
+			power-domains = <&pd_ca57_cpu2>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
@@ -61,6 +64,7 @@
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x3>;
 			device_type = "cpu";
+			power-domains = <&pd_ca57_cpu3>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
@@ -68,12 +72,14 @@
 
 	L2_CA57: cache-controller@0 {
 		compatible = "cache";
+		power-domains = <&pd_ca57_scu>;
 		cache-unified;
 		cache-level = <2>;
 	};
 
 	L2_CA53: cache-controller@1 {
 		compatible = "cache";
+		power-domains = <&pd_ca53_scu>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -968,5 +974,141 @@
 			#dma-cells = <1>;
 			dma-channels = <2>;
 		};
+
+		sysc: system-controller@e6180000 {
+			compatible = "renesas,r8a7795-sysc",
+				     "renesas,rcar-gen3-sysc";
+			reg = <0 0xe6180000 0 0x0400>;
+
+			pm-domains {
+				#address-cells = <2>;
+				#size-cells = <0>;
+
+				pd_ca57_scu: ca57_scu@12 {
+					reg = <12 0x1c0>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_ca57_cpu0: ca57_cpu@0 {
+						reg = <0 0x80>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_ca57_cpu1: ca57_cpu@1 {
+						reg = <1 0x81>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_ca57_cpu2: ca57_cpu@2 {
+						reg = <2 0x82>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_ca57_cpu3: ca57_cpu@3 {
+						reg = <3 0x83>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				pd_ca53_scu: ca53_scu@21 {
+					reg = <21 0x140>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_ca53_cpu0: ca53_cpu@5 {
+						reg = <5 0x200>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_ca53_cpu1: ca53_cpu@6 {
+						reg = <6 0x201>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_ca53_cpu2: ca53_cpu@7 {
+						reg = <7 0x202>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_ca53_cpu3: ca53_cpu@8 {
+						reg = <8 0x203>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				pd_a3vp: a3vp@9 {
+					reg = <9 0x340>;
+					#power-domain-cells = <0>;
+				};
+
+
+				pd_cr7: cr7@13 {
+					reg = <13 0x240>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_a3vc: a3vc@14 {
+					reg = <14 0x380>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_a2vc0: a2vc@25 {
+						reg = <25 0x3c0>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_a2vc1: a2vc@26 {
+						reg = <26 0x3c1>;
+						#power-domain-cells = <0>;
+					};
+				};
+
+				pd_a3sh: a3sh@16 {
+					reg = <16 0xc0>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_3dg_a: 3dg@17 {
+					reg = <17 0x100>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+					#power-domain-cells = <0>;
+
+					pd_3dg_b: 3dg@18 {
+						reg = <18 0x101>;
+						#address-cells = <2>;
+						#size-cells = <0>;
+						#power-domain-cells = <0>;
+
+						pd_3dg_c: 3dg@19 {
+							reg = <19 0x102>;
+							#address-cells = <2>;
+							#size-cells = <0>;
+							#power-domain-cells = <0>;
+
+							pd_3dg_d: 3dg@20 {
+								reg = <20 0x103>;
+								#address-cells = <2>;
+								#size-cells = <0>;
+								#power-domain-cells = <0>;
+
+								pd_3dg_e: 3dg@22 {
+									reg = <22 0x104>;
+									#power-domain-cells = <0>;
+								};
+							};
+						};
+					};
+				};
+
+				pd_a3ir: a3ir@24 {
+					reg = <24 0x180>;
+					#power-domain-cells = <0>;
+				};
+			};
+		};
 	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
