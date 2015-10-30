From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Fri, 30 Oct 2015 06:55:05 +0530
Message-ID: <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1446167359.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1446167359.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1446167359.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

We may want to enable only a subset of OPPs, from the bigger list of
OPPs, based on what version of the hardware we are running on. This
would enable us to not duplicate OPP tables for every version of the
hardware we support.

To enable that, this patch defines a new property 'opp-supported-hw'. It
can support any number of hierarchy levels of the versions the hardware
follows. And based on the selected hardware versions, we can pick only
the relevant OPPs at runtime.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 0cb44dc21f97..96892057586a 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -123,6 +123,18 @@ properties.
 - opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
   the table should have this.
 
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
@@ -463,3 +475,48 @@ Example 5: Multiple OPP tables
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
