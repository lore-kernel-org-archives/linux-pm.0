From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/9] ARM: EXYNOS: cpuidle: fix AFTR mode check
Date: Tue, 20 Aug 2013 16:23:39 +0200
Message-ID: <1377008627-32691-2-git-send-email-b.zolnierkie@samsung.com>
References: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59006 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab3HTOYx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 10:24:53 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU005YE2PBJFE0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Aug 2013 23:24:52 +0900 (KST)
In-reply-to: <1377008627-32691-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, Kukjin Kim <kgene.kim@samsung.com>

The EXYNOS cpuidle driver code assumes that cpuidle core will handle
dev->state_count smaller than drv->state_count but currently this is
untrue (dev->state_count is used only for handling cpuidle state sysfs
entries and drv->state_count is used for all other cases) and will not
be fixed in the future as dev->state_count is planned to be removed.

Fix the issue by checking for the max supported idle state in AFTR
state's ->enter handler (exynos4_enter_lowpower()) and entering AFTR
mode only when cores other than CPU0 are offline.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 225ee84..bb8c4e0 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -150,8 +150,8 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 {
 	int new_index = index;
 
-	/* This mode only can be entered when other core's are offline */
-	if (num_online_cpus() > 1)
+	/* AFTR can only be entered when cores other than CPU0 are offline */
+	if (num_online_cpus() > 1 || dev->cpu != 0)
 		new_index = drv->safe_state_index;
 
 	if (new_index == 0)
@@ -210,10 +210,6 @@ static int __init exynos4_init_cpuidle(void)
 		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
 		device->cpu = cpu_id;
 
-		/* Support IDLE only */
-		if (cpu_id != 0)
-			device->state_count = 1;
-
 		ret = cpuidle_register_device(device);
 		if (ret) {
 			printk(KERN_ERR "CPUidle register device failed\n");
-- 
1.8.2.3

