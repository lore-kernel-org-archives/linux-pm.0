From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 135/228] cpufreq: kirkwood: use cpufreq_generic_init() routine
Date: Fri, 13 Sep 2013 18:31:21 +0530
Message-ID: <76198830de8f8fd9f8bcbba08ac4888d15e2c88a.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:57693 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933596Ab3IMNS7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:18:59 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so2532772pab.29
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:18:59 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index dc434c4..fff8653 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -120,10 +120,7 @@ static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
 /* Module init and exit code */
 static int kirkwood_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency = 5000; /* 5uS */
-
-	return cpufreq_table_validate_and_show(policy, kirkwood_freq_table);
+	return cpufreq_generic_init(policy, kirkwood_freq_table, 5000);
 }
 
 static struct cpufreq_driver kirkwood_cpufreq_driver = {
-- 
1.7.12.rc2.18.g61b472e

