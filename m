From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 16 Sep 2015 10:03:28 +0530
Message-ID: <20150916043328.GA29943@linux>
References: <20150909062722.GA5266@linux>
 <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux>
 <20150909133930.GE3260@x1>
 <20150909160212.GJ5266@linux>
 <20150909163620.GF3260@x1>
 <55F0C5AB.5060609@kernel.org>
 <20150910005722.GA15099@codeaurora.org>
 <20150910010426.GM5266@linux>
 <20150910083146.GG3260@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150910083146.GG3260@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 10-09-15, 09:31, Lee Jones wrote:
> I think you answered your own question.
> 
> No users == !ABI == Strip it out.

Okay, as I have delayed things enough for you, didn't wanted to do
that anymore. And so worked on it despite very tight schedule :)

Below is the refreshed binding changes (I have split that into 3
patches, but kept the diff here for simplicity).

Other than that, all code changes you need to test your driver are
pushed here:

https://git.linaro.org/people/viresh.kumar/linux.git opp/supported-hw-prop-name-v1

I am not gonna post the patches to the lists, until the time existing
patches get reviewed.

-- 
viresh

-------------------------8<-------------------------
diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 719603b87353..b652d0403e93 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -45,21 +45,10 @@ Devices supporting OPPs must set their "operating-points-v2" property with
 phandle to a OPP table in their DT node. The OPP core will use this phandle to
 find the operating points for the device.
 
-Devices may want to choose OPP tables at runtime and so can provide a list of
-phandles here. But only *one* of them should be chosen at runtime. This must be
-accompanied by a corresponding "operating-points-names" property, to uniquely
-identify the OPP tables.
-
 If required, this can be extended for SoC vendor specfic bindings. Such bindings
 should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
 and should have a compatible description like: "operating-points-v2-<vendor>".
 
-Optional properties:
-- operating-points-names: Names of OPP tables (required if multiple OPP
-  tables are present), to uniquely identify them. The same list must be present
-  for all the CPUs which are sharing clock/voltage rails and hence the OPP
-  tables.
-
 * OPP Table Node
 
 This describes the OPPs belonging to a device. This node can have following
@@ -117,6 +106,14 @@ properties.
   Entries for multiple regulators must be present in the same order as their
   names are present in 'supply-names' property of the opp-table.
 
+- opp-microvolt-<name>: Named opp-microvolt property. This is exactly similar to
+  the above opp-microvolt property, but allows multiple voltage ranges to be
+  provided for the same OPP. At runtime, the platform can pick a <name> and
+  matching opp-microvolt-<name> property will be enabled for all OPPs. If the
+  platform doesn't pick a specific <name> or the <name> doesn't match with any
+  opp-microvolt-<name> properties, then opp-microvolt property shall be used, if
+  present.
+
 - opp-microamp: The maximum current drawn by the device in microamperes
   considering system specific parameters (such as transients, process, aging,
   maximum operating temperature range etc.) as necessary. This may be used to
@@ -131,6 +128,9 @@ properties.
   as zero for them. If it isn't required for any regulator, then this property
   need not be present.
 
+- opp-microamp-<name>: Named opp-microamp property. Similar to
+  opp-microvolt-<name> property, but for microamp instead.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
@@ -139,9 +139,27 @@ properties.
   frequency for a short duration of time limited by the device's power, current
   and thermal limits.
 
+- turbo-mode-<name>: Named turbo-mode property. Similar to opp-microvolt-<name>
+  property, but for turbo mode instead.
+
 - opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
   the table should have this.
 
+- opp-suspend-<name>: Named opp-suspend property. Similar to
+  opp-microvolt-<name> property, but for suspend opp instead.
+
+- opp-supported-hw: User defined array containing a hierarchy of hardware
+  version numbers, supported by the OPP. For example: a platform with hierarchy
+  of three levels of versions (A, B and C), this field should be like <X Y Z>,
+  where X corresponds to Version hierarchy A, Y corresponds to version hierarchy
+  B and Z corresponds to version hierarchy C.
+
+  Each level of hierarchy is represented by a 32 bit value, and so there can be
+  only 32 different supported version per hierarchy. i.e. 1 bit per version. A
+  value of 0xFFFFFFFF will enable the OPP for all versions for that hierarchy
+  level. And a value of 0x00000000 will disable the OPP completely, and so we
+  never want that to happen.
+
 - status: Marks the node enabled/disabled.
 
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
@@ -443,7 +461,8 @@ Example 4: Handling multiple regulators
 	};
 };
 
-Example 5: Multiple OPP tables
+Example 5: opp-supported-hw
+(example: three level hierarchy of versions: cuts, substrate and process)
 
 / {
 	cpus {
@@ -452,40 +471,84 @@ Example 5: Multiple OPP tables
 			...
 
 			cpu-supply = <&cpu_supply>
-			operating-points-v2 = <&cpu0_opp_table_slow>, <&cpu0_opp_table_fast>;
-			operating-points-names = "slow", "fast";
+			operating-points-v2 = <&cpu0_opp_table_slow>;
 		};
 	};
 
-	cpu0_opp_table_slow: opp_table_slow {
+	opp_table {
 		compatible = "operating-points-v2";
 		status = "okay";
 		opp-shared;
 
 		opp00 {
+			/*
+			 * Supports all substrate and process versions for 0xF
+			 * cuts, i.e. only first four cuts.
+			 */
+			opp-supported-hw = <0xF 0xFFFFFFFF 0xFFFFFFFF>
 			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000 915000 925000>;
 			...
 		};
 
 		opp01 {
+			/*
+			 * Supports:
+			 * - cuts: only one, 6th cut (represented by 6th bit).
+			 * - substrate: supports 16 different substrate versions
+			 * - process: supports 9 different process versions
+			 */
+			opp-supported-hw = <0x20 0xff0000ff 0x0000f4f0>
 			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000 915000 925000>;
 			...
 		};
 	};
+};
+
+Example 6: opp-microvolt-<name>, opp-microamp-<name>, turbo-mode-<name>,
+opp-suspend-<name>:
+(example: device with 2 supplies: vcc0 and vcc1, with two possible ranges: slow
+and fast)
+
+/ {
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a7";
+			...
 
-	cpu0_opp_table_fast: opp_table_fast {
+			vcc0-supply = <&cpu_supply0>;
+			vcc1-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
 		compatible = "operating-points-v2";
-		status = "okay";
+		supply-names = "vcc0", "vcc1";
 		opp-shared;
 
-		opp10 {
+		opp00 {
 			opp-hz = /bits/ 64 <1000000000>;
-			...
+			opp-microvolt-slow = <900000 915000 925000>, /* Supply vcc0 */
+					      <910000 925000 935000>; /* Supply vcc1 */
+			opp-microvolt-fast = <970000 975000 985000>, /* Supply vcc0 */
+					     <960000 965000 975000>; /* Supply vcc1 */
+			opp-microamp-slow =  <70000>;
+			opp-microamp-fast =  <71000>;
+			turbo-mode-slow; /* Will marked as turbo only if 'slow' is chosen */
+			opp-suspend-slow; /* Will marked as suspend-opp only if 'slow' is chosen */
 		};
 
-		opp11 {
-			opp-hz = /bits/ 64 <1100000000>;
-			...
+		opp01 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-slow = <900000 915000 925000>, /* Supply vcc0 */
+					      <910000 925000 935000>; /* Supply vcc1 */
+			opp-microvolt-fast = <970000 975000 985000>, /* Supply vcc0 */
+					     <960000 965000 975000>; /* Supply vcc1 */
+			opp-microamp =  <70000>; /* Will be used for both slow/fast */
+			turbo-mode; /* Always marked as turbo */
+			opp-suspend-fast; /* Will marked as suspend opp only if 'fast' is chosen */
 		};
 	};
 };
