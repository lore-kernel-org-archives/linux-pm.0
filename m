From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/5] PM / OPP: Add "opp-supported-hw" binding
Date: Wed, 11 Nov 2015 08:10:54 +0530
Message-ID: <edf547c73ec9f09c3b3c8d6c34d12f0f3eb22e0c.1447209519.git.viresh.kumar@linaro.org>
References: <cover.1447209519.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447209519.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1447209519.git.viresh.kumar@linaro.org>
References: <cover.1447209519.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

We may want to enable only a subset of OPPs, from the bigger list of
OPPs, based on what version of the hardware we are running on. This
would enable us to not duplicate OPP tables for every version of the
hardware we support.

To enable that, this patch defines a new property 'opp-supported-hw'. It
can support any number of hierarchy levels of the versions the hardware
follows. And based on the selected hardware versions, we can pick only
the relevant OPPs at runtime.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 0cb44dc21f97..d072fa0ffbd4 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -123,6 +123,26 @@ properties.
 - opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
   the table should have this.
 
+- opp-supported-hw: This enables us to select only a subset of OPPs from the
+  larger OPP table, based on what version of the hardware we are running on. We
+  still can't have multiple nodes with the same opp-hz value in OPP table.
+
+  It's an user defined array containing a hierarchy of hardware version numbers,
+  supported by the OPP. For example: a platform with hierarchy of three levels
+  of versions (A, B and C), this field should be like <X Y Z>, where X
+  corresponds to Version hierarchy A, Y corresponds to version hierarchy B and Z
+  corresponds to version hierarchy C.
+
+  Each level of hierarchy is represented by a 32 bit value, and so there can be
+  only 32 different supported version per hierarchy. i.e. 1 bit per version. A
+  value of 0xFFFFFFFF will enable the OPP for all versions for that hierarchy
+  level. And a value of 0x00000000 will disable the OPP completely, and so we
+  never want that to happen.
+
+  If 32 values aren't sufficient for a version hierarchy, than that version
+  hierarchy can be contained in multiple 32 bit values. i.e. <X Y Z1 Z2> in the
+  above example, Z1 & Z2 refer to the version hierarchy Z.
+
 - status: Marks the node enabled/disabled.
 
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
@@ -463,3 +483,48 @@ Example 5: Multiple OPP tables
 		};
 	};
 };
+
+Example 6: opp-supported-hw
+(example: three level hierarchy of versions: cuts, substrate and process)
+
+/ {
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a7";
+			...
+
+			cpu-supply = <&cpu_supply>
+			operating-points-v2 = <&cpu0_opp_table_slow>;
+		};
+	};
+
+	opp_table {
+		compatible = "operating-points-v2";
+		status = "okay";
+		opp-shared;
+
+		opp00 {
+			/*
+			 * Supports all substrate and process versions for 0xF
+			 * cuts, i.e. only first four cuts.
+			 */
+			opp-supported-hw = <0xF 0xFFFFFFFF 0xFFFFFFFF>
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000 915000 925000>;
+			...
+		};
+
+		opp01 {
+			/*
+			 * Supports:
+			 * - cuts: only one, 6th cut (represented by 6th bit).
+			 * - substrate: supports 16 different substrate versions
+			 * - process: supports 9 different process versions
+			 */
+			opp-supported-hw = <0x20 0xff0000ff 0x0000f4f0>
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000 915000 925000>;
+			...
+		};
+	};
+};
-- 
2.6.2.198.g614a2ac
