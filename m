From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC] OPP: Redefine bindings to overcome shortcomings
Date: Thu,  4 Dec 2014 16:44:03 +0530
Message-ID: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34103 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbaLDLOO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 06:14:14 -0500
Received: by mail-pd0-f174.google.com with SMTP id w10so17413142pde.19
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2014 03:14:14 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, rob.herring@linaro.org, grant.likely@linaro.org, olof@lixom.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rob, et al..

Current OPP (Operating performance point) DT bindings are proven to be
insufficient at multiple instances.

There had been multiple band-aid approaches to get them fixed (The latest one
being: http://www.mail-archive.com/devicetree@vger.kernel.org/msg53398.html).
For obvious reasons Rob rejected them and shown the right path forward. And this
is the first try to get those with a pen and paper.

The shortcomings we are trying to solve here:

- Some kind of compatibility string to probe the right cpufreq driver for
  platforms, when multiple drivers are available. For example: how to choose
  between cpufreq-dt and arm_big_little drivers.

- Getting clock sharing information between CPUs. Single shared clock vs.
  independent clock per core vs. shared clock per cluster.

- Support for turbo modes

- Other per OPP settings: transition latencies, disabled status, etc.?

The below document should be enough to describe how I am trying to fix these.
Please let me know what all I need to fix, surely there would be lots of
obstacles. I am prepared to get beaten up :)

I accept in advance that naming is extremely bad here, I need some suggestions
for sure.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/opp.txt | 147 ++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 74499e5..5efd8d4 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -4,6 +4,153 @@ SoCs have a standard set of tuples consisting of frequency and
 voltage pairs that the device will support per voltage domain. These
 are called Operating Performance Points or OPPs.
 
+This documents defines OPP bindings with its required/optional properties.
+OPPs can be defined for any device, this file uses CPU device as an example to
+illustrate how to define OPPs.
+
+linux,operating-points, opp-lists and opps:
+
+- linux,operating-points:
+  Container of all OPP nodes.
+
+  Required properties:
+  - opp nodes (explained below)
+
+  Optional properties:
+  - compatible: allow OPPs to express their compatibility with devices
+
+
+- opp-list@*:
+  List of nodes defining performance points. Following belong to the nodes
+  within the opp-lists.
+
+  Required properties:
+  - frequency-kHz: Frequency in kHz
+  - voltage-uV: voltage in micro Volts
+
+  Optional properties:
+  - turbo-mode: Marks the volt-freq pair as turbo pair.
+  - status: Marks the node enabled/disabled.
+
+
+- opp@*:
+  Operating performance point node per device. Multiple devices sharing it can
+  use its phandle in their 'opp' property.
+
+  Required properties:
+  - opp-list: phandle to opp-list defined above.
+
+  Optional properties:
+  - clocks: Tuple of clock providers
+  - clock-names: Clock names
+  - opp-supply: phandle to the parent supply/regulator node
+  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
+  - clock-latency: Specify the possible maximum transition latency for clock,
+    in unit of nanoseconds.
+
+Example: Multi-cluster system with separate clock lines for clusters. All CPUs
+         in the clusters share same clock lines.
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		linux,operating-points {
+			compatible = "linux,cpufreq-dt";
+
+			opp-list0: opp-list@0 {
+				{
+					frequency-kHz = <1000000>;
+					voltage-uV = <975000>;
+					status = "okay";
+				};
+				{
+					frequency-kHz = <1100000>;
+					voltage-uV = <1000000>;
+					status = "okay";
+				};
+				{
+					frequency-kHz = <1200000>;
+					voltage-uV = <1025000>;
+					status = "okay";
+					turbo-mode;
+				};
+			};
+
+			opp-list1: opp-list@1 {
+				{
+					frequency-kHz = <1300000>;
+					voltage-uV = <1050000>;
+					status = "okay";
+				};
+				{
+					frequency-kHz = <1400000>;
+					voltage-uV = <1075000>;
+					status = "disabled";
+				};
+				{
+					frequency-kHz = <1500000>;
+					voltage-uV = <1100000>;
+					status = "okay";
+					turbo-mode;
+				};
+			};
+
+			opp0: opp@0 {
+				clocks = <&clk-controller 0>;
+				clock-names = "cpu";
+				opp-supply = <&cpu-supply0>;
+				voltage-tolerance = <2>; /* percentage */
+				clock-latency = <300000>;
+				opp-list = <&opp-list0>;
+			};
+
+			opp1: opp@1 {
+				clocks = <&clk-controller 1>;
+				clock-names = "cpu";
+				opp-supply = <&cpu-supply1>;
+				voltage-tolerance = <2>; /* percentage */
+				clock-latency = <400000>;
+				opp-list = <&opp-list1>;
+			};
+		};
+
+		cpu@0 {
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+			next-level-cache = <&L2>;
+			opps = <opp0>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			next-level-cache = <&L2>;
+			opps = <opp0>;
+		};
+
+		cpu@100 {
+			compatible = "arm,cortex-a15";
+			reg = <100>;
+			next-level-cache = <&L2>;
+			opps = <opp1>;
+		};
+
+		cpu@101 {
+			compatible = "arm,cortex-a15";
+			reg = <101>;
+			next-level-cache = <&L2>;
+			opps = <opp1>;
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
2.0.3.693.g996b0fd

