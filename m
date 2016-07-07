From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC v3] x86, hotplug: Use hlt instead of mwait if invoked from disable_nonboot_cpus
Date: Thu, 07 Jul 2016 02:33:21 +0200
Message-ID: <209704957.TWElLMTLfP@vostro.rjw.lan>
References: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56851 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932235AbcGGA2p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2016 20:28:45 -0400
In-Reply-To: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>, James Morse <james.morse@arm.com>
Cc: linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org

On Tuesday, June 28, 2016 05:16:43 PM Chen Yu wrote:
> Stress test from Varun Koyyalagunta reports that, the
> nonboot CPU would hang occasionally, when resuming from
> hibernation. Further investigation shows that, the precise
> stage when nonboot CPU hangs, is the time when the nonboot
> CPU been woken up incorrectly, and tries to monitor the
> mwait_ptr for the second time, then an exception is
> triggered due to illegal vaddr access, say, something like,
> 'Unable to handler kernel address of 0xffff8800ba800010...'
> 
> Further investigation shows that, this exception is caused
> by accessing a page without PRESENT flag, because the pte entry
> for this vaddr is zero. Here's the scenario how this problem
> happens: Page table for direct mapping is allocated dynamically
> by kernel_physical_mapping_init, it is possible that in the
> resume process, when the boot CPU is trying to write back pages
> to their original address, and just right to writes to the monitor
> mwait_ptr then wakes up one of the nonboot CPUs, since the page
> table currently used by the nonboot CPU might not the same as it
> is before the hibernation, an exception might occur due to
> inconsistent page table.
> 
> First try is to get rid of this problem by changing the monitor
> address from task.flag to zero page, because no one would write
> data to zero page. But there is still problem because of a ping-pong
> wake up scenario in mwait_play_dead:
> 
> One possible implementation of a clflush is a read-invalidate snoop,
> which is what a store might look like, so cflush might break the mwait.
> 
> 1. CPU1 wait at zero page
> 2. CPU2 cflush zero page, wake CPU1 up, then CPU2 waits at zero page
> 3. CPU1 is woken up, and invoke cflush zero page, thus wake up CPU2 again.
> then the nonboot CPUs never sleep for long.
> 
> So it's better to monitor different address for each
> nonboot CPUs, however since there is only one zero page, at most:
> PAGE_SIZE/L1_CACHE_LINE CPUs are satisfied, which is usually 64
> on a x86_64, apparently it's not enough for servers, maybe more
> zero pages are required.
> 
> So choose a new solution as Brian suggested, to put the nonboot CPUs
> into hlt before resume, without touching any memory during s/r.
> Theoretically there might still be some problems if some of the CPUs have
> already been put offline, but since the case is very rare and users
> can work around it, we do not deal with this special case in kernel
> for now.
> 
> BTW, as James mentioned, he might want to encapsulate disable_nonboot_cpus
> into arch-specific, so this patch might need small change after that.
> 
> Comments and suggestions would be appreciated.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=106371
> Reported-and-tested-by: Varun Koyyalagunta <cpudebug@centtech.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Below is my sort of version of this (untested) and I did it this way, because
the issue is specific to resume from hibernation (the workaround need not be
applied anywhere else) and the hibernate_resume_nonboot_cpu_disable() thing may
be useful to arm64 too if I'm not mistaken (James?).

Actually, if arm64 uses it too, the __weak implementation can be dropped,
because it will be possible to make it depend on ARCH_HIBERNATION_HEADER
(x86 and arm64 are the only users of that).

Thanks,
Rafael


---
 arch/x86/include/asm/cpu.h |    2 ++
 arch/x86/kernel/smpboot.c  |    5 +++++
 arch/x86/power/cpu.c       |   19 +++++++++++++++++++
 kernel/power/hibernate.c   |    7 ++++++-
 kernel/power/power.h       |    2 ++
 5 files changed, 34 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -409,6 +409,11 @@ int hibernation_snapshot(int platform_mo
 	goto Close;
 }
 
+int __weak hibernate_resume_nonboot_cpu_disable(void)
+{
+	return disable_nonboot_cpus();
+}
+
 /**
  * resume_target_kernel - Restore system state from a hibernation image.
  * @platform_mode: Whether or not to use the platform driver.
@@ -433,7 +438,7 @@ static int resume_target_kernel(bool pla
 	if (error)
 		goto Cleanup;
 
-	error = disable_nonboot_cpus();
+	error = hibernate_resume_nonboot_cpu_disable();
 	if (error)
 		goto Enable_cpus;
 
Index: linux-pm/kernel/power/power.h
===================================================================
--- linux-pm.orig/kernel/power/power.h
+++ linux-pm/kernel/power/power.h
@@ -38,6 +38,8 @@ static inline char *check_image_kernel(s
 }
 #endif /* CONFIG_ARCH_HIBERNATION_HEADER */
 
+extern int hibernate_resume_nonboot_cpu_disable(void);
+
 /*
  * Keep some memory free so that I/O operations can succeed without paging
  * [Might this be more than 4 MB?]
Index: linux-pm/arch/x86/power/cpu.c
===================================================================
--- linux-pm.orig/arch/x86/power/cpu.c
+++ linux-pm/arch/x86/power/cpu.c
@@ -266,6 +266,25 @@ void notrace restore_processor_state(voi
 EXPORT_SYMBOL(restore_processor_state);
 #endif
 
+#if defined(CONFIG_HIBERNATION) && defined(CONFIG_HOTPLUG_CPU)
+int hibernate_resume_nonboot_cpu_disable(void)
+{
+	int ret;
+
+	/*
+	 * Ensure that MONITOR/MWAIT will not be used in the "play dead" loop
+	 * during image restoration, because it is likely that the monitored
+	 * address will be actually written to at that time and then the "dead"
+	 * CPU may start executing instructions from an image kernel's page
+	 * (and that may not be the "play dead" loop any more).
+	 */
+	force_hlt_play_dead = true;
+	ret = disable_nonboot_cpus();
+	force_hlt_play_dead = false;
+	return ret;
+}
+#endif
+
 /*
  * When bsp_check() is called in hibernate and suspend, cpu hotplug
  * is disabled already. So it's unnessary to handle race condition between
Index: linux-pm/arch/x86/kernel/smpboot.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/smpboot.c
+++ linux-pm/arch/x86/kernel/smpboot.c
@@ -1441,6 +1441,8 @@ __init void prefill_possible_map(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
+bool force_hlt_play_dead;
+
 static void remove_siblinginfo(int cpu)
 {
 	int sibling;
@@ -1642,6 +1644,9 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
+	if (force_hlt_play_dead)
+		hlt_play_dead();
+
 	mwait_play_dead();	/* Only returns on failure */
 	if (cpuidle_play_dead())
 		hlt_play_dead();
Index: linux-pm/arch/x86/include/asm/cpu.h
===================================================================
--- linux-pm.orig/arch/x86/include/asm/cpu.h
+++ linux-pm/arch/x86/include/asm/cpu.h
@@ -26,6 +26,8 @@ struct x86_cpu {
 };
 
 #ifdef CONFIG_HOTPLUG_CPU
+extern bool force_hlt_play_dead;
+
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 extern void start_cpu0(void);

