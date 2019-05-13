From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/18] drivers: firmware: psci: Simplify state node parsing
Date: Mon, 13 May 2019 21:22:47 +0200
Message-ID: <20190513192300.653-6-ulf.hansson@linaro.org>
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

Instead of iterating through all the state nodes in DT, to find out how
many states that needs to be allocated, let's use the number already known
by the cpuidle driver. In this way we can drop the iteration altogether.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---

Changes:
	- None.

---
 drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 88e90e0f06b9..9c2180bcee4c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -306,26 +306,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
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
 
@@ -335,6 +329,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
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
