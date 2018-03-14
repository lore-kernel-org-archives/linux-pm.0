From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v6 14/25] drivers: firmware: psci: Support hierarchical CPU idle states
Date: Wed, 14 Mar 2018 17:58:24 +0100
Message-ID: <1521046715-30683-15-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Currently CPU's idle states are represented in a flattened model, via the
"cpu-idle-states" binding from within the CPU's device nodes.

Support the hierarchical layout, simply by converting to calling the new OF
helper, of_get_cpu_state_node().

Cc: Lina Iyer <ilina@codeaurora.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 9788bfc..256b4ed 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -294,8 +294,7 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	struct device_node *state_node;
 
 	/* Count idle states */
-	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      count))) {
+	while ((state_node = of_get_cpu_state_node(cpu_node, count))) {
 		count++;
 		of_node_put(state_node);
 	}
@@ -308,7 +307,7 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 		return -ENOMEM;
 
 	for (i = 0; i < count; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = of_get_cpu_state_node(cpu_node, i);
 		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
 		of_node_put(state_node);
 
-- 
2.7.4
