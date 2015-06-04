From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 11/15] ARM: shmobile: r8a7779 dtsi: Add SYSC PM domains
Date: Thu,  4 Jun 2015 20:53:37 +0200
Message-ID: <1433444021-22167-12-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add a device node for the System Controller, with subnodes that
represent the hardware power area hierarchy.
Hook up ARM CPU cores 1-3 to their respective PM domains.
Note that ARM CPU core 0 cannot be shut off.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7779.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index d75f46a539749eae..fbcf02c09fa5b57c 100644
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
 
@@ -569,4 +572,49 @@
 				"mmc1", "mmc0";
 		};
 	};
+
+	sysc: system-controller@ffd85000 {
+		compatible = "renesas,sysc-r8a7779", "renesas,sysc-rcar";
+		reg = <0 0xffd85000 0 0x0200>;
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
