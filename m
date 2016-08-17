From: James Morse <james.morse@arm.com>
Subject: [PATCH v5 3/3] Revert "arm64: hibernate: Refuse to hibernate if the boot cpu is offline"
Date: Wed, 17 Aug 2016 13:50:27 +0100
Message-ID: <1471438227-8747-4-git-send-email-james.morse@arm.com>
References: <1471438227-8747-1-git-send-email-james.morse@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471438227-8747-1-git-send-email-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Now that we use the MPIDR to resume on the same CPU that we hibernated on,
we no longer need to refuse to hibernate if the boot cpu is offline. (Which
we can't possibly know if kexec causes logical CPUs to be renumbered).

This reverts commit 1fe492ce6482b77807b25d29690a48c46456beee.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
This patch should be merged via the same tree as patch 1.

 arch/arm64/kernel/hibernate.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 9fcf2fcda876..2dcd7d29f568 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -18,7 +18,6 @@
 #include <linux/cpu.h>
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
-#include <linux/notifier.h>
 #include <linux/pm.h>
 #include <linux/sched.h>
 #include <linux/suspend.h>
@@ -524,31 +523,6 @@ out:
 	return rc;
 }
 
-static int check_boot_cpu_online_pm_callback(struct notifier_block *nb,
-					     unsigned long action, void *ptr)
-{
-	if (action == PM_HIBERNATION_PREPARE &&
-	     cpumask_first(cpu_online_mask) != 0) {
-		pr_warn("CPU0 is offline.\n");
-		return notifier_from_errno(-ENODEV);
-	}
-
-	return NOTIFY_OK;
-}
-
-static int __init check_boot_cpu_online_init(void)
-{
-	/*
-	 * Set this pm_notifier callback with a lower priority than
-	 * cpu_hotplug_pm_callback, so that cpu_hotplug_pm_callback will be
-	 * called earlier to disable cpu hotplug before the cpu online check.
-	 */
-	pm_notifier(check_boot_cpu_online_pm_callback, -INT_MAX);
-
-	return 0;
-}
-core_initcall(check_boot_cpu_online_init);
-
 int hibernate_resume_nonboot_cpu_disable(void)
 {
 	if (sleep_cpu < 0) {
-- 
2.8.0.rc3
