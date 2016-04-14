From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V3 1/2] thermal: generic-adc: Add DT binding for ADC based thermal sensor
Date: Thu, 14 Apr 2016 20:11:17 +0530
Message-ID: <1460644878-19943-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1722 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbcDNOwp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2016 10:52:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh@kernel.org, edubezval@gmail.com, rui.zhang@intel.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org, Laxman Dewangan <ldewangan@nvidia.com>

Sometimes, thermal sensors like NCT thermistors are connected to
the ADC channel. The temperature is read by reading the voltage
across the sensor resistance via ADC and referring the lookup
table for ADC value to temperature.

Add DT binding doc for the ADC based thermal sensor driver to
detail the DT property and provide the example for how to use it.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from V1:
- Make the lookup table to two dimensional instead of single array of linear
  step of temperature.
- Remove detailing of IIO frameowrk and drivers.
- Added proper braces, indenting and labels.

Changes from V2:
- Handle comment from Rob for detailing the first and second value of the array
  and remove @ in the node name.

 .../bindings/thermal/thermal-generic-adc.txt       | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt

diff --git a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
new file mode 100644
index 0000000..d7235550
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
@@ -0,0 +1,89 @@
+General Purpose Analog To Digital Converter (ADC) based thermal sensor.
+
+On some of platforms, thermal sensor like thermistors are connected to
+one of ADC channel and sensor resistance is read via voltage across the
+sensor resistor. The voltage read across the sensor is mapped to
+temperature using voltage-temperature lookup table.
+
+Required properties:
+===================
+- compatible:		     Must be "generic-adc-thermal".
+- temperature-lookup-table:  Two dimensional array of Integer; lookup table
+			     to map the relation between ADC value and
+			     temperature. When ADC is read, the value is
+			     looked up on the table to get the equivalent
+			     temperature.
+			     The first value of the each row of array is the
+			     temperature in milliCelsius and second value of
+			     the each row of array is the ADC read value.
+- #thermal-sensor-cells:     Should be 1. See ./thermal.txt for a description
+			     of this property.
+
+Example :
+#include <dt-bindings/thermal/thermal.h>
+
+i2c@7000c400 {
+	ads1015: ads1015@4a {
+		reg = <0x4a>;
+		compatible = "ads1015";
+		sampling-frequency = <3300>;
+		#io-channel-cells = <1>;
+	};
+};
+
+tboard_thermistor: thermal-sensor {
+	compatible = "generic-adc-thermal";
+	#thermal-sensor-cells = <0>;
+	io-channels = <&ads1015 1>;
+	io-channel-names = "sensor-channel";
+	temperature-lookup-table = <    (-40000) 2578
+					(-39000) 2577
+					(-38000) 2576
+					(-37000) 2575
+					(-36000) 2574
+					(-35000) 2573
+					(-34000) 2572
+					(-33000) 2571
+					(-32000) 2569
+					(-31000) 2568
+					(-30000) 2567
+					::::::::::
+					118000 254
+					119000 247
+					120000 240
+					121000 233
+					122000 226
+					123000 220
+					124000 214
+					125000 208>;
+};
+
+dummy_cool_dev: dummy-cool-dev {
+	compatible = "dummy-cooling-dev";
+	#cooling-cells = <2>; /* min followed by max */
+};
+
+thermal-zones {
+	Tboard {
+		polling-delay = <15000>; /* milliseconds */
+		polling-delay-passive = <0>; /* milliseconds */
+		thermal-sensors = <&tboard_thermistor>;
+
+		trips {
+			therm_est_trip: therm_est_trip {
+				temperature = <40000>;
+				type = "active";
+				hysteresis = <1000>;
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&therm_est_trip>;
+				cooling-device = <&dummy_cool_dev THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				contribution = <100>;
+			};
+
+		};
+	};
+};
-- 
2.1.4

