From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple regulators per device
Date: Wed, 26 Oct 2016 12:02:56 +0530
Message-ID: <28119b44689921f3c3cc00be49bff2bb99b32162.1477463128.git.viresh.kumar@linaro.org>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33666 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbcJZGdp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 02:33:45 -0400
Received: by mail-pf0-f180.google.com with SMTP id 197so10028048pfu.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2016 23:33:44 -0700 (PDT)
In-Reply-To: <cover.1477463128.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1477463128.git.viresh.kumar@linaro.org>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <vireshk@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org

On certain platforms (like TI), DVFS for a single device (CPU) requires
configuring multiple power supplies.

The OPP bindings already contains binding and example to explain this
case, but it isn't sufficient. For example, there is no way for the code
parsing these bindings to know which voltage values belong to which
power supply. Also its not possible to know the order in which the
supplies need to be configured while switching OPPs.

This patch tries to clarify on those details and does some minor changes
as well.

Note that the bindings do not specify the order in which the regulators
need to be programmed and the order in which the entries are added for
the supplies.

The user of the bindings (like the kernel) shall know these details
already and the DT is responsible to supply only the readings for the
regulators.

Cc: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index ee91cbdd95ee..af476df510f1 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -86,8 +86,13 @@ properties.
   Single entry is for target voltage and three entries are for <target min max>
   voltages.
 
-  Entries for multiple regulators must be present in the same order as
-  regulators are specified in device's DT node.
+  Entries for multiple regulators shall be provided in the same field separated
+  by angular brackets <>. The OPP binding doesn't provide any provisions to
+  relate the values to their power supplies or the order in which the supplies
+  need to be configured.
+
+  Entries for all regulators shall be of the same size, i.e. either all use a
+  single value or triplets.
 
 - opp-microvolt-<name>: Named opp-microvolt property. This is exactly similar to
   the above opp-microvolt property, but allows multiple voltage ranges to be
@@ -104,10 +109,12 @@ properties.
 
   Should only be set if opp-microvolt is set for the OPP.
 
-  Entries for multiple regulators must be present in the same order as
-  regulators are specified in device's DT node. If this property isn't required
-  for few regulators, then this should be marked as zero for them. If it isn't
-  required for any regulator, then this property need not be present.
+  Entries for multiple regulators shall be provided in the same field separated
+  by angular brackets <>. If current values aren't required for a regulator,
+  then it shall be filled with 0. If current values aren't required for any of
+  the regulators, then this field is not required. The OPP binding doesn't
+  provide any provisions to relate the values to their power supplies or the
+  order in which the supplies need to be configured.
 
 - opp-microamp-<name>: Named opp-microamp property. Similar to
   opp-microvolt-<name> property, but for microamp instead.
@@ -386,10 +393,12 @@ Example 4: Handling multiple regulators
 / {
 	cpus {
 		cpu@0 {
-			compatible = "arm,cortex-a7";
+			compatible = "vendor,cpu-type";
 			...
 
-			cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
+			vcc0-supply = <&cpu_supply0>;
+			vcc1-supply = <&cpu_supply1>;
+			vcc2-supply = <&cpu_supply2>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
-- 
2.7.1.410.g6faf27b

