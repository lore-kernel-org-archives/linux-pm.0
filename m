From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 4/5] powernv:idle: Move initialization of sibling pacas to pnv_alloc_idle_core_states
Date: Wed,  5 Jul 2017 22:08:15 +0530
Message-ID: <1499272696-28751-5-git-send-email-ego@linux.vnet.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On POWER9 DD1, in order to get around a hardware issue, we store in
every CPU thread's paca the paca pointers of all its siblings.

Move this code into pnv_alloc_idle_core_states() soon after the space
for saving the sibling pacas is allocated.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 45 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index c400ff9..254a0db8 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -194,6 +194,28 @@ static void pnv_alloc_idle_core_states(void)
 		}
 	}
 
+	/*
+	 * For each CPU, record its PACA address in each of it's
+	 * sibling thread's PACA at the slot corresponding to this
+	 * CPU's index in the core.
+	 */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		int cpu;
+
+		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
+		for_each_possible_cpu(cpu) {
+			int base_cpu = cpu_first_thread_sibling(cpu);
+			int idx = cpu_thread_in_core(cpu);
+			int i;
+
+			for (i = 0; i < threads_per_core; i++) {
+				int j = base_cpu + i;
+
+				paca[j].thread_sibling_pacas[idx] = &paca[cpu];
+			}
+		}
+	}
+
 	update_subcore_sibling_mask();
 
 	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
@@ -898,31 +920,8 @@ static int __init pnv_init_idle_states(void)
 	if (pnv_probe_idle_states())
 		goto out;
 
-
 	pnv_alloc_idle_core_states();
 
-	/*
-	 * For each CPU, record its PACA address in each of it's
-	 * sibling thread's PACA at the slot corresponding to this
-	 * CPU's index in the core.
-	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-		int cpu;
-
-		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
-		for_each_possible_cpu(cpu) {
-			int base_cpu = cpu_first_thread_sibling(cpu);
-			int idx = cpu_thread_in_core(cpu);
-			int i;
-
-			for (i = 0; i < threads_per_core; i++) {
-				int j = base_cpu + i;
-
-				paca[j].thread_sibling_pacas[idx] = &paca[cpu];
-			}
-		}
-	}
-
 out:
 	return 0;
 }
-- 
1.9.4
