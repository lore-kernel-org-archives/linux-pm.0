From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 16/27] ARM: cpuidle: Record the next wakeup event of the CPU
Date: Tue, 17 Nov 2015 15:37:40 -0700
Message-ID: <1447799871-56374-17-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35105 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932585AbbKQWiv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:38:51 -0500
Received: by pacej9 with SMTP id ej9so22076887pac.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:38:50 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>

Reading the next wakeup of the CPU can only be realiably done only from
that CPU. In the idle enter path record the next wake up of the CPU. The
information is useful to determine the sleep time left for the CPU.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 8e72a23..b3133ef 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -18,9 +18,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/rcupdate.h>
+#include <linux/tick.h>
 
 #include <asm/cpuidle.h>
 
@@ -49,7 +51,9 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 	ret = cpu_pm_enter();
 	if (!ret) {
 		struct device *cpu_dev = get_cpu_device(dev->cpu);
+		struct generic_pm_domain_data *gpd = dev_gpd_data(cpu_dev);
 
+		gpd->td.next_wakeup = tick_nohz_get_next_wakeup();
 		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
 
 		/*
@@ -60,6 +64,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 		arm_cpuidle_suspend(idx);
 
 		RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
+		gpd->td.next_wakeup.tv64 = 0;
 		cpu_pm_exit();
 	}
 
-- 
2.1.4

