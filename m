From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 4/6] dt-bindings: cp110: document the thermal interrupt
 capabilities
Date: Fri, 23 Nov 2018 17:17:28 +0100
Message-ID: <20181123161730.11289-5-miquel.raynal@bootlin.com>
References: <20181123161730.11289-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181123161730.11289-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Marc Zyngier <marc.zyngier@arm.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The thermal IP can produce interrupts on overheat situation.
Describe them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/arm/marvell/cp110-system-controller.txt     | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index 81ce742d2760..4db4119a6d19 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -199,6 +199,9 @@ Thermal:
 The thermal IP can probe the temperature all around the processor. It
 may feature several channels, each of them wired to one sensor.
 
+It is possible to setup an overheat interrupt by giving at least one
+critical point to any subnode of the thermal-zone node.
+
 For common binding part and usage, refer to
 Documentation/devicetree/bindings/thermal/thermal.txt
 
@@ -208,6 +211,11 @@ Required properties:
 - reg: register range associated with the thermal functions.
 
 Optional properties:
+- interrupts-extended: overheat interrupt handle. Should point to
+  a line of the ICU-SEI irqchip (116 is what is usually used by the
+  firmware). The ICU-SEI will redirect towards interrupt line #37 of the
+  AP SEI which is shared across all CPs.
+  See interrupt-controller/interrupts.txt
 - #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
   to this IP and represents the channel ID. There is one sensor per
   channel. O refers to the thermal IP internal channel.
@@ -220,6 +228,7 @@ CP110_LABEL(syscon1): system-controller@6f8000 {
 	CP110_LABEL(thermal): thermal-sensor@70 {
 		compatible = "marvell,armada-cp110-thermal";
 		reg = <0x70 0x10>;
+		interrupts-extended = <&CP110_LABEL(icu_sei) 116 IRQ_TYPE_LEVEL_HIGH>;
 		#thermal-sensor-cells = <1>;
 	};
 };
-- 
2.19.1
