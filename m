From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 2/3] cpuidle/powernv: Change platform init to avoid reparsing dt
Date: Tue, 19 Jun 2018 10:34:27 +0530
Message-ID: <1529384668-27548-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

The required data is accessible from cpuidle_states structure and
nr_cpu_idle_states. This patch makes changes to avoid reparsing and use
data from these structures.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 37 ++++++++---------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 07be984..0a62611 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -624,8 +624,7 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
  * @dt_idle_states: Number of idle state entries
  * Returns 0 on success
  */
-static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
-					int dt_idle_states)
+static int __init pnv_power9_idle_init(void)
 {
 	u64 max_residency_ns = 0;
 	int i;
@@ -644,7 +643,7 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
 	 */
 	pnv_first_deep_stop_state = MAX_STOP_STATE;
-	for (i = 0; i < dt_idle_states; i++) {
+	for (i = 0; i < nr_pnv_idle_states; i++) {
 		int err;
 		struct pnv_idle_states_t *state = &pnv_idle_states[i];
 		u64 psscr_rl = state->pm_ctrl_reg_val & PSSCR_RL_MASK;
@@ -704,41 +703,21 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
  */
 static void __init pnv_probe_idle_states(void)
 {
-	struct device_node *np;
-	int dt_idle_states;
-	u32 *flags = NULL;
 	int i;
 
-	np = of_find_node_by_path("/ibm,opal/power-mgt");
-	if (!np) {
-		pr_warn("opal: PowerMgmt Node not found\n");
-		goto out;
-	}
-	dt_idle_states = of_property_count_u32_elems(np,
-			"ibm,cpu-idle-state-flags");
-	if (dt_idle_states < 0) {
+	if (nr_pnv_idle_states < 0) {
 		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
-		goto out;
-	}
-
-	flags = kcalloc(dt_idle_states, sizeof(*flags),  GFP_KERNEL);
-
-	if (of_property_read_u32_array(np,
-			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
-		goto out;
+		return;
 	}
 
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		if (pnv_power9_idle_init(np, flags, dt_idle_states))
-			goto out;
+		if (pnv_power9_idle_init())
+			return;
 	}
 
-	for (i = 0; i < dt_idle_states; i++)
-		supported_cpuidle_states |= flags[i];
+	for (i = 0; i < nr_pnv_idle_states; i++)
+		supported_cpuidle_states |= pnv_idle_states[i].flags;
 
-out:
-	kfree(flags);
 }
 
 /*
-- 
2.5.5
