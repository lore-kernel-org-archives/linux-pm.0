From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v10 19/27] drivers: firmware: psci: Add hierarchical domain idle states converter
Date: Thu, 29 Nov 2018 18:46:52 +0100
Message-ID: <20181129174700.16585-20-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If the hierarchical CPU topology is used, but the OS initiated mode isn't
supported, we rely solely on the regular cpuidle framework to manage the
idle state selection.

For this reason, introduce a new PSCI DT helper function,
psci_dt_pm_domains_parse_states(), which converts the hierarchically
described domain idle states, into regular flattened cpuidle states.

During the conversion, let's also insert the converted states into the
cpuidle driver's array of idle states, as to enables the cpuidle framework
to manage them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch.

---
 drivers/firmware/psci/psci.h           |   2 +
 drivers/firmware/psci/psci_pm_domain.c | 108 +++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index 8cf6d7206fab..05af462cc96e 100644
--- a/drivers/firmware/psci/psci.h
+++ b/drivers/firmware/psci/psci.h
@@ -13,6 +13,8 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 
 #ifdef CONFIG_CPU_IDLE
 int psci_dt_init_pm_domains(struct device_node *np);
+int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, u32 *psci_states);
 #else
 static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
 #endif
diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
index d0dc38e96f85..6c9d6a644c7f 100644
--- a/drivers/firmware/psci/psci_pm_domain.c
+++ b/drivers/firmware/psci/psci_pm_domain.c
@@ -14,6 +14,10 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+
+#include <asm/cpuidle.h>
 
 #include "psci.h"
 
@@ -97,6 +101,53 @@ static int psci_pd_parse_states(struct device_node *np,
 	return ret;
 }
 
+static int psci_pd_enter_pc(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int idx)
+{
+	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, idx);
+}
+
+static void psci_pd_enter_s2idle_pc(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int idx)
+{
+	psci_pd_enter_pc(dev, drv, idx);
+}
+
+static void psci_pd_convert_states(struct cpuidle_state *idle_state,
+			u32 *psci_state, struct genpd_power_state *state)
+{
+	u32 *state_data = state->data;
+	u64 target_residency_us = state->residency_ns;
+	u64 exit_latency_us = state->power_on_latency_ns +
+			state->power_off_latency_ns;
+
+	*psci_state = *state_data;
+	do_div(target_residency_us, 1000);
+	idle_state->target_residency = target_residency_us;
+	do_div(exit_latency_us, 1000);
+	idle_state->exit_latency = exit_latency_us;
+	idle_state->enter = &psci_pd_enter_pc;
+	idle_state->enter_s2idle = &psci_pd_enter_s2idle_pc;
+	idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+
+	strncpy(idle_state->name, to_of_node(state->fwnode)->name,
+		CPUIDLE_NAME_LEN - 1);
+	strncpy(idle_state->desc, to_of_node(state->fwnode)->name,
+		CPUIDLE_NAME_LEN - 1);
+}
+
+static bool psci_pd_is_provider(struct device_node *np)
+{
+	struct psci_pd_provider *pd_prov, *it;
+
+	list_for_each_entry_safe(pd_prov, it, &psci_pd_providers, link) {
+		if (pd_prov->node == np)
+			return true;
+	}
+
+	return false;
+}
+
 static int psci_pd_init(struct device_node *np)
 {
 	struct generic_pm_domain *pd;
@@ -259,4 +310,61 @@ int psci_dt_init_pm_domains(struct device_node *np)
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
 	return ret;
 }
+
+int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, u32 *psci_states)
+{
+	struct genpd_power_state *pd_states;
+	struct of_phandle_args args;
+	int ret, pd_state_count, i, idx, psci_idx = drv->state_count - 2;
+	struct device_node *np = of_node_get(cpu_node);
+
+	/* Walk the CPU topology to find compatible domain idle states. */
+	while (np) {
+		ret = of_parse_phandle_with_args(np, "power-domains",
+					"#power-domain-cells", 0, &args);
+		of_node_put(np);
+		if (ret)
+			return 0;
+
+		np = args.np;
+
+		/* Verify that the node represents a psci pd provider. */
+		if (!psci_pd_is_provider(np)) {
+			of_node_put(np);
+			return 0;
+		}
+
+		/* Parse for compatible domain idle states. */
+		ret = psci_pd_parse_states(np, &pd_states, &pd_state_count);
+		if (ret) {
+			of_node_put(np);
+			return ret;
+		}
+
+		i = 0;
+		idx = drv->state_count;
+		while (i < pd_state_count && idx < CPUIDLE_STATE_MAX) {
+			psci_pd_convert_states(&drv->states[idx + i],
+				&psci_states[idx - 1 + i], &pd_states[i]);
+
+			/*
+			 * In the hierarchical CPU topology the master PM domain
+			 * idle state's DT property, "arm,psci-suspend-param",
+			 * don't contain the bits for the idle state of the CPU.
+			 * Take that into account here.
+			 */
+			psci_states[idx - 1 + i] |= psci_states[psci_idx];
+			pr_debug("psci-power-state %#x index %d\n",
+				psci_states[idx - 1 + i], idx - 1 + i);
+
+			kfree(pd_states[i].data);
+			i++;
+		}
+		drv->state_count += i;
+		kfree(pd_states);
+	}
+
+	return 0;
+}
 #endif
-- 
2.17.1
