From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 3/3] OPP: Add 'opp-next' in operating-points-v2 bindings
Date: Thu, 30 Apr 2015 17:38:01 +0530
Message-ID: <1ee98ae5b45083e681c7f530e0ae9195e5636119.1430394884.git.viresh.kumar@linaro.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33690 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbbD3MIW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 08:08:22 -0400
Received: by pdbnk13 with SMTP id nk13so58897033pdb.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 05:08:21 -0700 (PDT)
In-Reply-To: <cover.1430394884.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1430394884.git.viresh.kumar@linaro.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

Many platforms require to switch to a intermediate frequency before
switching to a final frequency. Or they can switch to only particular
OPPs from any OPP.

For these add another property in OPP-v2, 'opp-next'.

Refer to the bindings for more details.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 130 ++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 07959903ec32..c96dc77121b7 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -72,6 +72,9 @@ properties.
 
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
+- opp-next: It contains a list of phandles to other OPPs, to which we can switch
+  directly from this OPP (Explained later with examples). Missing property means
+  no restriction on switching to other OPPs.
 - turbo-mode: Marks the OPP to be used only for turbo modes.
 - status: Marks the node enabled/disabled.
 
@@ -363,6 +366,133 @@ Example 4: Handling multiple regulators
 	};
 };
 
+Example 5: How to use "opp-next" property ?
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
 
 Deprecated Bindings
 -------------------
-- 
2.3.0.rc0.44.ga94655d

