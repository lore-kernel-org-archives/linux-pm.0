From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 10/16] drivers: cpuidle: Add runtime PM support for CPUIdle
Date: Fri, 26 Jun 2015 21:02:30 -0600
Message-ID: <1435374156-19214-11-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34943 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbbF0DDA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:03:00 -0400
Received: by pdbci14 with SMTP id ci14so84810814pdb.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:02:59 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Notify runtime PM when the CPU is going to be powered off in the idle
state. This allows for runtime PM suspend/resume of the CPU's PM domain.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 545069d..77fd673 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -11,12 +11,14 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include <asm/cpuidle.h>
@@ -45,12 +47,20 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 
 	ret = cpu_pm_enter();
 	if (!ret) {
+		struct device *cpu_dev = get_cpu_device(dev->cpu);
+
+		/*
+		 * Notify runtime PM as well of this cpu powering down
+		 * TODO: Merge CPU_PM and runtime PM.
+		 */
+		pm_runtime_put_sync(cpu_dev);
 		/*
 		 * Pass idle state index to cpu_suspend which in turn will
 		 * call the CPU ops suspend protocol with idle index as a
 		 * parameter.
 		 */
 		arm_cpuidle_suspend(idx);
+		pm_runtime_get_sync(cpu_dev);
 
 		cpu_pm_exit();
 	}
@@ -146,6 +156,7 @@ static int __init arm_idle_init(void)
 			kfree(dev);
 			goto out_fail;
 		}
+
 	}
 
 	return 0;
-- 
2.1.4

