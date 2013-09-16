From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 21/44] cpufreq: omap: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:23 +0530
Message-ID: <fc4c9c666a259df7171e009c04d578b0570ca449.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:45168 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399Ab3IPN2u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:28:50 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so4067978pbc.4
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:28:50 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/omap-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index f31fcfc..b68ce4e 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -191,12 +191,10 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
 
 	atomic_inc_return(&freq_table_users);
 
-	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	result = cpufreq_table_validate_and_show(policy, freq_table);
 	if (result)
 		goto fail_table;
 
-	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
-
 	policy->cur = omap_getspeed(policy->cpu);
 
 	/*
-- 
1.7.12.rc2.18.g61b472e

