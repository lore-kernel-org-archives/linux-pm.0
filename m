From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 13/18] drivers: firmware: psci: Attach the CPU's device to its
 PM domain
Date: Mon, 13 May 2019 21:22:55 +0200
Message-ID: <20190513192300.653-14-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Tony Lindgren <tony@atomide.com>, Lina Iyer <ilina@codeaurora.org>, linux-arm-msm@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>, Souvik Chakravarty <souvik.chakravarty@arm.com>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

In order to allow the CPU to be power managed through a potential PM domain
and the corresponding topology, it needs to be attached to it. For that
reason, check if the PM domain data structures have been initiated for PSCI
and if so, let's try to attach the CPU device to its PM domain.

However, before attaching the CPU to its PM domain, we need to check
whether the PSCI firmware supports OS initiated mode or not. If that isn't
the case, we rely solely on the cpuidle framework to deal with the idle
state selection, which means we need to parse DT and convert the
hierarchical described domain idle states into regular cpuidle states,
hence let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Adapt to updated psci_dt_attach_cpu() helper, as it now returns a
	  struct device * instead of an int.
	- Create a per CPU struct, to store the relevant PSCI cpuidle data.

---
 drivers/firmware/psci/psci.c | 46 +++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 28745234b53f..54e23d4ed0ea 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -295,7 +295,13 @@ static int __init psci_features(u32 psci_func_id)
 }
 
 #ifdef CONFIG_CPU_IDLE
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+
+struct psci_cpuidle_data {
+	u32 *psci_states;
+	struct device *dev;
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(u32, domain_state);
 static bool psci_dt_topology;
 
@@ -332,8 +338,9 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 	int i, ret = 0, num_state_nodes = drv->state_count - 1;
 	u32 *psci_states;
 	struct device_node *state_node;
+	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
 
-	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
+	psci_states = kcalloc(CPUIDLE_STATE_MAX, sizeof(*psci_states),
 			GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
@@ -357,8 +364,31 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		goto free_mem;
 	}
 
-	/* Idle states parsed correctly, initialize per-cpu pointer */
-	per_cpu(psci_power_state, cpu) = psci_states;
+	/*
+	 * If the hierarchical CPU topology is used, let's attach the CPU device
+	 * to its corresponding PM domain. If OSI mode isn't supported, convert
+	 * the additional domain idle states from the hierarchical DT layout
+	 * into regular flattened cpuidle states, as to let cpuidle manage them.
+	 */
+	if (psci_dt_topology) {
+		struct device *dev;
+
+		if (!psci_has_osi_support()) {
+			ret = psci_dt_pm_domains_parse_states(drv, cpu_node,
+							      psci_states);
+			if (ret)
+				goto free_mem;
+		}
+
+		dev = psci_dt_attach_cpu(cpu);
+		if (IS_ERR_OR_NULL(dev))
+			goto free_mem;
+
+		data->dev = dev;
+	}
+
+	/* Idle states parsed correctly, store them in the per-cpu struct. */
+	data->psci_states = psci_states;
 	return 0;
 
 free_mem:
@@ -403,8 +433,8 @@ static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
 		}
 		psci_states[i] = state;
 	}
-	/* Idle states parsed correctly, initialize per-cpu pointer */
-	per_cpu(psci_power_state, cpu) = psci_states;
+	/* Idle states parsed correctly, store them in the per-cpu struct. */
+	per_cpu(psci_cpuidle_data.psci_states, cpu) = psci_states;
 	return 0;
 }
 #else
@@ -442,7 +472,7 @@ int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
 
 static int psci_suspend_finisher(unsigned long index)
 {
-	u32 *state = __this_cpu_read(psci_power_state);
+	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 	u32 composite_state = state[index - 1] | psci_get_domain_state();
 
 	return psci_ops.cpu_suspend(composite_state, __pa_symbol(cpu_resume));
@@ -451,7 +481,7 @@ static int psci_suspend_finisher(unsigned long index)
 int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
-	u32 *state = __this_cpu_read(psci_power_state);
+	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 	u32 composite_state = state[index - 1] | psci_get_domain_state();
 
 	/*
-- 
2.17.1
