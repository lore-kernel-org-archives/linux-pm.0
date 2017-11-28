From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 06/13] dt-bindings: power: reset: Document ocelot-reset binding
Date: Tue, 28 Nov 2017 16:26:36 +0100
Message-ID: <20171128152643.20463-7-alexandre.belloni@free-electrons.com>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add binding documentation for the Microsemi Ocelot reset block.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org

 .../bindings/power/reset/ocelot-reset.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt

diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
new file mode 100644
index 000000000000..2d3f2c21fadd
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
@@ -0,0 +1,24 @@
+Microsemi Ocelot reset driver
+
+The DEVCPU_GCB:CHIP_REGS have a SOFT_RST register that can be used to reset the
+SoC MIPS core.
+
+Required Properties:
+ - compatible: "mscc,ocelot-chip-reset"
+ - mscc,cpucontrol: phandle to the CPU system control syscon block
+
+Example:
+		cpu_ctrl: syscon@70000000 {
+			compatible = "syscon";
+			reg = <0x70000000 0x2c>;
+		};
+
+		syscon@71070000 {
+			compatible = "simple-mfd", "syscon";
+			reg = <0x71070000 0x1c>;
+
+			reset {
+				compatible = "mscc,ocelot-chip-reset";
+				mscc,cpucontrol = <&cpu_ctrl>;
+			};
+		};
-- 
2.15.0
