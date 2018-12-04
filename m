From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 3/6] dt-bindings: ap806: document the thermal interrupt
 capabilities
Date: Tue,  4 Dec 2018 20:03:29 +0100
Message-ID: <20181204190332.10351-4-miquel.raynal@bootlin.com>
References: <20181204190332.10351-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181204190332.10351-1-miquel.raynal@bootlin.com>
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
 .../bindings/arm/marvell/ap806-system-controller.txt      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 3fd21bb7cb37..35e8dd2edfd2 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -114,12 +114,18 @@ Documentation/devicetree/bindings/thermal/thermal.txt
 The thermal IP can probe the temperature all around the processor. It
 may feature several channels, each of them wired to one sensor.
 
+It is possible to setup an overheat interrupt by giving at least one
+critical point to any subnode of the thermal-zone node.
+
 Required properties:
 - compatible: must be one of:
   * marvell,armada-ap806-thermal
 - reg: register range associated with the thermal functions.
 
 Optional properties:
+- interrupt-parent/interrupts: overheat interrupt handle. Should point to
+  line 18 of the SEI irqchip.
+  See interrupt-controller/interrupts.txt
 - #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
   to this IP and represents the channel ID. There is one sensor per
   channel. O refers to the thermal IP internal channel, while positive
@@ -133,6 +139,8 @@ ap_syscon1: system-controller@6f8000 {
 	ap_thermal: thermal-sensor@80 {
 		compatible = "marvell,armada-ap806-thermal";
 		reg = <0x80 0x10>;
+		interrupt-parent = <&sei>;
+		interrupts = <18>;
 		#thermal-sensor-cells = <1>;
 	};
 };
-- 
2.19.1
