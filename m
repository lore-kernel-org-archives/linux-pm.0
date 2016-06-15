From: James Morse <james.morse@arm.com>
Subject: [PATCH v2 6/6] Revert "arm64: hibernate: Refuse to hibernate if the boot cpu is offline"
Date: Wed, 15 Jun 2016 18:35:48 +0100
Message-ID: <1466012148-7674-7-git-send-email-james.morse@arm.com>
References: <1466012148-7674-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39194 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932529AbcFORi7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 13:38:59 -0400
In-Reply-To: <1466012148-7674-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>

Now that we use the MPIDR to resume on the same CPU that we hibernated on,
we no longer need to refuse to hibernate if the boot cpu is offline. (Which
we can't possibly know if kexec causes logical CPUs to be renumbered).

This reverts commit 1fe492ce6482b77807b25d29690a48c46456beee.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/hibernate.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 5f9266aeff00..07c59cbfd615 100644
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
@@ -518,31 +517,6 @@ out:
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
 /* This overrides the weak version in kernel/power/hibernate.c */
 int arch_hibernation_disable_cpus(bool suspend)
 {
-- 
2.8.0.rc3

