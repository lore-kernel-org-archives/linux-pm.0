From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v10 22/27] drivers: firmware: psci: Attach the CPU's device to its PM domain
Date: Thu, 29 Nov 2018 18:46:55 +0100
Message-ID: <20181129174700.16585-23-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Changes in v10:
	- Attach CPU devices to their PM domains, regardless of OSI mode or PC
	  mode.
	- For PC mode, convert domain idle states to generic cpuidle states
	  to let the cpuidle driver manage them.

---
 drivers/firmware/psci/psci.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 5b481e91ccab..94cd0431b004 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -327,7 +327,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 	u32 *psci_states;
 	struct device_node *state_node;
 
-	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
+	psci_states = kcalloc(CPUIDLE_STATE_MAX, sizeof(*psci_states),
 			GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
@@ -351,6 +351,26 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		goto free_mem;
 	}
 
+	/*
+	 * If the hierarchical CPU topology is used, let's attach the CPU device
+	 * to its corresponding PM domain. If OSI mode isn't supported, pick up
+	 * the additional cpuidle states, from the domain idle states described
+	 * in the hierarchical DT layout, as to enable the cpuidle driver to
+	 * manage them.
+	 */
+	if (psci_dt_topology) {
+		if (!psci_has_osi_support()) {
+			ret = psci_dt_pm_domains_parse_states(drv, cpu_node,
+							      psci_states);
+			if (ret)
+				goto free_mem;
+		}
+
+		ret = psci_dt_attach_cpu(cpu);
+		if (ret)
+			goto free_mem;
+	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
-- 
2.17.1
