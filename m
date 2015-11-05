From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/5] PM / OPP: Add {opp-microvolt|opp-microamp|turbo-mode|opp-suspend}-<name> binding
Date: Thu,  5 Nov 2015 07:11:53 +0530
Message-ID: <17a4388be606f21fe1d31b23180d41f6cabdd4b5.1446687367.git.viresh.kumar@linaro.org>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446687367.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446687367.git.viresh.kumar@linaro.org>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Depending on the version of hardware or its properties, which are only
known at runtime, various properties of the OPP can change. For example,
an OPP with frequency 1.2 GHz, may have different voltage/current
requirements based on the version of the hardware it is running on.
Similarly, it may or may not be a turbo or suspend OPP on those
circumstances.

In order to not replicate the same OPP tables for varying values of all
such fields, this commit introduces the concept of opp-property-<name>.
The <name> can be chosen by the platform at runtime, and OPPs will be
initialized depending on that name string. Currently support is extended
for the following properties:
- opp-microvolt-<name>
- opp-microamp-<name>
- turbo-mode-<name>
- opp-suspend-<name>

If the name string isn't provided by the platform, or if it is provided
but doesn't match the properties present in the OPP node, we will fall
back to the original properties without the -<name> string, if they are
available.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 58 +++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index d072fa0ffbd4..61c6f25cf8e2 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -100,6 +100,14 @@ properties.
   Entries for multiple regulators must be present in the same order as
   regulators are specified in device's DT node.
 
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
@@ -112,6 +120,9 @@ properties.
   for few regulators, then this should be marked as zero for them. If it isn't
   required for any regulator, then this property need not be present.
 
+- opp-microamp-<name>: Named opp-microamp property. Similar to
+  opp-microvolt-<name> property, but for microamp instead.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
@@ -120,9 +131,15 @@ properties.
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
 - opp-supported-hw: This enables us to select only a subset of OPPs from the
   larger OPP table, based on what version of the hardware we are running on. We
   still can't have multiple nodes with the same opp-hz value in OPP table.
@@ -528,3 +545,44 @@ Example 6: opp-supported-hw
 		};
 	};
 };
+
+Example 7: opp-microvolt-<name>, opp-microamp-<name>, turbo-mode-<name>,
+opp-suspend-<name>:
+(example: device with two possible microvolt ranges: slow and fast)
+
+/ {
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a7";
+			...
+
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt-slow = <900000 915000 925000>;
+			opp-microvolt-fast = <970000 975000 985000>;
+			opp-microamp-slow =  <70000>;
+			opp-microamp-fast =  <71000>;
+			turbo-mode-slow; /* Will be used as turbo only if 'slow' is chosen */
+			opp-suspend-slow; /* Will be used as suspend-opp only if 'slow' is chosen */
+		};
+
+		opp01 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-slow = <900000 915000 925000>, /* Supply vcc0 */
+					      <910000 925000 935000>; /* Supply vcc1 */
+			opp-microvolt-fast = <970000 975000 985000>, /* Supply vcc0 */
+					     <960000 965000 975000>; /* Supply vcc1 */
+			opp-microamp =  <70000>; /* Will be used for both slow/fast */
+			turbo-mode; /* Always used as turbo */
+			opp-suspend-fast; /* Will be used as suspend opp only if 'fast' is chosen */
+		};
+	};
+};
-- 
2.6.2.198.g614a2ac
