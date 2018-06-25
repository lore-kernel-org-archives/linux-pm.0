From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 21/23] arm64: dts: marvell: add thermal-zone node in ap806
 DTSI file
Date: Mon, 25 Jun 2018 17:12:37 +0200
Message-ID: <20180625151239.20976-22-miquel.raynal@bootlin.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180625151239.20976-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add a thermal-zone node and fill in all the sensors available in an
ap806 (one in the IC plus one per CPU).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 60 +++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 3c6896fb96e6..575171f89dd5 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
 
 /dts-v1/;
 
@@ -267,8 +268,67 @@
 				ap_thermal: ap-thermal@80 {
 					compatible = "marvell,armada-ap806-thermal";
 					reg = <0x80 0x10>;
+					#thermal-sensor-cells = <1>;
 				};
 			};
 		};
 	};
+
+	/*
+	 * The thermal IP features one internal sensor plus, if applicable, one
+	 * remote channel wired to one sensor per CPU.
+	 *
+	 * The cooling maps are always empty as there are no cooling devices.
+	 */
+	thermal-zones {
+		ap_thermal_ic: ap-thermal-ic {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&ap_thermal 0>;
+
+			trips {	};
+			cooling-maps { };
+		};
+
+		ap_thermal_cpu1: ap-thermal-cpu1 {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&ap_thermal 1>;
+
+			trips { };
+			cooling-maps { };
+		};
+
+		ap_thermal_cpu2: ap-thermal-cpu2 {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&ap_thermal 2>;
+
+			trips { };
+			cooling-maps { };
+		};
+
+		ap_thermal_cpu3: ap-thermal-cpu3 {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&ap_thermal 3>;
+
+			trips { };
+			cooling-maps { };
+		};
+
+		ap_thermal_cpu4: ap-thermal-cpu4 {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&ap_thermal 4>;
+
+			trips { };
+			cooling-maps { };
+		};
+	};
 };
-- 
2.14.1
