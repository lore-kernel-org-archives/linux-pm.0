From: Talel Shenhar <talel@amazon.com>
Subject: [PATCH 1/2] dt-bindings: thermal: thermal_mmio: Add binding documentation
Date: Sun, 3 Mar 2019 10:49:25 +0200
Message-ID: <1551602966-2334-2-git-send-email-talel@amazon.com>
References: <1551602966-2334-1-git-send-email-talel@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551602966-2334-1-git-send-email-talel@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com, ronenk@amazon.com, hanochu@amazon.com
List-Id: linux-pm@vger.kernel.org

Add thermal binding documentation for thermal MMIO driver.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 .../devicetree/bindings/thermal/thermal_mmio.txt   | 173 +++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal_mmio.txt

diff --git a/Documentation/devicetree/bindings/thermal/thermal_mmio.txt b/Documentation/devicetree/bindings/thermal/thermal_mmio.txt
new file mode 100644
index 0000000..1f4d738
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal_mmio.txt
@@ -0,0 +1,173 @@
+Generic Thermal MMIO Driver
+
+The generic thermal driver enables easy connectivity between "simple"
+thermal HW devices to the thermal subsystem. "simple" - thermal HW that
+doesn't need any configuration (such as power reset or clock enable) by a
+driver and only exports the temperature via simple MMIO access, or,
+alternatively, all the configuration is done by other entity (e.g.
+bootloader).
+
+Any system that allows temperature reading via a single memory map read, be
+it register or shared memory, is a potential candidate to work with this
+driver.
+This driver allows manipulations on the read value in order to allow some
+flexibility for the various thermal HW, e.g. sensor-factor which will be
+multiplied by the read value.
+
+This driver is most suitable for cases such as the following:
+- The entire thermal HW setup (e.g. configure the thermal HW to work in
+  continuous mode) is done by another SW entity (e.g. bootloader) and all
+  that is left is to read the current temperature from a register
+- The thermal reading is done by an external CPU (e.g. micro-controller)
+  and that CPU is exporting the reading via a shared memory
+- The thermal HW setup and reading is done via CPLD, which exports the
+  current temperature to the system via a register
+- The thermal HW is working out-of-the-box and only reports temperature via
+  a single register access
+
+Some examples for cases that this driver is not suitable for:
+- Your HW need clock enabling to be done by thermal driver
+- Your HW need some registers configurations in order to start reporting
+  temperatures and it is not doable by other entities (e.g. bootloader)
+- Your HW allows reading of temperatures only between ADCs (or any other
+  timing constrains)
+- In case your HW was configured by a bootloader and it lose the
+  configuration as part of low-power-state and need to be reconfigured.
+  (bootloader configuration typically is not sustained across low power
+  states)
+- In case the reading from the MMIO require any type of locking
+
+So the only operation this driver will do is MMIO read for the temperature.
+In case you are using HW that require some configurations this driver is
+not suitable (you can decide to move all the configuration logic into your
+bootloader and only leave the temperature reading to this driver but this
+is up to you).
+
+An example of a system that uses this driver is the Amazon Nitro SoC in
+which there is the main CPU and micro-controller:
+(1) The micro-controller accesses an SBUS controller to read the thermal
+    sensor from an SBUS slave called Avago Technologies digital
+    Temperature/Voltage Sensor (ip16_SENS_thermvolt25_0)
+(2) Once the micro-controller gathers the temperature it relays it to the
+    main CPU via a Shared Integrated RAM which is MMIO accessible by the CPU
+(3) The thermal_mmio driver that runs on the main CPU will read the
+    temperature via an MMIO access to the Shared RAM
+
++------------------+      +----------------+
+|                  | (3)  |                |
+|     Main CPU     +----->+ Integrated RAM |
+|                  |      |                |
++------------------+      +---------^------+
+                                    |(2)
++-----------------+       +------------------+
+|                 |  (1)  |                  |
+| SBUS controller <-------+ micro-controller |
+|                 |       |                  |
++--------+--------+       +------------------+
+         |
++--------v---------------------+
+|                              |
+|  Avago Technologies digital  |
+|  Temperature/Voltage Sensor  |
+|  (ip16_SENS_thermvolt25_0)   |
+|                              |
++------------------------------+
+
+Required properties:
+- compatible: "thermal-mmio".
+- reg: The physical base address and length of the sensor's registers.
+- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a description.
+
+Optional properties:
+- sensor-width: Width (in bytes) of each consecutive sensor.
+		 Supported: 1, 2, 4.
+		 (Default = 4)
+- sensor-mask: Mask to be applied on the raw read value before any
+	       calculation.
+	       (Default = 0xFFFFFFFF)
+- sensor-factor: Scale value by which to multiple the masked read value
+		 This is a signed 32 bit value.
+		 (Default = 1)
+- sensor-bias: Bias value to be added to the scaled value.
+	       This is a signed 32 bit value.
+	       (Default = 0)
+- sensor-divider: Dividing value by which to divide the calculated value.
+		  Diving will be Integer Division.
+		  This is a unsigned 32 bit value.
+		  (Default = 1)
+
+Conversion formula from HW MMIO read value to millidegrees (Celsius):
+T_millidegrees = (bias + (T_raw & mask)*factor)/divider
+
+Example 1, two thermal devices with one thermal sensor each, that uses only
+the required properties (uses default):
+
+	thermal_d1: thermal_d1 {
+		compatible = "thermal-mmio";
+		reg = <0x0 0x05002860 0x0 0x4>;
+		#thermal-sensor-cells = <0x1>;
+	};
+
+	thermal_d2: thermal_d2 {
+		compatible = "thermal-mmio";
+		reg = <0x0 0x05000730 0x0 0x4>;
+		#thermal-sensor-cells = <0x1>;
+	};
+
+	thermal-zones {
+		thermal_d1_z0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&thermal_d1 0>;
+			trips {
+				thermal_d1_z0_crit {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+		};
+
+		thermal_d2_z0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&thermal_d2 0>;
+			trips {
+				thermal_d2_z0_crit {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
+Example 2, one thermal device with two sensors of 6 bits each each, that
+has a factor of -5, bias of 23 and dividing of 2:
+
+	thermal_d3: thermal_d3 {
+		compatible = "thermal-mmio";
+		reg = <0x0 0x05005700 0x0 0x2>;
+		#thermal-sensor-cells = <0x1>;
+		sensor-width = <1>;
+		sensor-mask = <0x3F>;
+		sensor-factor = <(-5)>;
+		sensor-bias = <23>;
+		sensor-divider = <2>;
+	};
+
+	thermal-zones {
+		thermal_d3 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&thermal_d3 0>;
+			trips {
+				thermal_d3_z0_crit {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
-- 
2.7.4
