From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v10 12/27] drivers: firmware: psci: Simplify state node parsing
Date: Thu, 29 Nov 2018 18:46:45 +0100
Message-ID: <20181129174700.16585-13-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Instead of iterating through all the state nodes in DT, to find out how
many states that needs to be allocated, let's use the number already known
by the cpuidle driver. In this way we can drop the iteration altogether.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch.

---
 drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d50b46a0528f..cbfc936d251c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
 {
-	int i, ret = 0, count = 0;
+	int i, ret = 0, num_state_nodes = drv->state_count - 1;
 	u32 *psci_states;
 	struct device_node *state_node;
 
-	/* Count idle states */
-	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      count))) {
-		count++;
-		of_node_put(state_node);
-	}
-
-	if (!count)
-		return -ENODEV;
-
-	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
+			GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < num_state_nodes; i++) {
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		if (!state_node)
+			break;
+
 		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
 		of_node_put(state_node);
 
@@ -319,6 +313,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
 	}
 
+	if (i != num_state_nodes) {
+		ret = -ENODEV;
+		goto free_mem;
+	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
-- 
2.17.1
