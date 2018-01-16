From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 2/8] dt-bindings: power: reset: Document ocelot-reset binding
Date: Tue, 16 Jan 2018 11:12:34 +0100
Message-ID: <20180116101240.5393-3-alexandre.belloni@free-electrons.com>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add binding documentation for the Microsemi Ocelot reset block.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/power/reset/ocelot-reset.txt       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt

diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
new file mode 100644
index 000000000000..1b4213eb3473
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
@@ -0,0 +1,14 @@
+Microsemi Ocelot reset controller
+
+The DEVCPU_GCB:CHIP_REGS have a SOFT_RST register that can be used to reset the
+SoC MIPS core.
+
+Required Properties:
+ - compatible: "mscc,ocelot-chip-reset"
+
+Example:
+	reset@1070008 {
+		compatible = "mscc,ocelot-chip-reset";
+		reg = <0x1070008 0x4>;
+	};
+
-- 
2.15.1
