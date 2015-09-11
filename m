From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/16] PM / OPP: Add 'opp-microvolt-triplets' binding
Date: Fri, 11 Sep 2015 17:31:58 +0530
Message-ID: <254dd353453a495bb0921fa23e430428484f36fa.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

If 'opp-microvolt' is used to specify values for multiple regulators,
then we need this additional information to know if the values passed
should be treated as <target> or <target min max>.

This is because, DT doesn't differentiate between these two styles:

prop = <x>, <y>, <z>;
prop = <x y z>;

Cc: devicetree@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 8759bc4783ed..719603b87353 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -76,6 +76,16 @@ This describes the OPPs belonging to a device. This node can have following
   present here is important, as that should match the order in which values are
   present in 'opp-microvolt' and 'opp-microamp' properties.
 
+- opp-microvolt-triplets: This is a required property, only if multiple supplies
+  are available for the device. Otherwise it is ignored.
+
+  'opp-microvolt' can be present in two forms: <target> or <target min max>, per
+  power-supply. 'opp-microvolt-triplets' property is used to find the form in
+  which 'opp-microvolt' is present.
+
+  If present, then 'opp-microvolt' must be present in <target min max> form,
+  else in <target> form.
+
 - OPP nodes: One or more OPP nodes describing voltage-current-frequency
   combinations. Their name isn't significant but their phandle can be used to
   reference an OPP.
@@ -403,6 +413,8 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
+		opp-microvolt-triplets;
+
 		opp00 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
@@ -416,6 +428,8 @@ Example 4: Handling multiple regulators
 
 		/* OR */
 
+		opp-microvolt-triplets;
+
 		opp00 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <970000 975000 985000>, /* Supply 0 */
-- 
2.4.0
