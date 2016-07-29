From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle states
Date: Fri, 29 Jul 2016 15:56:13 -0600
Message-ID: <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Update DT bindings to describe idle states of PM domains.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[Lina: Added state properties, removed state names, wakeup-latency,
added of_pm_genpd_init() API, pruned commit text]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]
---
 .../devicetree/bindings/power/power_domain.txt     | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7..69aa4e2 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -29,6 +29,10 @@ Optional properties:
    specified by this binding. More details about power domain specifier are
    available in the next section.
 
+- domain-idle-states : A phandle of an idle-state that shall be soaked into a
+                generic domain power state. The idle state definitions are
+                compatible with arm,idle-state specified in [1].
+
 Example:
 
 	power: power-controller@12340000 {
@@ -55,6 +59,39 @@ Example 2:
 		#power-domain-cells = <1>;
 	};
 
+Example 3:
+
+	pm-domains {
+		a57_pd: a57_pd@ {
+			/* will have a57 platform ARM_PD_METHOD_OF_DECLARE*/
+			compatible = "arm,pd","arm,cortex-a57";
+			#power-domain-cells = <0>;
+			idle-states = <&CLUSTER_SLEEP_0>;
+		};
+
+		a53_pd: a53_pd@ {
+			/* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
+			compatible = "arm,pd","arm,cortex-a53";
+			#power-domain-cells = <0>;
+			idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
+		};
+
+		CLUSTER_SLEEP_0: idle-state@0 {
+			compatible = "arm,idle-state";
+			entry-latency-us = <1000>;
+			exit-latency-us = <2000>;
+			residency-us = <10000>;
+		};
+
+		CLUSTER_SLEEP_1: idle-state@1 {
+			compatible = "arm,idle-state";
+			entry-latency-us = <5000>;
+			exit-latency-us = <5000>;
+			residency-us = <100000>;
+		};
+	};
+
+
 The nodes above define two power controllers: 'parent' and 'child'.
 Domains created by the 'child' power controller are subdomains of '0' power
 domain provided by the 'parent' power controller.
@@ -76,3 +113,5 @@ Example:
 The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
+
+[1]. Documentation/devicetree/bindings/arm/idle-states.txt
-- 
2.7.4
