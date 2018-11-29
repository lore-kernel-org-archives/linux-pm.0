From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v10 23/27] drivers: firmware: psci: Manage runtime PM in the idle path for CPUs
Date: Thu, 29 Nov 2018 18:46:56 +0100
Message-ID: <20181129174700.16585-24-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the hierarchical CPU topology layout is used in DT, let's allow the
CPU to be power managed through its PM domain and via runtime PM. In other
words, let's deploy runtime PM support to the PSCI driver during idle
management of the CPU.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch: Replaces the earlier patch "kernel/cpu_pm: Manage runtime
	  PM in the idle path for CPUs". In the end it seemed like a better
	  idea to start with something specific to PSCI, rather than (ab?)using
	  the generic functions cpu_pm_enter|exit().
	- Do runtime PM get/put for the deepest idle state for the CPU.

---
 drivers/firmware/psci/psci.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 94cd0431b004..b03bccce0a5d 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -20,6 +20,7 @@
 #include <linux/linkage.h>
 #include <linux/of.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
@@ -319,6 +320,7 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+static DEFINE_PER_CPU_READ_MOSTLY(u32, psci_rpm_state_id);
 
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
@@ -369,6 +371,9 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		ret = psci_dt_attach_cpu(cpu);
 		if (ret)
 			goto free_mem;
+
+		/* Store index of deepest state to later for runtime PM. */
+		per_cpu(psci_rpm_state_id, cpu) = drv->state_count - 1;
 	}
 
 	/* Idle states parsed correctly, initialize per-cpu pointer */
@@ -466,7 +471,9 @@ int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
 	u32 *state = __this_cpu_read(psci_power_state);
-	u32 composite_state = state[index - 1] | psci_get_domain_state();
+	u32 composite_state, rpm_state_id;
+	bool runtime_pm = false;
+	struct device *dev = NULL;
 
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
@@ -475,11 +482,29 @@ int psci_cpu_suspend_enter(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
+	/*
+	 * Do runtime PM if we are using the hierarchical CPU toplogy, but only
+	 * when cpuidle have selected the deepest idle state for the CPU.
+	 */
+	if (psci_dt_topology) {
+		rpm_state_id = __this_cpu_read(psci_rpm_state_id);
+		runtime_pm = rpm_state_id == index;
+		if (runtime_pm) {
+			dev = get_cpu_device(smp_processor_id());
+			pm_runtime_put_sync_suspend(dev);
+		}
+	}
+
+	composite_state = state[index - 1] | psci_get_domain_state();
+
 	if (!psci_power_state_loses_context(composite_state))
 		ret = psci_ops.cpu_suspend(composite_state, 0);
 	else
 		ret = cpu_suspend(index, psci_suspend_finisher);
 
+	if (runtime_pm)
+		pm_runtime_get_sync(dev);
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_set_domain_state(0);
 
-- 
2.17.1
