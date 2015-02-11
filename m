From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/7] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 11 Feb 2015 16:16:24 +0800
Message-ID: <be795ef7ec98669bc5aa90ec426a1ec1fbc32b6c.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34664 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbbBKIQ6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 03:16:58 -0500
Received: by mail-pa0-f53.google.com with SMTP id lf10so2437832pab.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 00:16:58 -0800 (PST)
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, grant.likely@linaro.org, olof@lixom.net, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, l.stach@pengutronix.de, broonie@kernel.org, viswanath.puttagunta@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Current OPP (Operating performance point) DT bindings are proven to be
insufficient at multiple instances.

There had been multiple band-aid approaches to get them fixed (The latest one
being: http://www.mail-archive.com/devicetree@vger.kernel.org/msg53398.html).
For obvious reasons Rob rejected them and shown the right path forward.

The shortcomings we are trying to solve here:

- Getting clock sharing information between CPUs. Single shared clock vs
  independent clock per core vs shared clock per cluster.

- Support for turbo modes

- Support for intermediate frequencies or OPPs we can switch to.

- Other per OPP settings: transition latencies, disabled status, etc.?

- Expandability of OPPs in future.

This patch introduces new bindings "operating-points-v2" to get these problems
solved. Refer to the bindings for more details.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 407 +++++++++++++++++++++++-
 1 file changed, 403 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 74499e5033fc..a64621819d7c 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -1,8 +1,407 @@
-* Generic OPP Interface
+Generic OPP (Operating Performance Points) Bindings
+----------------------------------------------------
 
-SoCs have a standard set of tuples consisting of frequency and
-voltage pairs that the device will support per voltage domain. These
-are called Operating Performance Points or OPPs.
+Devices work at voltage-frequency pairs and some implementations have the
+liberty of choosing these pairs. These pairs are called Operating Performance
+Points aka OPPs. This document defines bindings for these OPPs applicable across
+wide range of devices. For illustration purpose, this document uses CPU as a
+device.
+
+
+* Property: operating-points-v2
+
+Devices supporting OPPs must set their "operating-points-v2" property with
+phandle to a OPP descriptor in their DT node. The OPP core will use this phandle
+to find the operating points for the device.
+
+
+* OPP Descriptor Node
+
+This describes the OPPs belonging to a device. This node can have following
+properties:
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2".
+- OPP nodes: One or more OPP nodes describing frequency-voltage pairs. Their
+  name isn't significant but their phandles can be used to reference an OPP.
+
+Optional properties:
+- shared-opp: Indicates that device nodes using this OPP descriptor's phandle
+  switch their DVFS state together, i.e. they share clock lines. Missing
+  property means devices have independent clock lines, but they share OPPs.
+
+
+* OPP Node
+
+This defines frequency-voltage pairs along with other related properties.
+
+Required properties:
+- opp-khz: Frequency in kHz
+
+Optional properties:
+- opp-microvolt: voltage in micro Volts. Its an array with size one or three.
+  Single entry is for target voltage and three entries are for (in the specified
+  order) <target min max> voltage.
+- clock-latency-ns: Specifies the maximum possible transition latency (in
+  nanoseconds) for switching to this OPP from any other OPP.
+- opp-next: It contains a list of phandles of other OPPs, to which we can switch
+  directly from this OPP (Explained later with examples). Missing property means
+  no restriction on switching to other OPPs.
+- turbo-mode: Marks the OPP to be used only for turbo modes.
+- status: Marks the node enabled/disabled.
+
+Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
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
+		compatible = "operating-points-v2";
+		shared-opp;
+
+		entry00 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000 975000 985000>;
+			clock-latency-ns = <300000>;
+		};
+		entry01 {
+			opp-khz = <1100000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			clock-latency-ns = <310000>;
+		};
+		entry02 {
+			opp-khz = <1200000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <290000>;
+			turbo-mode;
+		};
+	};
+};
+
+Example 2: Single cluster, Quad-core Qualcom-krait, switches DVFS states
+independently.
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
+			operating-points-v2 = <&cpu0_opp>;
+		};
+
+		cpu@2 {
+			compatible = "qcom,krait";
+			reg = <2>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 2>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply2>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+
+		cpu@3 {
+			compatible = "qcom,krait";
+			reg = <3>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 3>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply3>;
+			operating-points-v2 = <&cpu0_opp>;
+		};
+	};
+
+	cpu0_opp: opp0 {
+		compatible = "operating-points-v2";
+
+		/*
+		 * Missing shared-opp property means CPUs switch DVFS states
+		 * independently.
+		 */
+
+		entry00 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000 975000 985000>;
+			clock-latency-ns = <300000>;
+		};
+		entry01 {
+			opp-khz = <1100000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			clock-latency-ns = <310000>;
+		};
+		entry02 {
+			opp-khz = <1200000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <290000>;
+			turbo-mode;
+		};
+	};
+};
+
+Example 3: Dual-cluster, Dual-core per cluster. CPUs within a cluster switch
+DVFS state together.
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
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 0>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply0>;
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu@100 {
+			compatible = "arm,cortex-a15";
+			reg = <100>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cluster1_opp>;
+		};
+
+		cpu@101 {
+			compatible = "arm,cortex-a15";
+			reg = <101>;
+			next-level-cache = <&L2>;
+			clocks = <&clk_controller 1>;
+			clock-names = "cpu";
+			opp-supply = <&cpu_supply1>;
+			operating-points-v2 = <&cluster1_opp>;
+		};
+	};
+
+	cluster0_opp: opp0 {
+		compatible = "operating-points-v2";
+		shared-opp;
+
+		entry00 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000 975000 985000>;
+			clock-latency-ns = <300000>;
+		};
+		entry01 {
+			opp-khz = <1100000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			clock-latency-ns = <310000>;
+		};
+		entry02 {
+			opp-khz = <1200000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <290000>;
+			turbo-mode;
+		};
+	};
+
+	cluster1_opp: opp1 {
+		compatible = "operating-points-v2";
+		shared-opp;
+
+		entry10 {
+			opp-khz = <1300000>;
+			opp-microvolt = <1045000 1050000 1055000>;
+			clock-latency-ns = <400000>;
+		};
+		entry11 {
+			opp-khz = <1400000>;
+			opp-microvolt = <1075000>;
+			clock-latency-ns = <400000>;
+		};
+		entry12 {
+			opp-khz = <1500000>;
+			opp-microvolt = <1010000 1100000 1110000>;
+			clock-latency-ns = <400000>;
+			turbo-mode;
+		};
+	};
+};
+
+Example 4: How to use "opp-next" property ?
+
+1.) Switch to a intermediate OPP (entry00) before switching to any other OPP.
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
+	};
+
+	cpu0_opp: opp0 {
+		compatible = "operating-points-v2";
+		shared-opp;
+
+		opp_next: entry00 {
+			opp-khz = <500000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+			/* Can switch to any OPP from here */
+		};
+		entry01 {
+			opp-khz = <600000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+			opp-next = <&opp_next>;
+		};
+		entry02 {
+			opp-khz = <900000>;
+			opp-microvolt = <970000 975000 985000>;
+			clock-latency-ns = <300000>;
+			opp-next = <&opp_next>;
+		};
+		entry03 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000 975000 985000>;
+			clock-latency-ns = <300000>;
+			opp-next = <&opp_next>;
+		};
+		entry04 {
+			opp-khz = <1100000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			clock-latency-ns = <310000>;
+			opp-next = <&opp_next>;
+		};
+		entry05 {
+			opp-khz = <1200000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <290000>;
+			opp-next = <&opp_next>;
+			turbo-mode;
+		};
+	};
+};
+
+2.) Can only switch to the next or previous OPP directly.
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
+	};
+
+	cpu0_opp: opp0 {
+		compatible = "operating-points-v2";
+		shared-opp;
+
+		opp_next0: entry00 {
+			opp-khz = <500000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+			opp-next = <&opp_next1>;
+		};
+		opp_next1: entry01 {
+			opp-khz = <600000>;
+			opp-microvolt = <800000>;
+			clock-latency-ns = <300000>;
+			opp-next = <&opp_next0>, <&opp_next2>;
+		};
+		opp_next2: entry02 {
+			opp-khz = <900000>;
+			opp-microvolt = <970000 975000 985000>;
+			clock-latency-ns = <300000>;
+			opp-next = <&opp_next1>, <&opp_next3>;
+		};
+		opp_next3: entry03 {
+			opp-khz = <1000000>;
+			opp-microvolt = <970000 975000 985000>;
+			clock-latency-ns = <300000>;
+			opp-next = <&opp_next2>, <&opp_next4>;
+		};
+		opp_next4: entry04 {
+			opp-khz = <1100000>;
+			opp-microvolt = <980000 1000000 1010000>;
+			clock-latency-ns = <310000>;
+			opp-next = <&opp_next3>, <&opp_next5>;
+		};
+		opp_next5: entry05 {
+			opp-khz = <1200000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <290000>;
+			opp-next = <&opp_next4>;
+			turbo-mode;
+		};
+	};
+};
+
+
+
+Deprecated Bindings
+-------------------
 
 Properties:
 - operating-points: An array of 2-tuples items, and each item consists
-- 
2.3.0.rc0.44.ga94655d

