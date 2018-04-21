From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 19/27] dt-bindings: cp110: add the thermal node in the syscon
 file
Date: Sat, 21 Apr 2018 17:12:47 +0200
Message-ID: <20180421151255.29929-20-miquel.raynal@bootlin.com>
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

Explain the thermal bindings now that the thermal IP is described being
inside of a system controller. Add a reference to the thermal-zone node.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../arm/marvell/cp110-system-controller.txt        | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index 54b0d64ce819..e372c21d2a57 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -11,6 +11,9 @@ For the top level node:
  - compatible: must be: "syscon", "simple-mfd";
  - reg: register area of the CP110 system controller
 
+SYSTEM CONTROLLER 0
+===================
+
 Clocks:
 -------
 
@@ -186,3 +189,42 @@ CP110_LABEL(syscon0): system-controller@440000 {
 	};
 
 };
+
+SYSTEM CONTROLLER 1
+===================
+
+Thermal:
+--------
+
+The thermal IP can probe the temperature all around the processor. It
+may feature several channels, each of them wired to one sensor.
+
+It is possible to setup an overheat interrupt by giving at least one
+critical point to any subnode of the thermal-zone node.
+
+For common binding part and usage, refer to
+Documentation/devicetree/bindings/thermal/thermal.txt
+
+Required properties:
+- compatible: "marvell,armada-cp110-thermal"
+
+Optional properties:
+- interrupt-parent/interrupts: overheat interrupt handle. Should point to
+  line 37 of the SEI irqchip (shared between CPs).
+  See interrupt-controller/interrupts.txt
+- #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
+  to this IP and represents the channel ID. There is one sensor per
+  channel. O refers to the thermal IP internal channel.
+
+Example:
+CP110_LABEL(syscon1): system-controller@6f8000 {
+	compatible = "syscon", "simple-mfd";
+	reg = <0x6f8000 0x1000>;
+
+	CP110_LABEL(thermal): ap-thermal {
+		compatible = "marvell,armada-cp110-thermal";
+		interrupt-parent = <&sei>;
+		interrupts = <37>;
+		#thermal-sensor-cells = <1>;
+	};
+};
-- 
2.14.1
