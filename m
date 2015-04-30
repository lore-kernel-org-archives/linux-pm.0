From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 30 Apr 2015 17:37:59 +0530
Message-ID: <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1430394884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1430394884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1430394884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Sudeep.Holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viswanath.puttagunta-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ta.omasab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Current OPP (Operating performance point) DT bindings are proven to be
insufficient at multiple instances.

The shortcomings we are trying to solve here:

- Getting clock sharing information between CPUs. Single shared clock vs
  independent clock per core vs shared clock per cluster.

- Support for specifying current levels along with voltages.

- Support for multiple regulators.

- Support for turbo modes.

- Other per OPP settings: transition latencies, disabled status, etc.?

- Expandability of OPPs in future.

This patch introduces new bindings "operating-points-v2" to get these problems
solved. Refer to the bindings for more details.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 366 +++++++++++++++++++++++-
 1 file changed, 362 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 74499e5033fc..3b67a5c8d965 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -1,8 +1,366 @@
-* Generic OPP Interface
+Generic OPP (Operating Performance Points) Bindings
+----------------------------------------------------
 
-SoCs have a standard set of tuples consisting of frequency and
-voltage pairs that the device will support per voltage domain. These
-are called Operating Performance Points or OPPs.
+Devices work at voltage-current-frequency triplets and some implementations have
+the liberty of choosing these. These triplets are called Operating Performance
+Points aka OPPs. This document defines bindings for these OPPs applicable across
+wide range of devices. For illustration purpose, this document uses CPU as a
+device.
+
+
+* Property: operating-points-v2
+
+Devices supporting OPPs must set their "operating-points-v2" property with
+phandle to a OPP descriptor in their DT node. The OPP core will use this phandle
+to find the operating points for the device.
+
+
+* OPP Descriptor Node
+
+This describes the OPPs belonging to a device. This node can have following
+properties:
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2".
+- OPP nodes: One or more OPP nodes describing voltage-current-frequency
+  triplets. Their name isn't significant but their phandle can be used to
+  reference an OPP.
+
+Optional properties:
+- shared-opp: Indicates that device nodes using this OPP descriptor's phandle
+  switch their DVFS state together, i.e. they share clock/voltage/current lines.
+  Missing property means devices have independent clock/voltage/current lines,
+  but they share OPP tables.
+
+
+* OPP Node
+
+This defines voltage-current-frequency triplets along with other related
+properties.
+
+Required properties:
+- opp-khz: Frequency in kHz
+
+Optional properties:
+- opp-microvolt: voltage in micro Volts. It can contain entries for multiple
+  regulators.
+
+  A single regulator's voltage is specified with an array of size one or three.
+  Single entry is for target voltage and three entries are for <target min max>
+  voltages.
+
+  Entries for multiple regulators must be present in the same order as
+  regulators are specified in device's DT node.
+
+- opp-microamp: current in micro Amperes. It can contain entries for multiple
+  regulators.
+
+  A single regulator's current is specified with an array of size one or three.
+  Single entry is for target current and three entries are for <target min max>
+  currents.
+
+  Entries for multiple regulators must be present in the same order as
+  regulators are specified in device's DT node. If few regulators don't provide
+  capability to configure current, then values for then should be marked as
+  zero.
+
+- clock-latency-ns: Specifies the maximum possible transition latency (in
+  nanoseconds) for switching to this OPP from any other OPP.
+- turbo-mode: Marks the OPP to be used only for turbo modes.
+- status: Marks the node enabled/disabled.
+
+Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+	};
+
+	cpu0_opp: opp0 {
+		compatible = "operating-points-v2";
+		shared-opp;
+
+		entry00 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000 975000 985000>;
+			opp-microamp = <70000 75000 85000>;
+			clock-latency-ns = <300000>;
+		};
+		entry01 {
+			opp-khz = <1100000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			opp-microamp = <80000 81000 82000>;
+			clock-latency-ns = <310000>;
+		};
+		entry02 {
+			opp-khz = <1200000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <290000>;
+			turbo-mode;
+		};
+	};
+};
+
+Example 2: Single cluster, Quad-core Qualcom-krait, switches DVFS states
+independently.
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "qcom,krait";
+			reg = <0>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+
+		cpu@1 {
+			compatible = "qcom,krait";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+
+		cpu@2 {
+			compatible = "qcom,krait";
+			reg = <2>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 2>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply2>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+
+		cpu@3 {
+			compatible = "qcom,krait";
+			reg = <3>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 3>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply3>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+	};
+
+	cpu0_opp: opp0 {
+		compatible = "operating-points-v2";
+
+		/*
+		 * Missing shared-opp property means CPUs switch DVFS states
+		 * independently.
+		 */
+
+		entry00 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000 975000 985000>;
+			opp-microamp = <70000 75000 85000>;
+			clock-latency-ns = <300000>;
+		};
+		entry01 {
+			opp-khz = <1100000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			opp-microamp = <80000 81000 82000>;
+			clock-latency-ns = <310000>;
+		};
+		entry02 {
+			opp-khz = <1200000>;
+			opp-microvolt = <1025000>;
+			opp-microamp = <90000;
+			lock-latency-ns = <290000>;
+			turbo-mode;
+		};
+	};
+};
+
+Example 3: Dual-cluster, Dual-core per cluster. CPUs within a cluster switch
+DVFS state together.
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu@100 {
+			compatible = "arm,cortex-a15";
+			reg = <100>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cluster1_opp>;
+		};
+
+		cpu@101 {
+			compatible = "arm,cortex-a15";
+			reg = <101>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cluster1_opp>;
+		};
+	};
+
+	cluster0_opp: opp0 {
+		compatible = "operating-points-v2";
+		shared-opp;
+
+		entry00 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000 975000 985000>;
+			opp-microamp = <70000 75000 85000>;
+			clock-latency-ns = <300000>;
+		};
+		entry01 {
+			opp-khz = <1100000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			opp-microamp = <80000 81000 82000>;
+			clock-latency-ns = <310000>;
+		};
+		entry02 {
+			opp-khz = <1200000>;
+			opp-microvolt = <1025000>;
+			opp-microamp = <90000>;
+			clock-latency-ns = <290000>;
+			turbo-mode;
+		};
+	};
+
+	cluster1_opp: opp1 {
+		compatible = "operating-points-v2";
+		shared-opp;
+
+		entry10 {
+			opp-khz = <1300000>;
+			opp-microvolt = <1045000 1050000 1055000>;
+			opp-microamp = <95000 100000 105000>;
+			clock-latency-ns = <400000>;
+		};
+		entry11 {
+			opp-khz = <1400000>;
+			opp-microvolt = <1075000>;
+			opp-microamp = <100000>;
+			clock-latency-ns = <400000>;
+		};
+		entry12 {
+			opp-khz = <1500000>;
+			opp-microvolt = <1010000 1100000 1110000>;
+			opp-microamp = <95000 100000 105000>;
+			clock-latency-ns = <400000>;
+			turbo-mode;
+		};
+	};
+};
+
+Example 4: Handling multiple regulators
+
+/ {
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a7";
+			...
+
+			opp-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+	};
+
+	cpu0_opp: opp0 {
+		compatible = "operating-points-v2";
+		shared-opp;
+
+		entry00 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000>, /* Supply 0 */
+					<960000>, /* Supply 1 */
+					<960000>; /* Supply 2 */
+			opp-microamp =  <70000>,  /* Supply 0 */
+					<70000>,  /* Supply 1 */
+					<70000>;  /* Supply 2 */
+			clock-latency-ns = <300000>;
+		};
+
+		/* OR */
+
+		entry00 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
+					<960000 965000 975000>, /* Supply 1 */
+					<960000 965000 975000>; /* Supply 2 */
+			opp-microamp =  <70000  75000  85000>,  /* Supply 0 */
+					<70000  75000  85000>,  /* Supply 1 */
+					<70000  75000  85000>;  /* Supply 2 */
+			clock-latency-ns = <300000>;
+		};
+
+		/* OR */
+
+		entry00 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
+					<960000 965000 975000>, /* Supply 1 */
+					<960000 965000 975000>; /* Supply 2 */
+			opp-microamp =  <70000  75000  85000>,  /* Supply 0 */
+					<0	0      0>,	/* Supply 1 doesn't support current change */
+					<70000  75000  85000>;  /* Supply 2 */
+			clock-latency-ns = <300000>;
+		};
+	};
+};
+
+
+Deprecated Bindings
+-------------------
 
 Properties:
 - operating-points: An array of 2-tuples items, and each item consists
-- 
2.3.0.rc0.44.ga94655d

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
