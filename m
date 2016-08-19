From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/5] Documentation: Add support for TI System Control Interface (TI-SCI) protocol
Date: Fri, 19 Aug 2016 17:51:55 -0500
Message-ID: <20160819225159.10758-2-nm@ti.com>
References: <20160819225159.10758-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160819225159.10758-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Russ Dill <Russ.Dill@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Andrew F . Davis" <afd@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

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
---
Santosh: I have taken the liberty of adding you as one of the
maintainers for TISCI - if that is ok with you to merge up the chain.

 .../devicetree/bindings/arm/keystone/ti,sci.txt    | 65 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
new file mode 100644
index 000000000000..965d45e313b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
@@ -0,0 +1,65 @@
+Texas Instruments System Control Interface (TI-SCI) Message Protocol
+-------------------------------------------------------------------
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
+Required properties:
+--------------------
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
+--------------------
+- reg-names:
+	debug_messages - Map the Debug message region
+- reg:  register space corresponding to the debug_messages
+
+Example (K2G):
+--------
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
+========================
+
+Client nodes refer to the required TI-SCI device using the "ti,sci" property.
+
+Example (K2G):
+-------------
+	my_dev_node: dev_node {
+		...
+		ti,sci = <&pmmc>;
+		...
+	}
diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d00098c..ce7306897ae0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11564,6 +11564,14 @@ S:	Maintained
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
2.9.1.200.gb1ec08f
