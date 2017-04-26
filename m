From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V6 2/9] PM / Domains: Allow OPP table to be used for power-domains
Date: Wed, 26 Apr 2017 16:27:06 +0530
Message-ID: <d725cb8c286506efbb3672d9c9e3f656233d4ce2.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1493203884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1493203884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1493203884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Update the power-domain bindings to allow "operating-points-v2" to be
present within the power-domain's provider node.

Also allow consumer devices that don't use OPP tables, to specify the
parent power-domain's OPP node in their "power-domain-opp" property.

Also note that the "operating-points-v2" property is extended to support
an array for the power domain providers.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/power/power_domain.txt     | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 14bd9e945ff6..730af0afc09a 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -40,6 +40,10 @@ phandle arguments (so called PM domain specifiers) of length specified by the
   domain's idle states. In the absence of this property, the domain would be
   considered as capable of being powered-on or powered-off.
 
+- operating-points-v2 : Phandles to the OPP tables for a power domain provider.
+  If the provider provides a single power domain, then this shall contain a
+  single phandle. Refer to ../opp/opp.txt for more information.
+
 Example:
 
 	power: power-controller@12340000 {
@@ -120,4 +124,106 @@ The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
 
+Optional properties:
+- power-domain-opp: Phandle to the OPP node of the parent power-domain. The
+  parent power-domain should be configured to the OPP whose node is pointed by
+  the phandle, in order to use the device that contains this property.
+
+
+Example:
+- Device with parent power domain with two active states represented by OPP
+  table.
+
+	domain_opp_table: opp_table {
+		compatible = "operating-points-v2";
+
+		/*
+		 * NOTE: Actual frequency is managed by firmware and is hidden
+		 * from HLOS, so we simply use index in the opp-hz field to
+		 * select the OPP.
+		 */
+		domain_opp_1: opp-1 {
+			opp-hz = /bits/ 64 <1>;
+			opp-microvolt = <975000 970000 985000>;
+		};
+		domain_opp_2: opp-2 {
+			opp-hz = /bits/ 64 <2>;
+			opp-microvolt = <1075000 1000000 1085000>;
+		};
+	};
+
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
+		power-domains = <&parent>;
+		power-domain-opp = <&domain_opp_2>;
+	};
+
+- OPP table for domain provider that provides two domains.
+
+	domain0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		/*
+		 * NOTE: Actual frequency is managed by firmware and is hidden
+		 * from HLOS, so we simply use index in the opp-hz field to
+		 * select the OPP.
+		 */
+		domain0_opp_1: opp-1 {
+			opp-hz = /bits/ 64 <1>;
+			opp-microvolt = <975000 970000 985000>;
+		};
+		domain0_opp_2: opp-2 {
+			opp-hz = /bits/ 64 <2>;
+			opp-microvolt = <1075000 1000000 1085000>;
+		};
+	};
+
+	domain1_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+
+		/*
+		 * NOTE: Actual frequency is managed by firmware and is hidden
+		 * from HLOS, so we simply use index in the opp-hz field to
+		 * select the OPP.
+		 */
+		domain1_opp_1: opp-1 {
+			opp-hz = /bits/ 64 <1>;
+			opp-microvolt = <975000 970000 985000>;
+		};
+		domain1_opp_2: opp-2 {
+			opp-hz = /bits/ 64 <2>;
+			opp-microvolt = <1075000 1000000 1085000>;
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
+		power-domain-opp = <&domain0_opp_2>;
+	};
+
+	leaky-device1@12350000 {
+		compatible = "foo,i-leak-current";
+		reg = <0x12350000 0x1000>;
+		power-domains = <&parent 1>;
+		power-domain-opp = <&domain1_opp_2>;
+	};
+
 [1]. Documentation/devicetree/bindings/power/domain-idle-state.txt
-- 
2.12.0.432.g71c3a4f4ba37

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
