From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V6 1/9] PM / OPP: Introduce "power-domain-opp" property
Date: Wed, 26 Apr 2017 16:27:05 +0530
Message-ID: <025acedb263eaa6089d354d9630214ada8013990.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1493203884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1493203884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1493203884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Power-domains need to express their active states in DT and the devices
within the power-domain need to express their dependency on those active
states. The power-domains can use the OPP tables without any
modifications to the bindings.

Add a new property "power-domain-opp", which will contain phandle to the
OPP node of the parent power domain. This is required for devices which
have dependency on the configured active state of the power domain for
their working.

For some platforms the actual frequency and voltages of the power
domains are managed by the firmware and are so hidden from the high
level operating system. The "opp-hz" property is relaxed a bit to
contain indexes instead of actual frequency values to support such
platforms.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 74 ++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 63725498bd20..6e30cae2a936 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -77,7 +77,10 @@ This defines voltage-current-frequency combinations along with other related
 properties.
 
 Required properties:
-- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer.
+- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. In some
+  cases the exact frequency in Hz may be hidden from the OS by the firmware and
+  this field may contain values that represent the frequency in a firmware
+  dependent way, for example an index of an array in the firmware.
 
 Optional properties:
 - opp-microvolt: voltage in micro Volts.
@@ -154,6 +157,13 @@ properties.
 
 - status: Marks the node enabled/disabled.
 
+- power-domain-opp: Phandle to the OPP node of the parent power-domain. The
+  parent power-domain should be configured to the OPP whose node is pointed by
+  the phandle, in order to configure the device for the OPP node that contains
+  this property. The order in which the device and power domain should be
+  configured is implementation defined. The OPP table of a device can set this
+  property only if the device node contains "power-domains" property.
+
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 / {
@@ -528,3 +538,65 @@ Example 5: opp-supported-hw
 		};
 	};
 };
+
+Example 7: Power domains with their own OPP tables:
+(example: For 1GHz device require domain state 1 and for 1.1 & 1.2 GHz device require state 2)
+
+/ {
+	domain_opp_table: opp_table0 {
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
+	foo_domain: power-controller@12340000 {
+		compatible = "foo,power-controller";
+		reg = <0x12340000 0x1000>;
+		#power-domain-cells = <0>;
+		operating-points-v2 = <&domain_opp_table>;
+	}
+
+	cpu0_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			power-domain-opp = <&domain_opp_1>;
+		};
+		opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			power-domain-opp = <&domain_opp_2>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			power-domain-opp = <&domain_opp_2>;
+		};
+	};
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
+};
-- 
2.12.0.432.g71c3a4f4ba37

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
