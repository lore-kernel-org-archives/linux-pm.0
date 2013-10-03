From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 82/92] cpufreq: loongson2: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:29:16 +0530
Message-ID: <9df5c5f8c8186ee7c976729b69e139066e4ac36b.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:61374 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab3JCPIC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:08:02 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so2573599pbc.39
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:08:02 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Use generic cpufreq_generic_init() routine instead of replicating the same code
here. This driver wasn't setting transition_latency and so is getting set to 0
by default. Lets mark it explicitly by calling the generic routine with
transition_latency as 0.

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/loongson2_cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index dd4f3e4..2c8ec8e 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -131,8 +131,7 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	return cpufreq_table_validate_and_show(policy,
-					    &loongson2_clockmod_table[0]);
+	return cpufreq_generic_init(policy, &loongson2_clockmod_table[0], 0);
 }
 
 static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
-- 
1.7.12.rc2.18.g61b472e

