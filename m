From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V6 02/10] PM / OPP: Reword binding supporting multiple regulators per device
Date: Wed, 30 Nov 2016 10:44:05 +0530
Message-ID: <bc027ba0694dabe839da75325d6a901434944f9e.1480481312.git.viresh.kumar@linaro.org>
References: <cover.1480481312.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34555 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbcK3FOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 00:14:35 -0500
Received: by mail-pg0-f43.google.com with SMTP id x23so77790096pgx.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Nov 2016 21:14:34 -0800 (PST)
In-Reply-To: <cover.1480481312.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1480481312.git.viresh.kumar@linaro.org>
References: <cover.1480481312.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

On certain platforms (like TI), DVFS for a single device (CPU) requires
configuring multiple power supplies.

The OPP bindings already contains binding and example to explain this
case, but it isn't sufficient.

- There is no way for the code parsing these bindings to know which
  voltage values belong to which power supply.

- It is not possible to know the order in which the supplies need to be
  configured while switching OPPs.

This patch clarifies on those details by mentioning that such
information is left for the implementation specific bindings to explain.
They may want to hardcode such details or implement their own properties
to get such information. All implementations using multiple regulators
for their devices must provide a binding document explaining their
implementation.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index f0239f68d186..9f5ca4457b5f 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -86,8 +86,14 @@ properties.
   Single entry is for target voltage and three entries are for <target min max>
   voltages.
 
-  Entries for multiple regulators must be present in the same order as
-  regulators are specified in device's DT node.
+  Entries for multiple regulators shall be provided in the same field separated
+  by angular brackets <>. The OPP binding doesn't provide any provisions to
+  relate the values to their power supplies or the order in which the supplies
+  need to be configured and that is left for the implementation specific
+  binding.
+
+  Entries for all regulators shall be of the same size, i.e. either all use a
+  single value or triplets.
 
 - opp-microvolt-<name>: Named opp-microvolt property. This is exactly similar to
   the above opp-microvolt property, but allows multiple voltage ranges to be
@@ -104,10 +110,13 @@ properties.
 
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
+  order in which the supplies need to be configured and that is left for the
+  implementation specific binding.
 
 - opp-microamp-<name>: Named opp-microamp property. Similar to
   opp-microvolt-<name> property, but for microamp instead.
-- 
2.7.1.410.g6faf27b

