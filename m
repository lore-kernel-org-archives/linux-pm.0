From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 4/4] x86, hotplug: Use hlt instead of mwait when resuming from hibernation
Date: Sun, 26 Jun 2016 00:19:02 +0800
Message-ID: <519377051f98268f41c382d2897ae578b2a743f6.1466844557.git.yu.c.chen@intel.com>
References: <cover.1466844557.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466844557.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Here's the story of what the problem is, why this
happened, and why this patch looks like this:

Stress test from Varun Koyyalagunta reports that, the
nonboot CPU would hang occasionally, when resuming from
hibernation. Further investigation shows that, the precise
stage when nonboot CPU hangs, is the time when the nonboot
CPU been woken up incorrectly, and tries to monitor the
mwait_ptr for the second time, then an exception is
triggered due to illegal vaddr access, say, something like,
'Unable to handler kernel address of 0xffff8800ba800010...'

Further investigation shows that, the exception is caused
by accessing a page without PRESENT flag, because the pte entry
for this vaddr is zero. Here's the scenario how this problem
happens: Page table for direct mapping is allocated dynamically
by kernel_physical_mapping_init, it is possible that in the
resume process, when the boot CPU is trying to write back pages
to their original address, and just right to writes to the monitor
mwait_ptr then wakes up one of the nonboot CPUs, since the page
table currently used by the nonboot CPU might not the same as it
is before the hibernation, an exception might occur due to
inconsistent page table.

First try is to get rid of this problem by changing the monitor
address from task.flag to zero page, because one one would write
to zero page. But this still have problem because of ping-pong
wake up situation in mwait_play_dead:

One possible implementation of a clflush is a read-invalidate snoop,
which is what a store might look like, so cflush might break the mwait.

1. CPU1 wait at zero page
2. CPU2 cflush zero page, wake CPU1 up, then CPU2 waits at zero page
3. CPU1 is woken up, and invoke cflush zero page, thus wake up CPU2 again.
then the nonboot CPUs never sleep for long.

So it's better to monitor different address for each
nonboot CPUs, however since there is only one zero page, at most:
PAGE_SIZE/L1_CACHE_LINE CPUs are satisfied, which is usually 64
on a x86_64, apparently it's not enough for servers, maybe more
zero pages are required.

So choose the solution as Brian suggested, to put the nonboot CPUs
into hlt before resuming. But Rafael has mentioned that, if some of
the CPUs have already been offline before hibernation, then the problem
is still there. So this patch tries to kick the already offline CPUs woken
up and fall into hlt, and then put the rest online CPUs into hlt.
In this way, all the nonboot CPUs will wait at a safe state,
without touching any memory during s/r. (It's not safe to modify
mwait_play_dead, because once previous offline CPUs are woken up,
it will either access text code, whose page table is not safe anymore
across hibernation, due to:
Commit ab76f7b4ab23 ("x86/mm: Set NX on gap between __ex_table and
rodata").

Link: https://bugzilla.kernel.org/show_bug.cgi?id=106371
Reported-and-tested-by: Varun Koyyalagunta <cpudebug@centtech.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/smpboot.c | 15 +++++++++++++++
 include/linux/cpu.h       |  2 ++
 kernel/cpu.c              | 22 ++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fafe8b9..86672be 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -53,6 +53,7 @@
 #include <linux/stackprotector.h>
 #include <linux/gfp.h>
 #include <linux/cpuidle.h>
+#include <linux/suspend.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -1341,6 +1342,18 @@ void arch_enable_nonboot_cpus_end(void)
 	mtrr_aps_init();
 }
 
+void arch_disable_nonboot_cpus_pre(void)
+{
+	if (!hibernation_in_resume())
+		return;
+	kick_offline_cpus(1);
+}
+
+void arch_enable_nonboot_cpus_prev(void)
+{
+	kick_offline_cpus(0);
+}
+
 /*
  * Early setup to make printk work.
  */
@@ -1642,6 +1655,8 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
+	if (hibernation_in_resume())
+		hlt_play_dead();
 	mwait_play_dead();	/* Only returns on failure */
 	if (cpuidle_play_dead())
 		hlt_play_dead();
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 21597dc..d408200 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -241,9 +241,11 @@ static inline void cpu_hotplug_done(void) {}
 #ifdef CONFIG_PM_SLEEP_SMP
 extern int disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
+extern int kick_offline_cpus(int first);
 #else /* !CONFIG_PM_SLEEP_SMP */
 static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
+static inline int kick_offline_cpus(int first) { return 0; }
 #endif /* !CONFIG_PM_SLEEP_SMP */
 
 void cpu_startup_entry(enum cpuhp_state state);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index ce6e5e4..538a382 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1016,6 +1016,25 @@ EXPORT_SYMBOL_GPL(cpu_up);
 
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
+static cpumask_var_t offline_cpus;
+
+int kick_offline_cpus(int first)
+{
+	int cpu;
+
+	if (offline_cpus == NULL)
+		return -ENOMEM;
+
+	if (first)
+		cpumask_andnot(offline_cpus, cpu_possible_mask, cpu_online_mask);
+
+	for_each_cpu(cpu, offline_cpus) {
+		_cpu_up(cpu, 1, CPUHP_ONLINE);
+		_cpu_down(cpu, 1, CPUHP_OFFLINE);
+	}
+
+	return 0;
+}
 
 void __weak arch_disable_nonboot_cpus_pre(void)
 {
@@ -1120,6 +1139,9 @@ static int __init alloc_frozen_cpus(void)
 {
 	if (!alloc_cpumask_var(&frozen_cpus, GFP_KERNEL|__GFP_ZERO))
 		return -ENOMEM;
+	/* No need to free frozen_cpus if failed. */
+	if (!alloc_cpumask_var(&offline_cpus, GFP_KERNEL|__GFP_ZERO))
+		return -ENOMEM;
 	return 0;
 }
 core_initcall(alloc_frozen_cpus);
-- 
2.7.4
