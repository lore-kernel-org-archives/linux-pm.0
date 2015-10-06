From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC v2 3/6] PM / Domains: introduce power-states consistent with c-states.
Date: Tue,  6 Oct 2015 16:27:42 +0200
Message-ID: <1444141665-18534-4-git-send-email-mtitinger+renesas@baylibre.com>
References: <20151006022702.GA78570@linaro.org>
 <1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@kernel.org, rjw@rjwysocki.net
Cc: lina.iyer@linaro.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

This patch allows cluster-level C-states to being soaked in as generic
domain power states, in order for the domain governor to chose the most
efficient power state compatible with the device constraints. Similarly,
devices can register power-states into the cluster domain, in a manner
consistent with c-states.

With Juno, in this example the c-state 'cluster-sleep-0 ' is known from
each cluster generic domain, as the deepest sate.

cat /sys/kernel/debug/pm_genpd/*

  Domain             State name        Enter (ns) / Exit (ns)
-------------------------------------------------------------
a53_pd               cluster-sleep-0      1500000 / 800000
a57_pd               cluster-sleep-0      1500000 / 800000

    domain                      status pstate     slaves
           /device                                      runtime status
-----------------------------------------------------------------------
a53_pd                          on
    /devices/system/cpu/cpu0                            active
    /devices/system/cpu/cpu3                            suspended
    /devices/system/cpu/cpu4                            suspended
    /devices/system/cpu/cpu5                            suspended
    /devices/platform/D1                                suspended
a57_pd                          cluster-sleep-0
    /devices/system/cpu/cpu1                            suspended
    /devices/system/cpu/cpu2                            suspended

Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
---
 .../devicetree/bindings/arm/idle-states.txt        |  21 ++++-
 .../devicetree/bindings/power/power_domain.txt     |  29 ++++++
 arch/arm64/boot/dts/arm/juno.dts                   |  10 ++-
 drivers/base/power/cpu-pd.c                        |   5 ++
 drivers/base/power/domain.c                        | 100 +++++++++++++++++++++
 include/linux/pm_domain.h                          |   3 +
 6 files changed, 163 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index a8274ea..18fdeaf 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -270,7 +270,8 @@ follows:
 	- compatible
 		Usage: Required
 		Value type: <stringlist>
-		Definition: Must be "arm,idle-state".
+		Definition: Must be "arm,idle-state",
+			or "arm,power-state" (see section 5)
 
 	- local-timer-stop
 		Usage: See definition
@@ -680,7 +681,23 @@ cpus {
 };
 
 ===========================================
-5 - References
+5 - power state
+===========================================
+
+Device in a generic power domain may expose an intermediate retention
+state that can be opted to by the domain governor when the last-man
+CPU is powered off. Those power-states will not be entered by the
+cpuidle.ops based on a state index, but instead can be elected by the
+domain governor and entered to by the generic domain.
+
+ - compatible
+                Usage: Required
+                Value type: <stringlist>
+                Definition: Must be "arm,power-state".
+
+
+===========================================
+6 - References
 ===========================================
 
 [1] ARM Linux Kernel documentation - CPUs bindings
diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 0f8ed37..d437385 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -29,6 +29,16 @@ Optional properties:
    specified by this binding. More details about power domain specifier are
    available in the next section.
 
+ - power-states : a phandle of an idle-state that shall be soaked into a
+		  generic domain power state.
+   CPU domains: Deep c-states that match a cluster power-off can be delegated to the
+   generic power domain. Device other than CPUs may have register intermediate
+   power states in the same domain. The domain governor can do a good job in
+   electing a power state when the last cpu is powered off as devices in the
+   same genpd may register intermediate states.
+   Devices : a device may register an intermediate c-state matching a memory
+   retention feature for instance.
+
 Example:
 
 	power: power-controller@12340000 {
@@ -55,6 +65,25 @@ Example 2:
 		#power-domain-cells = <1>;
 	};
 
+Example 3:
+
+        pm-domains {
+                a57_pd: a57_pd@ {
+                        /* will have a57 platform ARM_PD_METHOD_OF_DECLARE*/
+                        compatible = "arm,pd","arm,cortex-a57";
+                        #power-domain-cells = <0>;
+                        power-states = <&CLUSTER_SLEEP_0>;
+                };
+
+                a53_pd: a53_pd@ {
+                        /* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
+                        compatible = "arm,pd","arm,cortex-a53";
+                        #power-domain-cells = <0>;
+                        power-states = <&CLUSTER_SLEEP_0>;
+                };
+        };
+
+
 The nodes above define two power controllers: 'parent' and 'child'.
 Domains created by the 'child' power controller are subdomains of '0' power
 domain provided by the 'parent' power controller.
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 499f035..cadc5de 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -47,7 +47,7 @@
 			};
 
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
-				compatible = "arm,idle-state";
+				compatible = "arm,idle-state","arm,power-state";
 				arm,psci-suspend-param = <0x1010000>;
 				local-timer-stop;
 				entry-latency-us = <800>;
@@ -128,13 +128,17 @@
 	pm-domains {
 
 		a57_pd: a57_pd@ {
-			compatible = "arm,pd";
+			/* will have the a53 platform ARM_PD_METHOD_OF_DECLARE*/
+			compatible = "arm,pd","arm,cortex-a57";
 			#power-domain-cells = <0>;
+			power-states = <&CLUSTER_SLEEP_0>;
 		};
 
 		a53_pd: a53_pd@ {
-			compatible = "arm,pd";
+			/* will have the a53 platform ARM_PD_METHOD_OF_DECLARE*/
+			compatible = "arm,pd","arm,cortex-a57";
 			#power-domain-cells = <0>;
+			power-states = <&CLUSTER_SLEEP_0>;
 		};
 	};
 
diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
index 5f30025..3c4cb12 100644
--- a/drivers/base/power/cpu-pd.c
+++ b/drivers/base/power/cpu-pd.c
@@ -163,6 +163,11 @@ int of_register_cpu_pm_domain(struct device_node *dn,
 	pm_genpd_init(pd->genpd, &simple_qos_governor, false);
 	of_genpd_add_provider_simple(dn, pd->genpd);
 
+	/* if a cpuidle-state is declared in this domain node, it will
+	 * be the domain's job to enter/exit this state, if the device
+	 * subdomain constraints are compatible */
+	of_genpd_device_parse_states(dn, &pd->genpd);
+
 	/* Attach the CPUs to the CPU PM domain */
 	return of_pm_domain_attach_cpus();
 }
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e5f4c00b..1ca28a2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2156,6 +2156,104 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
+static int dt_cpuidle_to_genpd_power_state(struct genpd_power_state
+					   *genpd_state,
+					   const struct of_device_id *matches,
+					   struct device_node *state_node)
+{
+	const struct of_device_id *match_id;
+	int err = 0;
+	u32 latency;
+
+	match_id = of_match_node(matches, state_node);
+	if (!match_id)
+		return -ENODEV;
+
+	err = of_property_read_u32(state_node, "wakeup-latency-us", &latency);
+	if (err) {
+		u32 entry_latency, exit_latency;
+
+		err = of_property_read_u32(state_node, "entry-latency-us",
+					   &entry_latency);
+		if (err) {
+			pr_debug(" * %s missing entry-latency-us property\n",
+				 state_node->full_name);
+			return -EINVAL;
+		}
+
+		err = of_property_read_u32(state_node, "exit-latency-us",
+					   &exit_latency);
+		if (err) {
+			pr_debug(" * %s missing exit-latency-us property\n",
+				 state_node->full_name);
+			return -EINVAL;
+		}
+		/*
+		 * If wakeup-latency-us is missing, default to entry+exit
+		 * latencies as defined in idle states bindings
+		 */
+		latency = entry_latency + exit_latency;
+	}
+
+	genpd_state->power_on_latency_ns = 1000 * latency;
+
+	err = of_property_read_u32(state_node, "entry-latency-us", &latency);
+	if (err) {
+		pr_debug(" * %s missing min-residency-us property\n",
+			 state_node->full_name);
+		return -EINVAL;
+	}
+
+	genpd_state->power_off_latency_ns = 1000 * latency;
+
+	return 0;
+}
+
+static const struct of_device_id power_state_match[] = {
+	{.compatible = "arm,power-state",
+	 },
+};
+
+int of_genpd_device_parse_states(struct device_node *np,
+				 struct generic_pm_domain *genpd)
+{
+	struct device_node *state_node;
+	int i, err = 0;
+
+	for (i = 0;; i++) {
+		struct genpd_power_state genpd_state;
+
+		state_node = of_parse_phandle(np, "power-states", i);
+		if (!state_node)
+			break;
+
+		err = dt_cpuidle_to_genpd_power_state(&genpd_state,
+						      power_state_match,
+						      state_node);
+		if (err) {
+			pr_err
+			    ("Parsing idle state node %s failed with err %d\n",
+			     state_node->full_name, err);
+			err = -EINVAL;
+			break;
+		}
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+		genpd_state.name = kstrndup(state_node->name,
+					    GENPD_MAX_NAME_SIZE, GFP_KERNEL);
+		if (!genpd_state.name)
+			err = -ENOMEM;
+#endif
+		of_node_put(state_node);
+		err = pm_genpd_insert_state(genpd, &genpd_state);
+		if (err)
+			break;
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+		kfree(genpd_state.name);
+#endif
+	}
+	return err;
+}
+
 /**
  * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
  * @dev: Device to attach.
@@ -2224,6 +2322,8 @@ int genpd_dev_pm_attach(struct device *dev)
 		return ret;
 	}
 
+	of_genpd_device_parse_states(dev->of_node, pd);
+
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 	pm_genpd_poweron(pd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 8a4eab0..791a8ac 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -302,6 +302,9 @@ struct generic_pm_domain *__of_genpd_xlate_onecell(
 					struct of_phandle_args *genpdspec,
 					void *data);
 
+int of_genpd_device_parse_states(struct device_node *np,
+	struct generic_pm_domain *genpd);
+
 int genpd_dev_pm_attach(struct device *dev);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int __of_genpd_add_provider(struct device_node *np,
-- 
1.9.1
