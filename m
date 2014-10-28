From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] Add devicetree binding documentation for the LTC2941/LTC2943 driver
Date: Tue, 28 Oct 2014 08:08:04 +0100
Message-ID: <1414480084-3604-1-git-send-email-mike.looijmans@topic.nl>
References: <20141027163842.GB20765@earth.universe>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141027163842.GB20765@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, devicetree@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
List-Id: linux-pm@vger.kernel.org

This adds the devicetree binding documentation for the LTC2941 and LTC2943
driver. These are I2C connected battery gas gauge ICs.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 .../devicetree/bindings/power/ltc2941.txt          |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/ltc2941.txt

diff --git a/Documentation/devicetree/bindings/power/ltc2941.txt b/Documentation/devicetree/bindings/power/ltc2941.txt
new file mode 100644
index 0000000..ea42ae1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/ltc2941.txt
@@ -0,0 +1,27 @@
+binding for LTC2941 and LTC2943 battery gauges
+
+Both the LTC2941 and LTC2943 measure battery capacity.
+The LTC2943 is compatible with the LTC2941, it adds voltage and
+temperature monitoring, and uses a slightly different conversion
+formula for the charge counter.
+
+Required properties:
+- compatible: Should contain "ltc2941" or "ltc2943" which also indicates the
+    type of I2C chip attached.
+- reg: The 7-bit I2C address.
+- lltc,resistor-sense: The sense resistor value in milli-ohms. Can be a 32-bit
+    negative value when the battery has been connected to the wrong end of the
+    resistor.
+- lltc,prescaler-exponent: The prescaler exponent as explained in the datasheet.
+    This determines the range and accuracy of the gauge. The value is programmed
+    into the chip only if it differs from the current setting. The setting is
+    lost when the battery is disconnected.
+
+Example from the Topic Miami Florida board:
+
+	fuelgauge: ltc2943@64 {
+		compatible = "ltc2943";
+		reg = <0x64>;
+		lltc,resistor-sense = <15>;
+		lltc,prescaler-exponent = <5>; /* 2^(2*5) = 1024 */
+	};
-- 
1.7.9.5
