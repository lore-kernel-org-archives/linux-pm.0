From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V7 1/2] OPP: Allow OPP table to be used for power-domains
Date: Tue, 31 Oct 2017 18:17:02 +0530
Message-ID: <2b244ea0a09deaf50237fb8b7578273a8284499e.1509453284.git.viresh.kumar@linaro.org>
References: <cover.1509453284.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509453284.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1509453284.git.viresh.kumar@linaro.org>
References: <cover.1509453284.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, rnayak@codeaurora.org, sudeep.holla@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Power-domains can also have their active states and this patch enhances
the OPP binding to define those.

The power domains can use the OPP bindings mostly as is. Though there
are some changes required to support special cases:

- Allow "operating-points-v2" to contain multiple phandles for power
  domain providers providing multiple domains.

- A new property "power-domain-opp" is added for devices to specify the
  minimum required OPP of the master domain for the functioning of the
  device. We can add this property directly to device's node if the
  device has a fixed minimum OPP requirement from the master power
  domain. Or we can add this property to each OPP node of the device, if
  different OPP nodes have different minimum OPP requirement from the
  master power domain.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt      | 12 +++++
 .../devicetree/bindings/power/power_domain.txt     | 62 ++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 9d733af26be7..203e09fe7698 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -45,6 +45,11 @@ Devices supporting OPPs must set their "operating-points-v2" property with
 phandle to a OPP table in their DT node. The OPP core will use this phandle to
 find the operating points for the device.
 
+This can contain more than one phandle for power domain providers that provide
+multiple power domains. That is, one phandle for each power domain. If only one
+phandle is available, then the same OPP table will be used for all power domains
+provided by the power domain provider.
+
 If required, this can be extended for SoC vendor specific bindings. Such bindings
 should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
 and should have a compatible description like: "operating-points-v2-<vendor>".
@@ -154,6 +159,13 @@ properties.
 
 - status: Marks the node enabled/disabled.
 
+- power-domain-opp: This contains phandle to one of the OPP nodes of the master
+  power domain. This specifies the minimum required OPP of the master domain for
+  the functioning of the device in this OPP (where this property is present).
+  This property can only be set for a device if the device node contains the
+  "power-domains" property. Also, either all or none of the OPP nodes in an OPP
+  table should have it set.
+
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 / {
diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 14bd9e945ff6..0d8608f2d133 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -40,6 +40,12 @@ phandle arguments (so called PM domain specifiers) of length specified by the
   domain's idle states. In the absence of this property, the domain would be
   considered as capable of being powered-on or powered-off.
 
+- operating-points-v2 : Phandles to the OPP tables of power domains provided by
+  a power domain provider. If the provider provides a single power domain only
+  or all the power domains provided by the provider have identical OPP tables,
+  then this shall contain a single phandle. Refer to ../opp/opp.txt for more
+  information.
+
 Example:
 
 	power: power-controller@12340000 {
@@ -120,4 +126,60 @@ The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
 
+Optional properties:
+- power-domain-opp: This contains phandle to one of the OPP nodes of the master
+  power domain. This specifies the minimum required OPP of the master domain for
+  the functioning of the device. This property can only be set for a device, if
+  the device node contains the "power-domains" property.
+
+Example:
+- OPP table for domain provider that provides two domains.
+
+	domain0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		domain0_opp_0: opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <975000 970000 985000>;
+		};
+		domain0_opp_1: opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1000000 980000 1010000>;
+		};
+	};
+
+	domain1_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+
+		domain1_opp_0: opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <975000 970000 985000>;
+		};
+		domain1_opp_1: opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1000000 980000 1010000>;
+		};
+	};
+
+	parent: power-controller@12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <1>;
+		operating-points-v2 = <&domain0_opp_table>, <&domain1_opp_table>;
+	};
+
+	leaky-device0@12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&parent 0>;
+		power-domain-opp = <&domain0_opp_0>;
+	};
+
+	leaky-device1@12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&parent 1>;
+		power-domain-opp = <&domain1_opp_1>;
+	};
+
 [1]. Documentation/devicetree/bindings/power/domain-idle-state.txt
-- 
2.15.0.rc1.236.g92ea95045093
