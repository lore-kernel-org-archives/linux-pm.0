From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] x86 / hibernate: Use hlt_play_dead() when resuming from hibernation
Date: Thu, 14 Jul 2016 03:55:23 +0200
Message-ID: <2496371.r57m45JVIP@vostro.rjw.lan>
References: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com> <12570565.xIMhLmhDgj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59903 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750862AbcGNBuj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 21:50:39 -0400
In-Reply-To: <12570565.xIMhLmhDgj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: x86@kernel.org, Chen Yu <yu.c.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>

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

To prevent it from happening, temporarily change the smp_ops.play_dead
pointer during resume from hibernation so that it points to a special
"play dead" routine which uses hlt_play_dead() and avoids the
inadvertent "revivals" of "dead" CPUs this way.

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

A new version here.

I prefer this one, because it only adds any overhead if hibernation is actually
used, but then it is a bit more of a hack.

If you prefer the previous one, please let me know.

---
 arch/x86/include/asm/smp.h |    1 +
 arch/x86/kernel/smpboot.c  |    2 +-
 arch/x86/power/cpu.c       |   30 ++++++++++++++++++++++++++++++
 kernel/power/hibernate.c   |    7 ++++++-
 kernel/power/power.h       |    2 ++
 5 files changed, 40 insertions(+), 2 deletions(-)

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
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/smp.h>
 #include <linux/perf_event.h>
+#include <linux/tboot.h>
 
 #include <asm/pgtable.h>
 #include <asm/proto.h>
@@ -266,6 +267,35 @@ void notrace restore_processor_state(voi
 EXPORT_SYMBOL(restore_processor_state);
 #endif
 
+#if defined(CONFIG_HIBERNATION) && defined(CONFIG_HOTPLUG_CPU)
+static void resume_play_dead(void)
+{
+	play_dead_common();
+	tboot_shutdown(TB_SHUTDOWN_WFS);
+	hlt_play_dead();
+}
+
+int hibernate_resume_nonboot_cpu_disable(void)
+{
+	void (*play_dead)(void) = smp_ops.play_dead;
+	int ret;
+
+	/*
+	 * Ensure that MONITOR/MWAIT will not be used in the "play dead" loop
+	 * during hibernate image restoration, because it is likely that the
+	 * monitored address will be actually written to at that time and then
+	 * the "dead" CPU will attempt to execute instructions again, but the
+	 * address in its instruction pointer may not be possible to resolve
+	 * any more at that point (the page tables used by it previously may
+	 * have been overwritten by hibernate image data).
+	 */
+	smp_ops.play_dead = resume_play_dead;
+	ret = disable_nonboot_cpus();
+	smp_ops.play_dead = play_dead;
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
@@ -1622,7 +1622,7 @@ static inline void mwait_play_dead(void)
 	}
 }
 
-static inline void hlt_play_dead(void)
+void hlt_play_dead(void)
 {
 	if (__this_cpu_read(cpu_info.x86) >= 4)
 		wbinvd();
Index: linux-pm/arch/x86/include/asm/smp.h
===================================================================
--- linux-pm.orig/arch/x86/include/asm/smp.h
+++ linux-pm/arch/x86/include/asm/smp.h
@@ -135,6 +135,7 @@ int native_cpu_up(unsigned int cpunum, s
 int native_cpu_disable(void);
 int common_cpu_die(unsigned int cpu);
 void native_cpu_die(unsigned int cpu);
+void hlt_play_dead(void);
 void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);

