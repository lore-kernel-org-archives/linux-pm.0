From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 2/7] dt-bindings: PM / OPP: add clocks per OPP node support
Date: Thu, 24 Aug 2017 00:10:05 +0800
Message-ID: <1503504610-12880-3-git-send-email-aisheng.dong@nxp.com>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

It's used for platforms where different OPPs may use different clocks.
With this extended binding, user could specify the correct clock for each
OPP node.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/opp/opp.txt | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index e36d261..40a4340 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -152,6 +152,11 @@ Optional properties:
   hierarchy can be contained in multiple 32 bit values. i.e. <X Y Z1 Z2> in the
   above example, Z1 & Z2 refer to the version hierarchy Z.
 
+- clocks: Clock phandle and specifier used for this opp.
+
+- clock-names: clock names for this opp. The valid clock names are platform
+	       specific.
+
 - status: Marks the node enabled/disabled.
 
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
@@ -528,3 +533,50 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
 		};
 	};
 };
+
+Example 7: Single core ARM cortex A7, switch separate clocks for each OPP:
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
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <975000 970000 985000>;
+			opp-microamp = <70000>;
+			clock-latency-ns = <300000>;
+			clocks = <&clk_controller 0>;
+			opp-suspend;
+		};
+		opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1000000 980000 1010000>;
+			opp-microamp = <80000>;
+			clocks = <&clk_controller 1>;
+			clock-latency-ns = <310000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1025000>;
+			clocks = <&clk_controller 2>;
+			clock-latency-ns = <290000>;
+			turbo-mode;
+		};
+	};
+};
-- 
2.7.4
