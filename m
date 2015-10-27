From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC v3 2/7] PM / Domains: support idle-states as genpd multiple-state.
Date: Tue, 27 Oct 2015 18:40:51 +0100
Message-ID: <1445967656-28292-3-git-send-email-mtitinger+renesas@baylibre.com>
References: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
In-Reply-To: <20151019205825.GA82426@linaro.org>
References: <20151019205825.GA82426@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lina.iyer@linaro.org
Cc: rjw@rjwysocki.net, khilman@kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Marc Titinger <mtitinger@baylibre.com>

This patch allows cluster-level idle-states to being soaked in as generic
domain power states, in order for the domain governor to chose the most
efficient power state compatible with the device constraints. Similarly,
devices can register power-states into the cluster domain, in a manner
consistent with idle-states.

This is a attempt to address device-retention states for devices that
are not hooked to runtime-pm, but feature a retention state handled by
the same firmware that handles idle-states. For instance a L2 caches.

With Juno, in this example the idle-state 'cluster-sleep-0 ' is known from
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
 .../devicetree/bindings/power/power_domain.txt     |  29 ++++++
 drivers/base/power/domain.c                        | 102 ++++++++++++++++++++-
 include/linux/pm_domain.h                          |   3 +
 3 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7..2657e19 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -29,6 +29,16 @@ Optional properties:
    specified by this binding. More details about power domain specifier are
    available in the next section.
 
+ - cpu-idle-states : a phandle of an idle-state that shall be soaked into a
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
+                        cpu-idle-states = <&CLUSTER_SLEEP_0>;
+                };
+
+                a53_pd: a53_pd@ {
+                        /* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
+                        compatible = "arm,pd","arm,cortex-a53";
+                        #power-domain-cells = <0>;
+                        cpu-idle-states = <&CLUSTER_SLEEP_0>;
+                };
+        };
+
+
 The nodes above define two power controllers: 'parent' and 'child'.
 Domains created by the 'child' power controller are subdomains of '0' power
 domain provided by the 'parent' power controller.
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6b2d771..8512e28 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1345,7 +1345,8 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	else {
 		dev_pm_qos_add_notifier(dev, &gpd_data->nb);
 		atomic_inc(&genpd->usage_count);
-		printk("Add device %d\n", atomic_read(&genpd->usage_count));
+		dev_info(dev, "Add device %d\n",
+					atomic_read(&genpd->usage_count));
 	}
 	return ret;
 }
@@ -1592,7 +1593,7 @@ static int state_cmp(const void *a, const void *b)
 int pm_genpd_insert_state(struct generic_pm_domain *genpd,
 		const struct genpd_power_state *state)
 {
-	int ret = 0;
+	int i, ret = 0;
 	int state_count = genpd->state_count;
 
 	if (IS_ERR_OR_NULL(genpd) || (!state))
@@ -1601,11 +1602,18 @@ int pm_genpd_insert_state(struct generic_pm_domain *genpd,
 	if (state_count >= GENPD_POWER_STATES_MAX)
 		ret = -ENOMEM;
 
+	/* Bail out, this state was already registered.*/
+	for (i = 0; i < state_count; i++)
+		if (!strncmp(state->name, genpd->states[i].name,
+			GENPD_MAX_NAME_SIZE))
+			return 0;
+
 #ifdef CONFIG_PM_ADVANCED_DEBUG
 	/* to save memory, Name allocation will happen if debug is enabled */
 	genpd->states[state_count].name = kstrndup(state->name,
 			GENPD_MAX_NAME_SIZE,
 			GFP_KERNEL);
+
 	if (!genpd->states[state_count].name) {
 		pr_err("%s Failed to allocate state '%s' name.\n",
 				genpd->name, state->name);
@@ -1963,6 +1971,93 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
+
+static int dt_cpuidle_to_genpd_power_state(struct genpd_power_state
+					   *genpd_state,
+					   struct device_node *state_node)
+{
+	int err = 0;
+	u32 latency;
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
+int of_genpd_device_parse_states(struct device_node *np,
+				 struct generic_pm_domain *genpd)
+{
+	struct device_node *state_node;
+	int i, err = 0;
+
+	for (i = 0;; i++) {
+		struct genpd_power_state genpd_state;
+
+		state_node = of_parse_phandle(np, "domain-idle-states", i);
+		if (!state_node)
+			break;
+
+		err = dt_cpuidle_to_genpd_power_state(&genpd_state,
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
@@ -1996,7 +2091,6 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (ret < 0) {
 		if (ret != -ENOENT)
 			return ret;
-
 		/*
 		 * Try legacy Samsung-specific bindings
 		 * (for backwards compatibility of DT ABI)
@@ -2034,6 +2128,8 @@ int genpd_dev_pm_attach(struct device *dev)
 		goto out;
 	}
 
+	of_genpd_device_parse_states(pd_args.np, pd);
+
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 	ret = genpd_poweron(pd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 24621be..48ab3b1 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -248,6 +248,9 @@ struct generic_pm_domain *__of_genpd_xlate_onecell(
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
