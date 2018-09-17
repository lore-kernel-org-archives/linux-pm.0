From: Karsten Mueller <mueller.k@efe-gmbh.de>
Subject: [PATCH 2/3] dt-bindings: power: supply: bq2416x driver
Date: Mon, 17 Sep 2018 14:37:28 +0200
Message-ID: <20180917123729.23461-2-mueller.k@efe-gmbh.de>
References: <20180917123729.23461-1-mueller.k@efe-gmbh.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917123729.23461-1-mueller.k@efe-gmbh.de>
Sender: linux-kernel-owner@vger.kernel.org
To: mueller.k@efe-gmbh.de
Cc: renner@efe-gmbh.de, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Karsten Mueller <mueller.k@efe-gmbh.de>
---
 .../bindings/power/supply/bq2416x.txt         | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2416x.txt

diff --git a/Documentation/devicetree/bindings/power/supply/bq2416x.txt b/Documentation/devicetree/bindings/power/supply/bq2416x.txt
new file mode 100644
index 000000000..742d41642
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2416x.txt
@@ -0,0 +1,75 @@
+Binding for TI bq2416x Li-Ion Charger
+
+Required properties:
+====================
+- compatible: one of the following:
+ * "ti,bq24160"
+ * "ti,bq24160a"
+ * "ti,bq24161"
+ * "ti,bq24161b"
+ * "ti,bq24163"
+ * "ti,bq24168"
+
+- reg:			I2C address of the device.
+- interrupt-parent:	The IRQ controller (phandle) connected to the INT pin of
+			the bq2416x
+- interrupts:		The IRQ number assigned for INT pin.
+
+Optional properties:
+====================
+
+- ti,in-current-limit-microamp:	IN source current limit.
+	Possible values: 1500000 (default), 2500000
+
+- ti,usb-current-limit-microamp: USB source current limit.
+	If not specified, auto detection of USB (D+/D- based) is used (for
+	BQ24160/0A/3 only) or settings of default mode are kept (BQ24161/1B/8).
+	Both pre-select only 100 mA or 1500 mA (refer to datasheet).
+	Possible values: 100000, 150000, 500000, 800000, 90000, 1500000
+
+- ti,usb-dpm-voltage-microvolt:	USB threshold for dynamic power path management.
+	Configures the threshold input voltage (usb input) for the dynamic power
+	path management. If not specified a default of 4,200,000 (= 4.2V) is
+	used.
+
+- ti,in-dpm-voltage-microvolt: IN threshold for dynamic power path management.
+	Configures the threshold input voltage (in input) for the dynamic power
+	path management. If not specified a default of 4,200,000 (= 4.2V) is
+	used.
+
+- monitored-battery: phandle of battery information devicetree node
+	If not specified, no battery is assumed (charge disable, nobat operation
+	mode, no NTC check of battery), Vsys output voltage is set to 4.2V. The
+	charger uses the following battery properties:
+	+ constant_charge_current_max_microamp: maximum current in fast charge
+	  mode
+	+ constant_charge_voltage_max_microvolt: maximum constant charging
+	  voltage / output voltage (refer to datasheet)
+	+ charge-term-current-microamp: a charge cycle terminates when the
+	  battery voltage is above recharge threshold, and the current is below
+	  this setting (typically 10% of battery capacity). If not specified,
+	  termination of current detection is disabled (refer to datasheet).
+
+Example:
+========
+
+bat: battery {
+		compatible = "simple-battery";
+		charge-term-current-microamp = <128000>;
+		constant-charge-current-max-microamp = <900000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+	};
+
+bq24160@6b {
+	compatible = "ti,bq24160";
+	reg = <0x6b>;
+
+	interrupt-parent = <&gpio5>;
+	interrupts = <31 IRQ_TYPE_EDGE_RISING>;
+
+	monitored-battery = <&bat>;
+	ti,in-current-limit-microamp = <1500000>;
+	ti,usb-current-limit-microamp = <500000>;
+	ti,usb-dpm-voltage-microvolt = <4300000>;
+	ti,in-dpm-voltage-microvolt = <4300000>;
+};
-- 
2.17.1
