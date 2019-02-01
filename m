From: Joseph Lo <josephl@nvidia.com>
Subject: [PATCH V2] cpuidle: dt: bail out if the idle-state DT node is not
 compatible
Date: Fri, 1 Feb 2019 10:16:39 +0800
Message-ID: <20190201021639.27245-1-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-tegra@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Joseph Lo <josephl@nvidia.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently, the DT of the idle states will be parsed first whether it's
compatible or not. This could cause a warning message that comes from if
the CPU doesn't support identical idle states. E.g. Tegra186 can run
with 2 Cortex-A57 and 2 Denver cores with different idle states on
different types of these cores.

So fix it by checking the match node earlier, then it can make sure it
only goes through the idle states that the CPU supported.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
v2:
 * fix it by moving of_match_node earlier, so we don't need to match the
   node twice like the v1 did.
---
 drivers/cpuidle/dt_idle_states.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 53342b7f1010..add9569636b5 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -22,16 +22,12 @@
 #include "dt_idle_states.h"
 
 static int init_state_node(struct cpuidle_state *idle_state,
-			   const struct of_device_id *matches,
+			   const struct of_device_id *match_id,
 			   struct device_node *state_node)
 {
 	int err;
-	const struct of_device_id *match_id;
 	const char *desc;
 
-	match_id = of_match_node(matches, state_node);
-	if (!match_id)
-		return -ENODEV;
 	/*
 	 * CPUidle drivers are expected to initialize the const void *data
 	 * pointer of the passed in struct of_device_id array to the idle
@@ -160,6 +156,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 {
 	struct cpuidle_state *idle_state;
 	struct device_node *state_node, *cpu_node;
+	const struct of_device_id *match_id;
 	int i, err = 0;
 	const cpumask_t *cpumask;
 	unsigned int state_idx = start_idx;
@@ -180,6 +177,12 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!state_node)
 			break;
 
+		match_id = of_match_node(matches, state_node);
+		if (!match_id) {
+			err = -ENODEV;
+			break;
+		}
+
 		if (!of_device_is_available(state_node)) {
 			of_node_put(state_node);
 			continue;
@@ -198,7 +201,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		}
 
 		idle_state = &drv->states[state_idx++];
-		err = init_state_node(idle_state, matches, state_node);
+		err = init_state_node(idle_state, match_id, state_node);
 		if (err) {
 			pr_err("Parsing idle state node %pOF failed with err %d\n",
 			       state_node, err);
-- 
2.20.1
