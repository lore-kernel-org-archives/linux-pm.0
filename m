From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 23 Jan 2015 16:14:50 +0530
Message-ID: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:45240 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbbAWKpC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jan 2015 05:45:02 -0500
Received: by mail-pd0-f181.google.com with SMTP id g10so5313900pdj.12
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2015 02:45:01 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, rob.herring@linaro.org, grant.likely@linaro.org, olof@lixom.ne
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, l.stach@pengutronix.de, broonie@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Rob et al,

This is another attempt to redefine OPP bindings which we concluded to after
first round of reviews.

Current OPP (Operating performance point) DT bindings are proven to be
insufficient at multiple instances.

There had been multiple band-aid approaches to get them fixed (The latest one
being: http://www.mail-archive.com/devicetree@vger.kernel.org/msg53398.html).
For obvious reasons Rob rejected them and shown the right path forward.

The shortcomings we are trying to solve here:

- How to select which driver to probe for a platform, when multiple drivers are
  available. For example: how to choose between cpufreq-dt and arm_big_little
  drivers.

- Getting clock sharing information between CPUs. Single shared clock vs
  independent clock per core vs shared clock per cluster.

- Support for turbo modes

- Support for intermediate frequencies

- Other per OPP settings: transition latencies, disabled status, etc.?

Please see the below bindings for further details.

I haven't incorporated the comments given by Mark Brown as I had some doubts.
@broonie: Is this what you wanted to mention earlier ? : http://pastebin.com/1RZTccmm

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---

 Documentation/devicetree/bindings/power/opp.txt | 309 +++++++++++++++++++++++-
 1 file changed, 308 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 74499e5033fc..9cdc0c9b09af 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -1,9 +1,316 @@
-* Generic OPP Interface
+Generic OPP (Operating Performance Points) Interface
+----------------------------------------------------
 
 SoCs have a standard set of tuples consisting of frequency and
 voltage pairs that the device will support per voltage domain. These
 are called Operating Performance Points or OPPs.
 
+This documents defines OPP bindings with its required/optional properties. OPPs
+can be defined for any device, this file uses CPU as an example to illustrate
+how to define OPPs.
+
+opp nodes and opp-lists
+
+- opp-listN:
+  List of nodes defining performance points. Following belong to the nodes
+  within the opp-lists.
+
+  Required properties:
+  - opp-khz: Frequency in kHz
+  - opp-microvolt: voltage in micro Volts
+
+  Optional properties:
+  - turbo-mode: Marks the volt-freq pair as turbo pair.
+  - status: Marks the node enabled/disabled.
+  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
+  - clock-latency-ns: Specify the possible maximum transition latency (in
+    nanoseconds) for switching to this opp from any other opp.
+
+- oppN:
+  Operating performance point node per device. Devices using it should have its
+  phandle in their "operating-points-v2" property.
+
+  Required properties:
+  - compatible: allow OPPs to express their compatibility.
+  - opp-list: phandle to opp-list defined above.
+
+  Optional properties:
+  - opp-intermediate: Stable opp we *must* switch to, before switching to the
+    target opp. Contains phandle of one of the opp-node present in opp-list.
+
+Example 1: Simple case of dual-core cortex A9-single cluster, sharing clock line.
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
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+	};
+
+	cpu0_opp: opp0 {
+		compatible = "linux,cpu-dvfs";
+		opp-list = <&cpu0_opplist>;
+		opp-intermediate = <&cpu0_intermediate>;
+
+		cpu0_opplist: opp-list0 {
+			entry00 {
+				opp-khz = <1000000>;
+				opp-microvolt = <975000>;
+				voltage-tolerance = <2>;
+				clock-latency-ns = <300000>;
+				status = "okay";
+			};
+			cpu0_intermediate: entry01 {
+				opp-khz = <1100000>;
+				opp-microvolt = <1000000>;
+				voltage-tolerance = <3>;
+				clock-latency-ns = <310000>;
+				status = "okay";
+			};
+			entry02 {
+				opp-khz = <1200000>;
+				opp-microvolt = <1025000>;
+				voltage-tolerance = <1>;
+				clock-latency-ns = <290000>;
+				status = "okay";
+				turbo-mode;
+			};
+		};
+	};
+};
+
+Example 2: Quad-core krait (All CPUs have independent clock lines but have same set of OPPs)
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "qcom,krait";
+			reg = <0>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+
+		cpu@1 {
+			compatible = "qcom,krait";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cpu1_opp>;
+		};
+
+		cpu@2 {
+			compatible = "qcom,krait";
+			reg = <2>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 2>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply2>;
+			operating-points-v2 = <&cpu2_opp>;
+		};
+
+		cpu@3 {
+			compatible = "qcom,krait";
+			reg = <3>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 3>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply3>;
+			operating-points-v2 = <&cpu3_opp>;
+		};
+	};
+
+	cpu0_opp: opp0 {
+		compatible = "linux,cpu-dvfs";
+		opp-list = <&cpu0_opplist>;
+		opp-intermediate = <&cpu0_intermediate>;
+
+		cpu0_opplist: opp-list0 {
+			entry00 {
+				opp-khz = <1000000>;
+				opp-microvolt = <975000>;
+				voltage-tolerance = <2>;
+				clock-latency-ns = <300000>;
+				status = "okay";
+			};
+			cpu0_intermediate: entry01 {
+				opp-khz = <1100000>;
+				opp-microvolt = <1000000>;
+				voltage-tolerance = <2>;
+				clock-latency-ns = <300000>;
+				status = "okay";
+			};
+			entry02 {
+				opp-khz = <1200000>;
+				opp-microvolt = <1025000>;
+				voltage-tolerance = <2>;
+				clock-latency-ns = <300000>;
+				status = "okay";
+				turbo-mode;
+			};
+		};
+	};
+
+	cpu1_opp: opp1 {
+		compatible = "linux,cpu-dvfs";
+		opp-list = <&cpu0_opplist>;
+		opp-intermediate = <&cpu0_intermediate>;
+	};
+
+	cpu2_opp: opp2 {
+		compatible = "linux,cpu-dvfs";
+		opp-list = <&cpu0_opplist>;
+	};
+
+	cpu3_opp: opp3 {
+		compatible = "linux,cpu-dvfs";
+		opp-list = <&cpu0_opplist>;
+		opp-intermediate = <&cpu0_intermediate>;
+	};
+};
+
+Example 3: Multi-cluster system with separate clock line per cluster.
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
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+
+		cpu@100 {
+			compatible = "arm,cortex-a15";
+			reg = <100>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cpu100_opp>;
+		};
+
+		cpu@101 {
+			compatible = "arm,cortex-a15";
+			reg = <101>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cpu100_opp>;
+		};
+	};
+
+	cpu0_opp: opp0 {
+		compatible = "linux,cpu-dvfs";
+		opp-list = <&cpu0_opplist>;
+		opp-intermediate = <&cpu0_intermediate>;
+
+		cpu0_opplist: opp-list0 {
+			entry00 {
+				opp-khz = <1000000>;
+				opp-microvolt = <975000>;
+				voltage-tolerance = <2>;
+				clock-latency-ns = <300000>;
+				status = "okay";
+			};
+			cpu0_intermediate: entry01 {
+				opp-khz = <1100000>;
+				opp-microvolt = <1000000>;
+				voltage-tolerance = <2>;
+				clock-latency-ns = <300000>;
+				status = "okay";
+			};
+			entry02 {
+				opp-khz = <1200000>;
+				opp-microvolt = <1025000>;
+				voltage-tolerance = <2>;
+				clock-latency-ns = <300000>;
+				status = "okay";
+				turbo-mode;
+			};
+		};
+	};
+
+	cpu100_opp: opp1 {
+		compatible = "linux,cpu-dvfs";
+		opp-list = <&cpu100_opplist>;
+		opp-intermediate = <&cpu100_intermediate>;
+
+		cpu100_opplist: opp-list1 {
+			entry10 {
+				opp-khz = <1300000>;
+				opp-microvolt = <1050000>;
+				voltage-tolerance = <2>;
+				clock-latency-ns = <400000>;
+				status = "okay";
+			};
+			cpu100_intermediate: entry11 {
+				opp-khz = <1400000>;
+				opp-microvolt = <1075000>;
+				voltage-tolerance = <2>;
+				clock-latency-ns = <400000>;
+				status = "okay";
+			};
+			entry12 {
+				opp-khz = <1500000>;
+				opp-microvolt = <1100000>;
+				voltage-tolerance = <2>;
+				clock-latency-ns = <400000>;
+				status = "okay";
+				turbo-mode;
+			};
+		};
+	};
+};
+
+
+
+Deprecated Bindings
+-------------------
+
 Properties:
 - operating-points: An array of 2-tuples items, and each item consists
   of frequency and voltage like <freq-kHz vol-uV>.
-- 
2.3.0.rc0.44.ga94655d

