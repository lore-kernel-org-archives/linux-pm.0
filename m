From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 44/44] cpufreq: omap: call cpufreq_frequency_table_put_attr()
Date: Mon, 16 Sep 2013 18:56:46 +0530
Message-ID: <ded537369f69600f536fc6dff8e489b07002fc11.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47692 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab3IPNbL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:31:11 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so5358562pad.37
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:31:11 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Drivers which have an exit path must call cpufreq_frequency_table_put_attr() if
they have called cpufreq_frequency_table_get_attr() in their init path.

This driver was missing this part and is fixed with this patch.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/omap-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index b68ce4e..091f233 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -221,6 +221,7 @@ fail_ck:
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
+	cpufreq_frequency_table_put_attr(policy->cpu);
 	freq_table_free();
 	clk_put(mpu_clk);
 	return 0;
-- 
1.7.12.rc2.18.g61b472e

