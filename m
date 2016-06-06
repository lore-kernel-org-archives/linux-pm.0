From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] x86, hotplug: Use zero page for monitor when resuming from hibernation
Date: Mon,  6 Jun 2016 22:19:09 +0800
Message-ID: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Stress test from Varun Koyyalagunta reports that, the
nonboot CPU would hang occasionally, when resuming from
hibernation. Further investigation shows that, the precise
phase when nonboot CPU hangs, is the time when the nonboot
CPU been woken up incorrectly, and tries to monitor the
mwait_ptr for the second time, then an exception is
triggered due to illegal vaddr access, say, something like,
'Unable to handler kernel address of 0xffff8800ba800010...'

One of the possible scenarios for this issue is illustrated below,
when the boot CPU tries to resume from hibernation:
1. puts the nonboot CPUs offline, so the nonboot CPUs are monitoring
   at the address of the task_struct.flags.
2. boot CPU copies pages to their original address, which includes
   task_struct.flags, thus wakes up one of the nonboot CPUs.
3. nonboot CPU tries to monitor the task_struct.flags again, but since
   the page table for task_struct.flags has been overwritten by
   boot CPU, and there is probably a changed across hibernation
   (because of inconsistence of e820 memory map), an exception is
   triggered.

As suggested by Rafael and Len, this patch tries to monitor a zero
page instead of task_struct.flags, if it comes from hibernation resume
process. The zero page should be safe because it is located in .bss
and page table for kernel mapping of text/data/bss should keeps
unchanged according to hibernation semantic.

Reported-by: Varun Koyyalagunta <cpudebug@centtech.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=106371
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/smpboot.c | 16 +++++++++++++++-
 include/linux/suspend.h   |  7 +++++++
 kernel/power/hibernate.c  |  3 +++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fafe8b9..b2732ae 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -53,6 +53,7 @@
 #include <linux/stackprotector.h>
 #include <linux/gfp.h>
 #include <linux/cpuidle.h>
+#include <linux/suspend.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -1595,8 +1596,21 @@ static inline void mwait_play_dead(void)
 	 * This should be a memory location in a cache line which is
 	 * unlikely to be touched by other processors.  The actual
 	 * content is immaterial as it is not actually modified in any way.
+	 *
+	 * However in hibernation resume process, this address could be
+	 * touched by BSP when restoring page frames, if the page table
+	 * for this address is not coherent across hibernation(due to
+	 * inconsistence of e820 memory map), access from APs might
+	 * cause exception. So change the mwait address to zero page,
+	 * which is located in .bss, in this way we can avoid illegal
+	 * access from APs because page table for kernel mapping
+	 * of text/data/bss should keeps unchanged according to
+	 * hibernation semantic.
 	 */
-	mwait_ptr = &current_thread_info()->flags;
+	if (hibernation_in_resume())
+		mwait_ptr = empty_zero_page;
+	else
+		mwait_ptr = &current_thread_info()->flags;
 
 	wbinvd();
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8b6ec7e..422e87a 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -384,6 +384,12 @@ extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
+extern bool in_resume_hibernate;
+
+static inline bool hibernation_in_resume(void)
+{
+	return in_resume_hibernate;
+}
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
@@ -395,6 +401,7 @@ static inline void hibernation_set_ops(const struct platform_hibernation_ops *op
 static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
 static inline bool hibernation_available(void) { return false; }
+static inline bool hibernation_in_resume(void) { return false; }
 #endif /* CONFIG_HIBERNATION */
 
 /* Hibernation and suspend events */
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index fca9254..13c229a 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -43,6 +43,7 @@ static char resume_file[256] = CONFIG_PM_STD_PARTITION;
 dev_t swsusp_resume_device;
 sector_t swsusp_resume_block;
 __visible int in_suspend __nosavedata;
+bool in_resume_hibernate;
 
 enum {
 	HIBERNATION_INVALID,
@@ -433,7 +434,9 @@ static int resume_target_kernel(bool platform_mode)
 	if (error)
 		goto Cleanup;
 
+	in_resume_hibernate = true;
 	error = disable_nonboot_cpus();
+	in_resume_hibernate = false;
 	if (error)
 		goto Enable_cpus;
 
-- 
2.7.4
