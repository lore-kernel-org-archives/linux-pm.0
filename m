From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/2] PM / OPP: Introduce domain-performance-state binding to OPP nodes
Date: Mon, 12 Dec 2016 16:26:19 +0530
Message-ID: <0ace336cf1041611fa561a79b38e879d6816b5d0.1481539827.git.viresh.kumar@linaro.org>
References: <cover.1481539827.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481539827.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1481539827.git.viresh.kumar@linaro.org>
References: <cover.1481539827.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, devicetree@vger.kernel.org, Nayak Rajendra <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
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
Power Domain bindings) to the per OPP node.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 9f5ca4457b5f..43eba7c9fc58 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -154,6 +154,9 @@ properties.
 
 - status: Marks the node enabled/disabled.
 
+- domain-performance-state: A phandle of a Performance state node as defined by
+  ../power/power_domain.txt binding document.
+
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 / {
@@ -528,3 +531,59 @@ Example 5: opp-supported-hw
 		};
 	};
 };
+
+Example 7: domain-Performance-state:
+(example: For 1GHz require domain state 1 and for 1.1 & 1.2 GHz require state 2)
+
+/ {
+	foo_domain: power-controller@12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <0>;
+		domain-performance-states = <&domain_perf_states>;
+	};
+
+	domain_perf_states: performance_states {
+		compatible = "domain-performance-state";
+		domain_perf_state1: pstate@1 {
+			performance-level = <1>;
+			domain-microvolt = <970000 975000 985000>;
+		};
+		domain_perf_state2: pstate@2 {
+			performance-level = <2>;
+			domain-microvolt = <1000000 1075000 1085000>;
+		};
+	}
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			power-domains = <&foo_domain>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			domain-performance-state = <&domain_perf_state1>;
+		};
+		opp@1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			domain-performance-state = <&domain_perf_state2>;
+		};
+		opp@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			domain-performance-state = <&domain_perf_state2>;
+		};
+	};
+};
-- 
2.7.1.410.g6faf27b
