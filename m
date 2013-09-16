From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 12/44] cpufreq: e_powersaver: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:14 +0530
Message-ID: <86ee5d4ecb14920b09660510dd8afd0587d0505a.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37345 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab3IPN2A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:28:00 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so5387882pad.9
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:27:59 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/e_powersaver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 09f64cc..c1b7c99 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -403,13 +403,12 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 140000; /* 844mV -> 700mV in ns */
 	policy->cur = fsb * current_multiplier;
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, &centaur->freq_table[0]);
+	ret = cpufreq_table_validate_and_show(policy, &centaur->freq_table[0]);
 	if (ret) {
 		kfree(centaur);
 		return ret;
 	}
 
-	cpufreq_frequency_table_get_attr(&centaur->freq_table[0], policy->cpu);
 	return 0;
 }
 
-- 
1.7.12.rc2.18.g61b472e

