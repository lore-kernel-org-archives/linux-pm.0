From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 16/23] dt-bindings: ap806: add the thermal node in the
 syscon file
Date: Mon, 16 Jul 2018 16:41:59 +0200
Message-ID: <20180716144206.30985-17-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180716144206.30985-1-miquel.raynal@bootlin.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../arm/marvell/ap806-system-controller.txt        | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index a856eb9a4e05..3fd21bb7cb37 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -11,6 +11,9 @@ For the top level node:
  - compatible: must be: "syscon", "simple-mfd";
  - reg: register area of the AP806 system controller
 
+SYSTEM CONTROLLER 0
+===================
+
 Clocks:
 -------
 
@@ -98,3 +101,38 @@ ap_syscon: system-controller@6f4000 {
 		gpio-ranges = <&ap_pinctrl 0 0 19>;
 	};
 };
+
+SYSTEM CONTROLLER 1
+===================
+
+Thermal:
+--------
+
+For common binding part and usage, refer to
+Documentation/devicetree/bindings/thermal/thermal.txt
+
+The thermal IP can probe the temperature all around the processor. It
+may feature several channels, each of them wired to one sensor.
+
+Required properties:
+- compatible: must be one of:
+  * marvell,armada-ap806-thermal
+- reg: register range associated with the thermal functions.
+
+Optional properties:
+- #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
+  to this IP and represents the channel ID. There is one sensor per
+  channel. O refers to the thermal IP internal channel, while positive
+  IDs refer to each CPU.
+
+Example:
+ap_syscon1: system-controller@6f8000 {
+	compatible = "syscon", "simple-mfd";
+	reg = <0x6f8000 0x1000>;
+
+	ap_thermal: thermal-sensor@80 {
+		compatible = "marvell,armada-ap806-thermal";
+		reg = <0x80 0x10>;
+		#thermal-sensor-cells = <1>;
+	};
+};
-- 
2.14.1
