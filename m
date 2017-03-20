From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 2/9] PM / Domains: Use OPP tables for power-domains
Date: Mon, 20 Mar 2017 15:02:14 +0530
Message-ID: <5619ac7777689f282f8aafabbde22d71b46a979b.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The OPP table bindings contains all the necessary fields to support
power-domains now. Update the power-domain bindings to allow
"operating-points-v2" to be present within the power-domain node.

Also allow consumer devices, that don't use OPP tables, to specify the
parent power-domain's performance level using the
"domain-performance-state" property.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/power/power_domain.txt     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 723e1ad937da..5db112fa5d7c 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -38,6 +38,9 @@ phandle arguments (so called PM domain specifiers) of length specified by the
   domain's idle states. In the absence of this property, the domain would be
   considered as capable of being powered-on or powered-off.
 
+- operating-points-v2 : This describes the performance states of a PM domain.
+  Refer to ../opp/opp.txt for more information.
+
 Example:
 
 	power: power-controller@12340000 {
@@ -118,4 +121,43 @@ The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
 
+Optional properties:
+- domain-performance-state: A positive integer value representing the minimum
+  power-domain performance level required by the consumer device. The integer
+  value '0' represents the lowest performance level and the higher values
+  represent higher performance levels. The value of "domain-performance-state"
+  field should match the "domain-performance-state" field of one of the OPP
+  nodes in the parent power-domain's OPP table.
+
+
+
+Example:
+
+	domain_opp_table: opp_table {
+		compatible = "operating-points-v2";
+
+		opp@1 {
+			domain-performance-state = <1>;
+			opp-microvolt = <975000 970000 985000>;
+		};
+		opp@2 {
+			domain-performance-state = <2>;
+			opp-microvolt = <1075000 1000000 1085000>;
+		};
+	};
+
+	parent: power-controller@12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <0>;
+		operating-points-v2 = <&domain_opp_table>;
+	};
+
+	leaky-device@12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&power 0>;
+		domain-performance-state = <2>;
+	};
+
 [1]. Documentation/devicetree/bindings/power/domain-idle-state.txt
-- 
2.12.0.432.g71c3a4f4ba37
