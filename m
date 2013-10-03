From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 77/92] cpufreq: davinci: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:29:11 +0530
Message-ID: <3a75d22dc7362ec124079c60b4ad10c3264038fe.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38588 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab3JCPHe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:07:34 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so2593807pbc.31
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:07:34 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Sekhar Nori <nsekhar@ti.com>

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 7762efc..f3373e6 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -138,21 +138,13 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 			return result;
 	}
 
-	result = cpufreq_table_validate_and_show(policy, freq_table);
-	if (result) {
-		pr_err("%s: cpufreq_table_validate_and_show() failed",
-				__func__);
-		return result;
-	}
-
 	/*
 	 * Time measurement across the target() function yields ~1500-1800us
 	 * time taken with no drivers on notification list.
 	 * Setting the latency to 2000 us to accommodate addition of drivers
 	 * to pre/post change notification list.
 	 */
-	policy->cpuinfo.transition_latency = 2000 * 1000;
-	return 0;
+	return cpufreq_generic_init(policy, freq_table, 2000 * 1000);
 }
 
 static struct cpufreq_driver davinci_driver = {
-- 
1.7.12.rc2.18.g61b472e

