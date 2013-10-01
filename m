From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 1/5] PM / OPP: extend DT binding to specify phandle of another node for OPP
Date: Tue,  1 Oct 2013 14:32:58 +0100
Message-ID: <1380634382-15609-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>

If more than one similar devices share the same operating points(OPPs)
being in the same clock domain, currently we need to replicate the
OPP entries in all the nodes.

This patch extends existing binding by adding a new property named
'operating-points-phandle' to specify the phandle in any device node
pointing to another node which contains the actual OPP tuples.
This helps to avoid replication if multiple devices share the OPPs.

Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 161 ++++++++++++++++++++++--
 1 file changed, 149 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 74499e5..f59b878 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -4,22 +4,159 @@ SoCs have a standard set of tuples consisting of frequency and
 voltage pairs that the device will support per voltage domain. These
 are called Operating Performance Points or OPPs.
 
-Properties:
+Required Properties:
 - operating-points: An array of 2-tuples items, and each item consists
   of frequency and voltage like <freq-kHz vol-uV>.
 	freq: clock frequency in kHz
 	vol: voltage in microvolt
 
+- operating-points-phandle: phandle to the device tree node which contains
+	the operating points tuples(recommended to be used if multiple
+	devices are in the same clock domain and hence share OPPs, as it
+	avoids replication of OPPs)
+
+  operating-points and operating-points-phandle are mutually exclusive, only
+  one of them can be present in any device node.
+
 Examples:
 
-cpu@0 {
-	compatible = "arm,cortex-a9";
-	reg = <0>;
-	next-level-cache = <&L2>;
-	operating-points = <
-		/* kHz    uV */
-		792000  1100000
-		396000  950000
-		198000  850000
-	>;
-};
+1. A uniprocessor system (phandle not required)
+
+	cpu0: cpu@0 {
+		compatible = "arm,cortex-a9";
+		reg = <0>;
+		operating-points = <
+			/* kHz    uV */
+			792000  1100000
+			396000  950000
+			198000  850000
+		>;
+	};
+
+2a. Consider a SMP system with 4 CPUs in the same clock domain(no phandle)
+    Some existing DTs describe homogenous SMP systems by only listing the
+    OPPs in the cpu@0 node. For compatiblity with existing DTs, an
+    operating system may handle this case specially.
+
+	cpu0: cpu@0 {
+		compatible = "arm,cortex-a9";
+		reg = <0>;
+		operating-points = <
+			/* kHz    uV */
+			792000  1100000
+			396000  950000
+			198000  850000
+		>;
+	};
+
+	cpu1: cpu@1 {
+		compatible = "arm,cortex-a9";
+		reg = <1>;
+	};
+
+	cpu2: cpu@2 {
+		compatible = "arm,cortex-a9";
+		reg = <2>;
+	};
+
+	cpu3: cpu@3 {
+		compatible = "arm,cortex-a9";
+		reg = <3>;
+	};
+
+2b. Consider a SMP system with 4 CPUs in the same clock domain(with phandle)
+    If more than one device of same type share the same OPPs, for example
+    all the CPUs on a SoC or in a single cluster on a SoC, then we can avoid
+    replicating the OPPs in all the nodes. We can specify the phandle of
+    the node which contains the OPP tuples instead.
+
+	cpu0: cpu@0 {
+		compatible = "arm,cortex-a9";
+		reg = <0>;
+		operating-points-phandle = <&cpu_opp>;
+	};
+
+	cpu1: cpu@1 {
+		compatible = "arm,cortex-a9";
+		reg = <1>;
+		operating-points-phandle = <&cpu_opp>;
+	};
+
+	cpu2: cpu@2 {
+		compatible = "arm,cortex-a9";
+		reg = <2>;
+		operating-points-phandle = <&cpu_opp>;
+	};
+
+	cpu3: cpu@3 {
+		compatible = "arm,cortex-a9";
+		reg = <3>;
+		operating-points-phandle = <&cpu_opp>;
+	};
+
+	opps-table {
+		cpu_opp: cpu_opp {
+			operating-points = <
+				/* kHz    uV */
+				792000  1100000
+				396000  950000
+				198000  850000
+			>;
+		};
+		... /* other device OPP nodes */
+	}
+
+4. Consider an AMP(asymmetric multi-processor) sytem with 2 clusters of
+   CPUs. Each cluster has 2 CPUs and all the CPUs within the cluster share
+   the clock domain.
+
+	cpu0: cpu@0 {
+		compatible = "arm,cortex-a15";
+		reg = <0>;
+		operating-points-phandle = <&cluster0_opp>;
+	};
+
+	cpu1: cpu@1 {
+		compatible = "arm,cortex-a15";
+		reg = <1>;
+		operating-points-phandle = <&cluster0_opp>;
+	};
+
+	cpu2: cpu@100 {
+		compatible = "arm,cortex-a7";
+		reg = <100>;
+		operating-points-phandle = <&cluster1_opp>;
+	};
+
+	cpu3: cpu@101 {
+		compatible = "arm,cortex-a7";
+		reg = <101>;
+		operating-points-phandle = <&cluster1_opp>;
+	};
+
+	opps-table {
+		cluster0_opp: cluster0_opp {
+			operating-points = <
+				/* kHz    uV */
+				792000  1100000
+				396000  950000
+				198000  850000
+			>;
+		};
+		cluster1_opp: cluster1_opp {
+			operating-points = <
+				/* kHz    uV */
+				792000  950000
+				396000  750000
+				198000  450000
+			>;
+		};
+		... /* other device OPP nodes */
+	}
+
+Container Node
+--------------
+	- It's highly recommended to place all the shared OPPs under single
+	  node for consistency and better readability
+	- It's quite similar to clocks or pinmux container nodes
+	- In the above examples, "opps-table" is the container node
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
