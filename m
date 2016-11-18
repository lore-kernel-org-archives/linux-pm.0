From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] PM / OPP: Introduce domain-performance-state binding to OPP nodes
Date: Fri, 18 Nov 2016 14:53:13 +0530
Message-ID: <76c8ccbb551cd513c32001f3da6986a3356becbd.1479459752.git.viresh.kumar@linaro.org>
References: <cover.1479459752.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1479459752.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1479459752.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1479459752.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nayak Rajendra <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Some platforms have the capability to configure the performance state of
their Power Domains. The performance levels are represented by positive
integer values, a lower value represents lower performance state.

If the consumers don't need the capability of switching to different
domain performance states at runtime, then they can simply define their
required domain performance state in their nodes directly.

But if the device needs the capability of switching to different domain
performance states, as they may need to support different clock rates,
then the per OPP node can be used to contain that information.

This patch introduces the domain-performance-state (already defined by
Power Domain bindings) to the per OPP node. It can contain a single
positive integer value. An example is also provided.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index ee91cbdd95ee..9fb7804f784d 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -145,6 +145,14 @@ properties.
 
 - status: Marks the node enabled/disabled.
 
+- domain-performance-state: A positive integer value representing the minimum
+  performance level (of the parent domain) required by the consumer for the
+  working of respective OPP. The integer value '1' represents the lowest
+  performance level and the highest value represents the highest performance
+  level. The consumer device node (which contains phandle to the OPP table in
+  its "operating-points-v2" property) should have its "power-domains" property
+  set as well.
+
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 / {
@@ -517,3 +525,52 @@ Example 5: opp-supported-hw
 		};
 	};
 };
+
+Example 7: domain-Performance-state:
+(example: For 1GHz require domain state 1 and for 1.1 & 1.2 GHz require state 2)
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
+			power-domains = <&foo_pd>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <970000 975000 985000>;
+			opp-microamp = <70000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+			domain-performance-state = <1>;
+		};
+		opp@1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			opp-microamp = <80000>;
+			clock-latency-ns = <310000>;
+			domain-performance-state = <2>;
+		};
+		opp@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <290000>;
+			turbo-mode;
+			domain-performance-state = <2>;
+		};
+	};
+};
-- 
2.7.1.410.g6faf27b

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
