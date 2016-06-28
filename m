From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC v3] x86, hotplug: Use hlt instead of mwait if invoked from disable_nonboot_cpus
Date: Tue, 28 Jun 2016 17:16:43 +0800
Message-ID: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9094 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbcF1JJf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jun 2016 05:09:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

Stress test from Varun Koyyalagunta reports that, the
nonboot CPU would hang occasionally, when resuming from
hibernation. Further investigation shows that, the precise
stage when nonboot CPU hangs, is the time when the nonboot
CPU been woken up incorrectly, and tries to monitor the
mwait_ptr for the second time, then an exception is
triggered due to illegal vaddr access, say, something like,
'Unable to handler kernel address of 0xffff8800ba800010...'

Further investigation shows that, this exception is caused
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
address from task.flag to zero page, because no one would write
data to zero page. But there is still problem because of a ping-pong
wake up scenario in mwait_play_dead:

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

So choose a new solution as Brian suggested, to put the nonboot CPUs
into hlt before resume, without touching any memory during s/r.
Theoretically there might still be some problems if some of the CPUs have
already been put offline, but since the case is very rare and users
can work around it, we do not deal with this special case in kernel
for now.

BTW, as James mentioned, he might want to encapsulate disable_nonboot_cpus
into arch-specific, so this patch might need small change after that.

Comments and suggestions would be appreciated.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=106371
Reported-and-tested-by: Varun Koyyalagunta <cpudebug@centtech.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/smpboot.c | 17 +++++++++++++++++
 include/linux/smp.h       |  2 ++
 kernel/cpu.c              | 11 +++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fafe8b9..00b5181 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1331,6 +1331,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	smp_quirk_init_udelay();
 }
 
+static bool force_hlt_play_dead;
+
 void arch_enable_nonboot_cpus_begin(void)
 {
 	set_mtrr_aps_delayed_init();
@@ -1342,6 +1344,19 @@ void arch_enable_nonboot_cpus_end(void)
 }
 
 /*
+ * If we come from disable_nonboot_cpus, use hlt directly.
+ */
+void arch_disable_nonboot_cpus_begin(void)
+{
+	force_hlt_play_dead = true;
+}
+
+void arch_disable_nonboot_cpus_end(void)
+{
+	force_hlt_play_dead = false;
+}
+
+/*
  * Early setup to make printk work.
  */
 void __init native_smp_prepare_boot_cpu(void)
@@ -1642,6 +1657,8 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
+	if (force_hlt_play_dead)
+		hlt_play_dead();
 	mwait_play_dead();	/* Only returns on failure */
 	if (cpuidle_play_dead())
 		hlt_play_dead();
diff --git a/include/linux/smp.h b/include/linux/smp.h
index c441407..b2d1b4c 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -193,6 +193,8 @@ extern void arch_disable_smp_support(void);
 
 extern void arch_enable_nonboot_cpus_begin(void);
 extern void arch_enable_nonboot_cpus_end(void);
+extern void arch_disable_nonboot_cpus_begin(void);
+extern void arch_disable_nonboot_cpus_end(void);
 
 void smp_setup_processor_id(void);
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d948e44..fc9e839 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1017,6 +1017,14 @@ EXPORT_SYMBOL_GPL(cpu_up);
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
+void __weak arch_disable_nonboot_cpus_begin(void)
+{
+}
+
+void __weak arch_disable_nonboot_cpus_end(void)
+{
+}
+
 int disable_nonboot_cpus(void)
 {
 	int cpu, first_cpu, error = 0;
@@ -1029,6 +1037,8 @@ int disable_nonboot_cpus(void)
 	 */
 	cpumask_clear(frozen_cpus);
 
+	arch_disable_nonboot_cpus_begin();
+
 	pr_info("Disabling non-boot CPUs ...\n");
 	for_each_online_cpu(cpu) {
 		if (cpu == first_cpu)
@@ -1049,6 +1059,7 @@ int disable_nonboot_cpus(void)
 	else
 		pr_err("Non-boot CPUs are not disabled\n");
 
+	arch_disable_nonboot_cpus_end();
 	/*
 	 * Make sure the CPUs won't be enabled by someone else. We need to do
 	 * this even in case of failure as all disable_nonboot_cpus() users are
-- 
2.7.4

