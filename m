From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 02/16] dt/bindings: Update binding for PM domain idle states
Date: Thu, 25 Aug 2016 14:03:11 -0600
Message-ID: <1472155405-41841-3-git-send-email-lina.iyer@linaro.org>
References: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, brendan.jackman@arm.com, sudeep.holla@arm.com, andy.gross@linaro.org, Lina Iyer <lina.iyer@linaro.org>
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
 .../devicetree/bindings/power/power_domain.txt     | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7..4960486 100644
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
@@ -59,6 +63,57 @@ The nodes above define two power controllers: 'parent' and 'child'.
 Domains created by the 'child' power controller are subdomains of '0' power
 domain provided by the 'parent' power controller.
 
+Example 3: ARM v7 style CPU PM domains (Linux domain controller)
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7", "arm,armv7";
+			reg = <0x0>;
+			power-domains = <&a7_pd>;
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15", "arm,armv7";
+			reg = <0x0>;
+			power-domains = <&a15_pd>;
+		};
+	};
+
+	pm-domains {
+		a15_pd: a15_pd {
+			/* will have A15 platform ARM_PD_METHOD_OF_DECLARE*/
+			compatible = "arm,cortex-a15";
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
+		};
+
+		a7_pd: a7_pd {
+			/* will have a A7 platform ARM_PD_METHOD_OF_DECLARE*/
+			compatible = "arm,cortex-a7";
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
+		};
+
+		CLUSTER_SLEEP_0: state0 {
+			compatible = "arm,idle-state";
+			entry-latency-us = <1000>;
+			exit-latency-us = <2000>;
+			min-residency-us = <10000>;
+		};
+
+		CLUSTER_SLEEP_1: state1 {
+			compatible = "arm,idle-state";
+			entry-latency-us = <5000>;
+			exit-latency-us = <5000>;
+			min-residency-us = <100000>;
+		};
+	};
+
 ==PM domain consumers==
 
 Required properties:
@@ -76,3 +131,5 @@ Example:
 The node above defines a typical PM domain consumer device, which is located
 inside a PM domain with index 0 of a power controller represented by a node
 with the label "power".
+
+[1]. Documentation/devicetree/bindings/arm/idle-states.txt
-- 
2.7.4
