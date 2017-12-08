From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 07/13] dt-bindings: power: reset: Document ocelot-reset binding
Date: Fri,  8 Dec 2017 16:46:12 +0100
Message-ID: <20171208154618.20105-8-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46824 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754337AbdLHPrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Dec 2017 10:47:46 -0500
In-Reply-To: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org

Add binding documentation for the Microsemi Ocelot reset block.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/power/reset/ocelot-reset.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt

diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
new file mode 100644
index 000000000000..1bcf276b04cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
@@ -0,0 +1,17 @@
+Microsemi Ocelot reset controller
+
+The DEVCPU_GCB:CHIP_REGS have a SOFT_RST register that can be used to reset the
+SoC MIPS core.
+
+Required Properties:
+ - compatible: "mscc,ocelot-chip-reset"
+
+Example:
+	syscon@71070000 {
+		compatible = "mscc,ocelot-chip-regs", "simple-mfd", "syscon";
+		reg = <0x71070000 0x1c>;
+
+		reset {
+			compatible = "mscc,ocelot-chip-reset";
+		};
+	};
-- 
2.15.1
