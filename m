From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 02/27] PM / Domains: Allow domain power states to be read from DT
Date: Tue, 17 Nov 2015 15:37:26 -0700
Message-ID: <1447799871-56374-3-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Marc Titinger <mtitinger+renesas@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Marc Titinger <mtitinger+renesas@baylibre.com>

From: Marc Titinger <mtitinger@baylibre.com>

This patch allows cluster-level idle-states to being soaked in as
generic domain power states, in order for the domain governor to chose
the most efficient power state compatible with the device constraints.
Similarly, devices can register power-states into the cluster domain, in
a manner consistent with idle-states.

This is a attempt to address device-retention states for devices that
are not hooked to runtime-pm, but feature a retention state handled by
the same firmware that handles idle-states. For instance a L2 caches.

With Juno, in this example the idle-state 'cluster-sleep-0 ' is known
from each cluster generic domain, as the deepest sate.

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
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[Lina: removed dependency on dynamic states, simplified initalization,
added of_pm_genpd_init() API]
---
 .../devicetree/bindings/power/power_domain.txt     |  63 ++++++++++
 drivers/base/power/domain.c                        | 128 +++++++++++++++++++++
 include/linux/pm_domain.h                          |   6 +
 3 files changed, 197 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 025b5e7..e2f542e 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -29,6 +29,44 @@ Optional properties:
    specified by this binding. More details about power domain specifier are
    available in the next section.
 
+- power-states : A phandle of an idle-state that shall be soaked into a
+                generic domain power state. The power-state shall be
+		compatible with "linux,domain-state".
+
+==Power state==
+
+A PM domain power state describes an idle state of a domain and must be
+have the following properties -
+
+	- compatible
+		Usage: Required
+		Value type: <stringlist>
+		Definition: Must be "linux,domain-state"
+
+	- entry-latency-us
+		Usage: Not required if wakeup-latency-us is provided.
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing worst case latency in
+		microseconds required to enter the idle state.
+		The exit-latency-us duration may be guaranteed
+		only after entry-latency-us has passed.
+
+	- exit-latency-us
+		Usage: Not required if wakeup-latency-us is provided.
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing worst case latency
+		in microseconds required to exit the idle state.
+
+	- wakeup-latency-us:
+		Usage: Not required if entry-latency-us and exit-latency-us
+		are provided.
+		Value type: <prop-encoded-array>
+		Definition: u32 value representing maximum delay between the
+		signaling the wakeup of the domain and the domain resuming
+		regular operation.
+		If omitted, this is assumed to be equal to:
+			entry-latency-us + exit-latency-us
+
 Example:
 
 	power: power-controller@12340000 {
@@ -55,6 +93,31 @@ Example 2:
 		#power-domain-cells = <1>;
 	};
 
+Example 3:
+
+	pm-domains {
+		a57_pd: a57_pd@ {
+			/* will have a57 platform ARM_PD_METHOD_OF_DECLARE*/
+			compatible = "arm,pd","arm,cortex-a57";
+			#power-domain-cells = <0>;
+			power-states = <&CLUSTER_SLEEP_0>;
+		};
+
+		a53_pd: a53_pd@ {
+			/* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
+			compatible = "arm,pd","arm,cortex-a53";
+			#power-domain-cells = <0>;
+			power-states = <&CLUSTER_SLEEP_0>;
+		};
+
+		CLUSTER_SLEEP_0: power-state@0 {
+			compatible = "pm-domain,power-state";
+			entry-latency-us = <1000>;
+			exit-latency-us = <2000>;
+		};
+	};
+
+
 The nodes above define two power controllers: 'parent' and 'child'.
 Domains created by the 'child' power controller are subdomains of '0' power
 domain provided by the 'parent' power controller.
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3242854..fe1be88 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -35,6 +35,7 @@
 })
 
 #define GENPD_MAX_NAME_SIZE 20
+#define GENPD_MAX_DOMAIN_STATES 10
 
 static int pm_genpd_alloc_states_names(struct generic_pm_domain *genpd,
 				       const struct genpd_power_state *st,
@@ -1515,6 +1516,105 @@ static int pm_genpd_default_restore_state(struct device *dev)
 	return cb ? cb(dev) : 0;
 }
 
+static const struct of_device_id power_state_match[] = {
+	{ .compatible = "linux,domain-state" },
+	{ }
+};
+
+static int of_get_genpd_power_state(struct genpd_power_state *genpd_state,
+					   struct device_node *state_node)
+{
+	const struct of_device_id *match_id;
+	int err = 0;
+	u32 latency;
+
+	match_id = of_match_node(power_state_match, state_node);
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
+static int of_genpd_device_parse_states(struct device_node *np,
+				 struct genpd_power_state *genpd_states,
+				 int *state_count)
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
+		if (i == GENPD_MAX_DOMAIN_STATES) {
+			err = -ENOMEM;
+			break;
+		}
+
+		err = of_get_genpd_power_state(&genpd_state, state_node);
+		if (err) {
+			pr_err
+			    ("Parsing idle state node %s failed with err %d\n",
+			     state_node->full_name, err);
+			err = -EINVAL;
+			break;
+		}
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+		genpd_state.name = kstrndup(state_node->full_name,
+					    GENPD_MAX_NAME_SIZE, GFP_KERNEL);
+		if (!genpd_state.name)
+			err = -ENOMEM;
+#endif
+		of_node_put(state_node);
+		memcpy(&genpd_states[i], &genpd_state, sizeof(genpd_state));
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+		kfree(genpd_state.name);
+#endif
+	}
+	*state_count = i;
+	return err;
+}
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1596,6 +1696,34 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
+int of_pm_genpd_init(struct device_node *dn, struct generic_pm_domain *genpd,
+		   struct dev_power_governor *gov, bool is_off)
+{
+	struct genpd_power_state states[GENPD_MAX_DOMAIN_STATES] = { { 0 } };
+	int state_count = GENPD_MAX_DOMAIN_STATES;
+	int ret;
+
+	if (IS_ERR_OR_NULL(genpd))
+		return -EINVAL;
+
+	ret = of_genpd_device_parse_states(dn, states, &state_count);
+	if (ret) {
+		pr_err("Error parsing genpd states for %s\n", genpd->name);
+		return ret;
+	}
+
+	ret = genpd_alloc_states_data(genpd, states, state_count);
+	if (ret) {
+		pr_err("Failed to allocate states for %s\n", genpd->name);
+		return ret;
+	}
+
+	pm_genpd_init(genpd, gov, is_off);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pm_genpd_init);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 /*
  * Device Tree based PM domain providers.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 11763cf..e425911 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -213,6 +213,8 @@ struct generic_pm_domain *__of_genpd_xlate_onecell(
 					void *data);
 
 int genpd_dev_pm_attach(struct device *dev);
+int of_pm_genpd_init(struct device_node *dn, struct generic_pm_domain *genpd,
+		   struct dev_power_governor *gov, bool is_off);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int __of_genpd_add_provider(struct device_node *np,
 					genpd_xlate_t xlate, void *data)
@@ -234,6 +236,10 @@ static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return -ENODEV;
 }
+
+static inline int of_pm_genpd_init(struct device_node *dn,
+		struct generic_pm_domain *genpd,
+		struct dev_power_governor *gov, bool is_off) {}
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 static inline int of_genpd_add_provider_simple(struct device_node *np,
-- 
2.1.4
