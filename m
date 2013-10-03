From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 86/92] cpufreq: pmac32: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:29:20 +0530
Message-ID: <483660116fd16da021c996c78ae2c72b339de10d.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:40662 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab3JCPIZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:08:25 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so2576437pbc.40
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:08:24 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pmac32-cpufreq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 672b7f4..6eac1e2 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -392,12 +392,7 @@ static int pmac_cpufreq_target(	struct cpufreq_policy *policy,
 
 static int pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	if (policy->cpu != 0)
-		return -ENODEV;
-
-	policy->cpuinfo.transition_latency	= transition_latency;
-
-	return cpufreq_table_validate_and_show(policy, pmac_cpu_freqs);
+	return cpufreq_generic_init(policy, pmac_cpu_freqs, transition_latency);
 }
 
 static u32 read_gpio(struct device_node *np)
-- 
1.7.12.rc2.18.g61b472e

