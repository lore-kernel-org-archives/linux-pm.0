From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/4] x86 smpboot: remove APIC.wait_for_init_deassert and atomic init_deasserted
Date: Sun, 16 Aug 2015 11:45:48 -0400
Message-ID: <de4b3a9bab894735e285870b5296da25ee6a8a5a.1439739165.git.len.brown@intel.com>
References: <1439739948-21028-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439739948-21028-1-git-send-email-lenb@kernel.org>
In-Reply-To: <33ef746c67d2489cad0a9b1958cf71167232ff2b.1439739165.git.len.brown@intel.com>
References: <33ef746c67d2489cad0a9b1958cf71167232ff2b.1439739165.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Both the per-APIC flag ".wait_for_init_deassert",
and the global atomic_t "init_deasserted"
are dead code -- remove them.

For all APIC types, "wait_for_master()"
prevents an AP from proceeding until the BSP has set
cpu_callout_mask, making "init_deasserted" {unnecessary}:

BSP: <de-assert INIT>
...
BSP: {set init_deasserted}
AP: wait_for_master()
	set cpu_initialized_mask
	wait for cpu_callout_mask
BSP: test cpu_initialized_mask
BSP: set cpu_callout_mask
AP: test cpu_callout_mask
AP: {wait for init_deasserted}
...
AP: <touch APIC>

Deleting the {dead code} above is necessary to enable
some parallelism in a future patch.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/apic.h           |  2 --
 arch/x86/kernel/apic/apic_flat_64.c   |  2 --
 arch/x86/kernel/apic/apic_noop.c      |  1 -
 arch/x86/kernel/apic/apic_numachip.c  |  2 --
 arch/x86/kernel/apic/bigsmp_32.c      |  1 -
 arch/x86/kernel/apic/probe_32.c       |  1 -
 arch/x86/kernel/apic/x2apic_cluster.c |  1 -
 arch/x86/kernel/apic/x2apic_phys.c    |  1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |  2 --
 arch/x86/kernel/smpboot.c             | 16 +++-------------
 10 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index c839363..ebf6d5e 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -313,7 +313,6 @@ struct apic {
 	/* wakeup_secondary_cpu */
 	int (*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
 
-	bool wait_for_init_deassert;
 	void (*inquire_remote_apic)(int apicid);
 
 	/* apic ops */
@@ -378,7 +377,6 @@ extern struct apic *__apicdrivers[], *__apicdrivers_end[];
  * APIC functionality to boot other CPUs - only used on SMP:
  */
 #ifdef CONFIG_SMP
-extern atomic_t init_deasserted;
 extern int wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip);
 #endif
 
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index de918c4..f92ab36 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -191,7 +191,6 @@ static struct apic apic_flat =  {
 	.send_IPI_all			= flat_send_IPI_all,
 	.send_IPI_self			= apic_send_IPI_self,
 
-	.wait_for_init_deassert		= false,
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
 	.read				= native_apic_mem_read,
@@ -299,7 +298,6 @@ static struct apic apic_physflat =  {
 	.send_IPI_all			= physflat_send_IPI_all,
 	.send_IPI_self			= apic_send_IPI_self,
 
-	.wait_for_init_deassert		= false,
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
 	.read				= native_apic_mem_read,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index b205cdb..0d96749 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -152,7 +152,6 @@ struct apic apic_noop = {
 
 	.wakeup_secondary_cpu		= noop_wakeup_secondary_cpu,
 
-	.wait_for_init_deassert		= false,
 	.inquire_remote_apic		= NULL,
 
 	.read				= noop_apic_read,
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 017149c..b548fd3 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -92,7 +92,6 @@ static int numachip_wakeup_secondary(int phys_apicid, unsigned long start_rip)
 
 	write_lcsr(CSR_G3_EXT_IRQ_GEN, int_gen.v);
 
-	atomic_set(&init_deasserted, 1);
 	return 0;
 }
 
@@ -235,7 +234,6 @@ static const struct apic apic_numachip __refconst = {
 	.send_IPI_self			= numachip_send_IPI_self,
 
 	.wakeup_secondary_cpu		= numachip_wakeup_secondary,
-	.wait_for_init_deassert		= false,
 	.inquire_remote_apic		= NULL, /* REMRD not supported */
 
 	.read				= native_apic_mem_read,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index c4a8d63..971cf88 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -186,7 +186,6 @@ static struct apic apic_bigsmp = {
 	.send_IPI_all			= bigsmp_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
 
-	.wait_for_init_deassert		= true,
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
 	.read				= native_apic_mem_read,
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index bda4886..7694ae6 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -111,7 +111,6 @@ static struct apic apic_default = {
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
 
-	.wait_for_init_deassert		= true,
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
 	.read				= native_apic_mem_read,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index ab3219b..1b6c1a4 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -272,7 +272,6 @@ static struct apic apic_x2apic_cluster = {
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
 
-	.wait_for_init_deassert		= false,
 	.inquire_remote_apic		= NULL,
 
 	.read				= native_apic_msr_read,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 3ffd925..662e915 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -128,7 +128,6 @@ static struct apic apic_x2apic_phys = {
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
 
-	.wait_for_init_deassert		= false,
 	.inquire_remote_apic		= NULL,
 
 	.read				= native_apic_msr_read,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index c8d9295..4a13946 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -248,7 +248,6 @@ static int uv_wakeup_secondary(int phys_apicid, unsigned long start_rip)
 	    APIC_DM_STARTUP;
 	uv_write_global_mmr64(pnode, UVH_IPI_INT, val);
 
-	atomic_set(&init_deasserted, 1);
 	return 0;
 }
 
@@ -414,7 +413,6 @@ static struct apic __refdata apic_x2apic_uv_x = {
 	.send_IPI_self			= uv_send_IPI_self,
 
 	.wakeup_secondary_cpu		= uv_wakeup_secondary,
-	.wait_for_init_deassert		= false,
 	.inquire_remote_apic		= NULL,
 
 	.read				= native_apic_msr_read,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3d992b6..70276bc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -97,8 +97,6 @@ DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
-atomic_t init_deasserted;
-
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
 {
 	unsigned long flags;
@@ -146,16 +144,11 @@ static void smp_callin(void)
 
 	/*
 	 * If waken up by an INIT in an 82489DX configuration
-	 * we may get here before an INIT-deassert IPI reaches
-	 * our local APIC.  We have to wait for the IPI or we'll
-	 * lock up on an APIC access.
-	 *
-	 * Since CPU0 is not wakened up by INIT, it doesn't wait for the IPI.
+	 * cpu_callout_mask guarantees we don't get here before
+	 * an INIT_deassert IPI reaches our local APIC, so it is
+	 * now safe to touch our local APIC.
 	 */
 	cpuid = smp_processor_id();
-	if (apic->wait_for_init_deassert && cpuid)
-		while (!atomic_read(&init_deasserted))
-			cpu_relax();
 
 	/*
 	 * (This works even if the APIC is not enabled.)
@@ -620,7 +613,6 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 	send_status = safe_apic_wait_icr_idle();
 
 	mb();
-	atomic_set(&init_deasserted, 1);
 
 	/*
 	 * Should we send STARTUP IPIs ?
@@ -861,8 +853,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 	 * the targeted processor.
 	 */
 
-	atomic_set(&init_deasserted, 0);
-
 	if (get_uv_system_type() != UV_NON_UNIQUE_APIC) {
 
 		pr_debug("Setting warm reset code and vector.\n");
-- 
2.5.0.330.g130be8e
