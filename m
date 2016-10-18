From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 1/5] Documentation: Add support for TI System Control Interface (TI-SCI) protocol
Date: Tue, 18 Oct 2016 18:08:33 -0500
Message-ID: <20161018230837.6515-2-nm@ti.com>
References: <20161018230837.6515-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35834 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938483AbcJRXJq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2016 19:09:46 -0400
In-Reply-To: <20161018230837.6515-1-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Andrew Davis <afd@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Russ Dill <Russ.Dill@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>

Texas Instrument's System Control Interface (TI-SCI) Message Protocol
is used in Texas Instrument's System on Chip (SoC) such as those in
newer SoCs in the keystone processor family starting with K2G.

This message protocol is used to communicate between various compute
or processing entities (such as ARM, DSP etc.) with a central system
controller entity.

TI-SCI message protocol provides support for management of various
hardware entities within the SoC.

The message protocol can be found here:
http://processors.wiki.ti.com/index.php/TISCI

Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V4: No change, just picked up Rob's Ack from v3.

V3: https://patchwork.kernel.org/patch/9317825/

 .../devicetree/bindings/arm/keystone/ti,sci.txt    | 81 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
new file mode 100644
index 000000000000..31f5f9a104cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
@@ -0,0 +1,81 @@
+Texas Instruments System Control Interface (TI-SCI) Message Protocol
+--------------------------------------------------------------------
+
+Texas Instrument's processors including those belonging to Keystone generation
+of processors have separate hardware entity which is now responsible for the
+management of the System on Chip (SoC) system. These include various system
+level functions as well.
+
+An example of such an SoC is K2G, which contains the system control hardware
+block called Power Management Micro Controller (PMMC). This hardware block is
+initialized early into boot process and provides services to Operating Systems
+on multiple processors including ones running Linux.
+
+See http://processors.wiki.ti.com/index.php/TISCI for protocol definition.
+
+TI-SCI controller Device Node:
+=============================
+
+The TI-SCI node describes the Texas Instrument's System Controller entity node.
+This parent node may optionally have additional children nodes which describe
+specific functionality such as clocks, power domain, reset or additional
+functionality as may be required for the SoC. This hierarchy also describes the
+relationship between the TI-SCI parent node to the child node.
+
+Required properties:
+-------------------
+- compatible: should be "ti,k2g-sci"
+- mbox-names:
+	"rx" - Mailbox corresponding to receive path
+	"tx" - Mailbox corresponding to transmit path
+
+- mboxes: Mailboxes corresponding to the mbox-names. Each value of the mboxes
+	  property should contain a phandle to the mailbox controller device
+	  node and an args specifier that will be the phandle to the intended
+	  sub-mailbox child node to be used for communication.
+
+See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
+about the generic mailbox controller and client driver bindings. Also see
+Documentation/devicetree/bindings/mailbox/ti,message-manager.txt for typical
+controller that is used to communicate with this System controllers.
+
+Optional Properties:
+-------------------
+- reg-names:
+	debug_messages - Map the Debug message region
+- reg:  register space corresponding to the debug_messages
+- ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
+
+Example (K2G):
+-------------
+	pmmc: pmmc {
+		compatible = "ti,k2g-sci";
+		mbox-names = "rx", "tx";
+		mboxes= <&msgmgr &msgmgr_proxy_pmmc_rx>,
+			<&msgmgr &msgmgr_proxy_pmmc_tx>;
+		reg-names = "debug_messages";
+		reg = <0x02921800 0x800>;
+	};
+
+
+TI-SCI Client Device Node:
+=========================
+
+Client nodes are maintained as children of the relevant TI-SCI device node.
+
+Example (K2G):
+-------------
+	pmmc: pmmc {
+		compatible = "ti,k2g-sci";
+		...
+
+		my_clk_node: clk_node {
+			...
+			...
+		};
+
+		my_pd_node: pd_node {
+			...
+			...
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7e0064..2bafadf5747a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11883,6 +11883,14 @@ S:	Maintained
 F:	arch/xtensa/
 F:	drivers/irqchip/irq-xtensa-*
 
+Texas Instruments' System Control Interface (TISCI) Protocol Driver
+M:	Nishanth Menon <nm@ti.com>
+M:	Tero Kristo <t-kristo@ti.com>
+M:	Santosh Shilimkar <ssantosh@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
2.10.0

