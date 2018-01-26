From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] opp: cpu: Replace GFP_ATOMIC with GFP_KERNEL in dev_pm_opp_init_cpufreq_table
Date: Fri, 26 Jan 2018 16:48:49 +0800
Message-ID: <1516956529-32264-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38947 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbeAZIoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jan 2018 03:44:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>

After checking all possible call chains to 
dev_pm_opp_init_cpufreq_table() here,
my tool finds that this function is never called in atomic context, 
namely never in an interrupt handler or holding a spinlock.
And dev_pm_opp_init_cpufreq_table() calls dev_pm_opp_get_opp_count(), 
which calls mutex_lock that can sleep.
It indicates that atmtcp_v_send() can call functions which may sleep.
Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/opp/cpu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 2d87bc1..0c09107 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -55,7 +55,7 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 	if (max_opps <= 0)
 		return max_opps ? max_opps : -ENODATA;
 
-	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_ATOMIC);
+	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_KERNEL);
 	if (!freq_table)
 		return -ENOMEM;
 
-- 
1.7.9.5
