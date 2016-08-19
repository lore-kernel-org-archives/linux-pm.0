From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/3] Documentation: dt: Add TI-SCI PM Domains
Date: Fri, 19 Aug 2016 18:56:51 -0500
Message-ID: <20160819235653.26355-2-nm@ti.com>
References: <20160819235653.26355-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160819235653.26355-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Add a generic power domain implementation, TI SCI PM Domains, that
will hook into the genpd framework and allow each PD, which will be
created one per device, to be managed over the TI-SCI protocol.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 58 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt

diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
new file mode 100644
index 000000000000..059a5d71d692
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
@@ -0,0 +1,58 @@
+Texas Instruments TI-SCI Generic Power Domain
+---------------------------------------------
+
+Some TI SoCs contain a system controller (like the PMMC, etc...) that are
+responsible for control the state of the IPs that are present. Communication
+between the host processor running an OS and the system controller happens
+through a protocol known as TI-SCI[1]. This pm domain implementation plugs into
+the generic pm domain framework and makes use of the TI SCI protocol power on
+and off each device when needed.
+
+[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+PM Domains Nodes
+================
+The PM domains node represents the global PM domain managed by the PMMC,
+which in this case is one cell implementation as documented by the generic
+PM domain bindings in
+Documentation/devicetree/bindings/power/power_domain.txt.
+
+Required Properties:
+--------------------
+- compatible: should be "ti,sci-pm-domains"
+- #power-domain-cells: Must be 1 so that an offset can be provided in each
+		       device node.
+- ti,sci: Phandle to the TI SCI device to use for managing the devices
+
+Example:
+--------------------
+/* From arch/arm/boot/dts/k2g.dtsi */
+k2g_pds: k2g_pds {
+        compatible = "ti,sci-pm-domains";
+        #power-domain-cells = <1>;
+        ti,sci = <&pmmc>;
+};
+
+PM Domain Consumers
+===================
+Hardware blocks belonging to a PM domain should contain a "power-domains"
+property that is a phandle pointing to the corresponding PM domain node
+along with an index representing the device id to be passed for the PMMC
+for device control.
+
+See dt-bindings/genpd/k2g.h for the list of valid identifiers for k2g.
+
+Example:
+--------------------
+/* From arch/arm/boot/dts/k2g.dtsi */
+uart0: serial@02530c00 {
+	compatible = "ns16550a";
+	current-speed = <115200>;
+	reg-shift = <2>;
+	reg-io-width = <4>;
+	reg = <0x02530c00 0x100>;
+	interrupts = <GIC_SPI 164 IRQ_TYPE_EDGE_RISING>;
+	clock-frequency = <200000000>;
+	status = "disabled";
+	power-domains = <&k2g_pds K2G_DEV_UART0>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 0c5e3d16f694..657fb6a10286 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11573,6 +11573,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 F:	drivers/firmware/ti_sci*
 F:	include/linux/soc/ti/ti_sci_protocol.h
+F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.9.1.200.gb1ec08f
