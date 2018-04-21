From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 22/27] arm64: dts: marvell: move AP806/CP110 thermal nodes
 into a new syscon
Date: Sat, 21 Apr 2018 17:12:50 +0200
Message-ID: <20180421151255.29929-23-miquel.raynal@bootlin.com>
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

New bindings impose to declare the thermal IP from within a new syscon.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 11 +++++++----
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 15 +++++++++------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 71208aba4468..b173d21f2216 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -266,10 +266,13 @@
 				};
 			};
 
-			ap_thermal: thermal@6f808c {
-				compatible = "marvell,armada-ap806-thermal";
-				reg = <0x6f808c 0x4>,
-				      <0x6f8084 0x8>;
+			ap_syscon1: system-controller@6f8000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x6f8000 0x1000>;
+
+				ap_thermal: ap-thermal {
+					compatible = "marvell,armada-ap806-thermal";
+				};
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 8e989c721b4c..514780980847 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -170,12 +170,6 @@
 			interrupts = <77 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		CP110_LABEL(thermal): thermal@400078 {
-			compatible = "marvell,armada-cp110-thermal";
-			reg = <0x400078 0x4>,
-			<0x400070 0x8>;
-		};
-
 		CP110_LABEL(syscon0): system-controller@440000 {
 			compatible = "syscon", "simple-mfd";
 			reg = <0x440000 0x2000>;
@@ -216,6 +210,15 @@
 			};
 		};
 
+		CP110_LABEL(syscon1): system-controller@400000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x400000 0x1000>;
+
+			CP110_LABEL(thermal): thermal@400070 {
+				compatible = "marvell,armada-cp110-thermal";
+			};
+		};
+
 		CP110_LABEL(usb3_0): usb3@500000 {
 			compatible = "marvell,armada-8k-xhci",
 			"generic-xhci";
-- 
2.14.1
