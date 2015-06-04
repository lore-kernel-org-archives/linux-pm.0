From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V7 1/3] OPP: Add new bindings to address shortcomings of existing bindings
Date: Thu,  4 Jun 2015 21:50:31 +0530
Message-ID: <d83c0b6b1768c7229384216329b607d13886aa02.1433434659.git.viresh.kumar@linaro.org>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1433434659.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1433434659.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1433434659.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Sudeep.Holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viswanath.puttagunta-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ta.omasab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Current OPP (Operating performance point) device tree bindings have been
insufficient due to the inflexible nature of the original bindings. Over
time, we have realized that Operating Performance Point definitions and
usage is varied depending on the SoC and a "single size (just frequency,
voltage) fits all" model which the original bindings attempted and
failed.

The proposed next generation of the bindings addresses by providing a
expandable binding for OPPs and introduces the following common
shortcomings seen with the original bindings:

- Getting clock/voltage/current rails sharing information between CPUs.
  Shared by all cores vs independent clock per core vs shared clock per
  cluster.

- Support for specifying current levels along with voltages.

- Support for multiple regulators.

- Support for turbo modes.

- Other per OPP settings: transition latencies, disabled status, etc.?

- Expandability of OPPs in future.

This patch introduces new bindings "operating-points-v2" to get these problems
solved. Refer to the bindings for more details.

We now have multiple versions of OPP binding and only one of them should
be used per device.

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 381 +++++++++++++++++++++++-
 1 file changed, 377 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 74499e5033fc..259bf00edf7d 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -1,8 +1,19 @@
-* Generic OPP Interface
+Generic OPP (Operating Performance Points) Bindings
+----------------------------------------------------
 
-SoCs have a standard set of tuples consisting of frequency and
-voltage pairs that the device will support per voltage domain. These
-are called Operating Performance Points or OPPs.
+Devices work at voltage-current-frequency combinations and some implementations
+have the liberty of choosing these. These combinations are called Operating
+Performance Points aka OPPs. This document defines bindings for these OPPs
+applicable across wide range of devices. For illustration purpose, this document
+uses CPU as a device.
+
+This document contain multiple versions of OPP binding and only one of them
+should be used per device.
+
+Binding 1: operating-points
+============================
+
+This binding only supports voltage-frequency pairs.
 
 Properties:
 - operating-points: An array of 2-tuples items, and each item consists
@@ -23,3 +34,365 @@ cpu@0 {
 		198000  850000
 	>;
 };
+
+
+Binding 2: operating-points-v2
+============================
+
+* Property: operating-points-v2
+
+Devices supporting OPPs must set their "operating-points-v2" property with
+phandle to a OPP table in their DT node. The OPP core will use this phandle to
+find the operating points for the device.
+
+If required, this can be extended for SoC vendor specfic bindings. Such bindings
+should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
+and should have a compatible description like: "operating-points-v2-<vendor>".
+
+* OPP Table Node
+
+This describes the OPPs belonging to a device. This node can have following
+properties:
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2".
+
+- OPP nodes: One or more OPP nodes describing voltage-current-frequency
+  combinations. Their name isn't significant but their phandle can be used to
+  reference an OPP.
+
+Optional properties:
+- opp-shared: Indicates that device nodes using this OPP Table Node's phandle
+  switch their DVFS state together, i.e. they share clock/voltage/current lines.
+  Missing property means devices have independent clock/voltage/current lines,
+  but they share OPP tables.
+
+
+* OPP Node
+
+This defines voltage-current-frequency combinations along with other related
+properties.
+
+Required properties:
+- opp-hz: Frequency in Hz
+
+Optional properties:
+- opp-microvolt: voltage in micro Volts.
+
+  A single regulator's voltage is specified with an array of size one or three.
+  Single entry is for target voltage and three entries are for <target min max>
+  voltages.
+
+  Entries for multiple regulators must be present in the same order as
+  regulators are specified in device's DT node.
+
+- opp-microamp: The maximum current drawn by the device in microamperes
+  considering system specific parameters (such as transients, process, aging,
+  maximum operating temperature range etc.) as necessary. This may be used to
+  set the most efficient regulator operating mode.
+
+  Should only be set if opp-microvolt is set for the OPP.
+
+  Entries for multiple regulators must be present in the same order as
+  regulators are specified in device's DT node. If this property isn't required
+  for few regulators, then this should be marked as zero for them. If it isn't
+  required for any regulator, then this property need not be present.
+
+- clock-latency-ns: Specifies the maximum possible transition latency (in
+  nanoseconds) for switching to this OPP from any other OPP.
+
+- turbo-mode: Marks the OPP to be used only for turbo modes. Turbo mode is
+  available on some platforms, where the device can run over its operating
+  frequency for a short duration of time limited by the device's power, current
+  and thermal limits.
+
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
+			cpu-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			cpu-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = <1000000000>;
+			opp-microvolt = <970000 975000 985000>;
+			opp-microamp = <70000>;
+			clock-latency-ns = <300000>;
+		};
+		opp01 {
+			opp-hz = <1100000000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			opp-microamp = <80000>;
+			clock-latency-ns = <310000>;
+		};
+		opp02 {
+			opp-hz = <1200000000>;
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
+			cpu-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu_opp_table>;
+		};
+
+		cpu@1 {
+			compatible = "qcom,krait";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			cpu-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cpu_opp_table>;
+		};
+
+		cpu@2 {
+			compatible = "qcom,krait";
+			reg = <2>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 2>;
+			clock-names = "cpu";
+			cpu-supply = <&cpu_supply2>;
+			operating-points-v2 = <&cpu_opp_table>;
+		};
+
+		cpu@3 {
+			compatible = "qcom,krait";
+			reg = <3>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 3>;
+			clock-names = "cpu";
+			cpu-supply = <&cpu_supply3>;
+			operating-points-v2 = <&cpu_opp_table>;
+		};
+	};
+
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+
+		/*
+		 * Missing opp-shared property means CPUs switch DVFS states
+		 * independently.
+		 */
+
+		opp00 {
+			opp-hz = <1000000000>;
+			opp-microvolt = <970000 975000 985000>;
+			opp-microamp = <70000>;
+			clock-latency-ns = <300000>;
+		};
+		opp01 {
+			opp-hz = <1100000000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			opp-microamp = <80000>;
+			clock-latency-ns = <310000>;
+		};
+		opp02 {
+			opp-hz = <1200000000>;
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
+			cpu-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			cpu-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu@100 {
+			compatible = "arm,cortex-a15";
+			reg = <100>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			cpu-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cluster1_opp>;
+		};
+
+		cpu@101 {
+			compatible = "arm,cortex-a15";
+			reg = <101>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			cpu-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cluster1_opp>;
+		};
+	};
+
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = <1000000000>;
+			opp-microvolt = <970000 975000 985000>;
+			opp-microamp = <70000>;
+			clock-latency-ns = <300000>;
+		};
+		opp01 {
+			opp-hz = <1100000000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			opp-microamp = <80000>;
+			clock-latency-ns = <310000>;
+		};
+		opp02 {
+			opp-hz = <1200000000>;
+			opp-microvolt = <1025000>;
+			opp-microamp = <90000>;
+			clock-latency-ns = <290000>;
+			turbo-mode;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp10 {
+			opp-hz = <1300000000>;
+			opp-microvolt = <1045000 1050000 1055000>;
+			opp-microamp = <95000>;
+			clock-latency-ns = <400000>;
+		};
+		opp11 {
+			opp-hz = <1400000000>;
+			opp-microvolt = <1075000>;
+			opp-microamp = <100000>;
+			clock-latency-ns = <400000>;
+		};
+		opp12 {
+			opp-hz = <1500000000>;
+			opp-microvolt = <1010000 1100000 1110000>;
+			opp-microamp = <95000>;
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
+			cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = <1000000000>;
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
+		opp00 {
+			opp-hz = <1000000000>;
+			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
+					<960000 965000 975000>, /* Supply 1 */
+					<960000 965000 975000>; /* Supply 2 */
+			opp-microamp =  <70000>,		/* Supply 0 */
+					<70000>,		/* Supply 1 */
+					<70000>;		/* Supply 2 */
+			clock-latency-ns = <300000>;
+		};
+
+		/* OR */
+
+		opp00 {
+			opp-hz = <1000000000>;
+			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
+					<960000 965000 975000>, /* Supply 1 */
+					<960000 965000 975000>; /* Supply 2 */
+			opp-microamp =  <70000>,		/* Supply 0 */
+					<0>,			/* Supply 1 doesn't need this */
+					<70000>;		/* Supply 2 */
+			clock-latency-ns = <300000>;
+		};
+	};
+};
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
