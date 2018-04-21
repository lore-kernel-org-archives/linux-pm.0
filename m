From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 26/27] arm64: dts: marvell: add interrupt support to ap806
 thermal node
Date: Sat, 21 Apr 2018 17:12:54 +0200
Message-ID: <20180421151255.29929-27-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
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

Add interrupt properties in the thermal node as well as a critical trip
point in the thermal-zone.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index a6fee3ccbc11..d5a7448896b2 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -273,6 +273,8 @@
 
 				ap_thermal: ap-thermal {
 					compatible = "marvell,armada-ap806-thermal";
+					interrupt-parent = <&sei_wired_controller>;
+					interrupts = <18>;
 					#thermal-sensor-cells = <1>;
 				};
 			};
@@ -283,16 +285,26 @@
 	 * The thermal IP features one internal sensor plus, if applicable, one
 	 * remote channel wired to one sensor per CPU.
 	 *
+	 * Only one thermal zone per AP/CP may trigger interrupts at a time, the
+	 * first one that will have a critical trip point will be chosen.
+	 *
 	 * The cooling maps are always empty as there are no cooling devices.
 	 */
 	thermal-zones {
 		ap_thermal_ic: ap-thermal-ic {
-			polling-delay-passive = <1000>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>; /* Interrupt driven */
+			polling-delay = <0>; /* Interrupt driven */
 
 			thermal-sensors = <&ap_thermal 0>;
 
-			trips {	};
+			trips {
+				ap_crit: ap-crit {
+					temperature = <100000>; /* mC degrees */
+					hysteresis = <2000>; /* mC degrees */
+					type = "critical";
+				};
+			};
+
 			cooling-maps { };
 		};
 
-- 
2.14.1
