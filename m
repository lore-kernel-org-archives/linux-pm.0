From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [PATCH] arch/cpuidle-powernv: Avoid endianness conversions while
 parsing DT
Date: Tue, 03 Feb 2015 12:13:44 +0530
Message-ID: <20150203064327.13766.88453.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We currently read the information about idle states from the DT
so as to find out the cpu idle states supported by the platform.
Use those APIs to read from the DT that can avoid endianness
conversions of the property values.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/powernv/setup.c |   35 ++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d2de7d5..39d1971 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -409,37 +409,39 @@ static int __init pnv_init_idle_states(void)
 {
 	struct device_node *power_mgt;
 	int dt_idle_states;
-	const __be32 *idle_state_flags;
-	u32 len_flags, flags;
+	u32 *flags;
 	int i;
 
 	supported_cpuidle_states = 0;
 
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
-		return 0;
+		goto out;
 
 	if (!firmware_has_feature(FW_FEATURE_OPALv3))
-		return 0;
+		goto out;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!power_mgt) {
 		pr_warn("opal: PowerMgmt Node not found\n");
-		return 0;
+		goto out;
+	}
+	dt_idle_states = of_property_count_u32_elems(power_mgt,
+			"ibm,cpu-idle-state-flags");
+	if (dt_idle_states < 0) {
+		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
+		goto out;
 	}
 
-	idle_state_flags = of_get_property(power_mgt,
-			"ibm,cpu-idle-state-flags", &len_flags);
-	if (!idle_state_flags) {
-		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
-		return 0;
+	flags = kzalloc(sizeof(*flags) * dt_idle_states, GFP_KERNEL);
+	if (of_property_read_u32_array(power_mgt,
+			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
+		goto out_free;
 	}
 
-	dt_idle_states = len_flags / sizeof(u32);
+	for (i = 0; i < dt_idle_states; i++)
+		supported_cpuidle_states |= flags[i];
 
-	for (i = 0; i < dt_idle_states; i++) {
-		flags = be32_to_cpu(idle_state_flags[i]);
-		supported_cpuidle_states |= flags;
-	}
 	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
 		patch_instruction(
 			(unsigned int *)pnv_fastsleep_workaround_at_entry,
@@ -449,6 +451,9 @@ static int __init pnv_init_idle_states(void)
 			PPC_INST_NOP);
 	}
 	pnv_alloc_idle_core_states();
+out_free:
+	kfree(flags);
+out:
 	return 0;
 }
 
