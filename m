From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] x86 / hibernate: Use hlt_play_dead() when resuming from hibernation
Date: Sun, 10 Jul 2016 03:49:25 +0200
Message-ID: <12570565.xIMhLmhDgj@vostro.rjw.lan>
References: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, x86@kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On Intel hardware, native_play_dead() uses mwait_play_dead() by
default and only falls back to the other methods if that fails.
That also happens during resume from hibernation, when the restore
(boot) kernel runs disable_nonboot_cpus() to take all of the CPUs
except for the boot one offline.

However, that is problematic, because the address passed to
__monitor() in mwait_play_dead() is likely to be written to in the
last phase of hibernate image restoration and that causes the "dead"
CPU to start executing instructions again.  Unfortunately, the page
containing the address in that CPU's instruction pointer may not be
valid any more at that point.

First, that page may have been overwritten with image kernel memory
contents already, so the instructions the CPU attempts to execute may
simply be invalid.  Second, the page tables previously used by that
CPU may have been overwritten by image kernel memory contents, so the
address in its instruction pointer is impossible to resolve then.

A report from Varun Koyyalagunta and investigation carried out by
Chen Yu show that the latter sometimes happens in practice.

To prevent it from happening, modify native_play_dead() to make
it use hlt_play_dead() instead of mwait_play_dead() during resume
from hibernation which avoids the inadvertent "revivals" of "dead"
CPUs.

A slightly unpleasant consequence of this change is that if the
system is hibernated with one or more CPUs offline, it will generally
draw more power after resume than it did before hibernation, because
the physical state entered by CPUs via hlt_play_dead() is higher-power
than the mwait_play_dead() one in the majority of cases.  It is
possible to work around this, but it is unclear how much of a problem
that's going to be in practice, so the workaround will be implemented
later if it turns out to be necessary.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=106371
Reported-by: Varun Koyyalagunta <cpudebug@centtech.com>
Original-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a slightly rearranged new version of

https://patchwork.kernel.org/patch/9217459/

---
 arch/x86/include/asm/cpu.h |    6 ++++++
 arch/x86/kernel/smpboot.c  |    3 +++
 arch/x86/power/cpu.c       |   21 +++++++++++++++++++++
 kernel/power/hibernate.c   |    7 ++++++-
 kernel/power/power.h       |    2 ++
 5 files changed, 38 insertions(+), 1 deletion(-)

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
@@ -266,6 +266,27 @@ void notrace restore_processor_state(voi
 EXPORT_SYMBOL(restore_processor_state);
 #endif
 
+#if defined(CONFIG_HIBERNATION) && defined(CONFIG_HOTPLUG_CPU)
+bool force_hlt_play_dead __read_mostly;
+
+int hibernate_resume_nonboot_cpu_disable(void)
+{
+	int ret;
+
+	/*
+	 * Ensure that MONITOR/MWAIT will not be used in the "play dead" loop
+	 * during hibernate image restoration, because it is likely that the
+	 * monitored address will be actually written to at that time and then
+	 * the "dead" CPU may start executing instructions from an image
+	 * kernel's page (and that may not be the "play dead" loop any more).
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
@@ -1642,6 +1642,9 @@ void native_play_dead(void)
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
@@ -26,6 +26,12 @@ struct x86_cpu {
 };
 
 #ifdef CONFIG_HOTPLUG_CPU
+#ifdef CONFIG_HIBERNATION
+extern bool force_hlt_play_dead;
+#else
+#define force_hlt_play_dead	(false)
+#endif
+
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
 extern void start_cpu0(void);
