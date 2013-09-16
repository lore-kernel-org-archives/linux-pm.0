From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 13/44] cpufreq: elanfreq: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:15 +0530
Message-ID: <39b6cc738774955b48a765310f659491a27cc459.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:34611 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab3IPN2G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:28:06 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so4067234pbc.4
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:28:06 -0700 (PDT)
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
 drivers/cpufreq/elanfreq.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 823a400..4000c34 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -202,7 +202,6 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
 	unsigned int i;
-	int result;
 
 	/* capability check */
 	if ((c->x86_vendor != X86_VENDOR_AMD) ||
@@ -223,12 +222,7 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	policy->cur = elanfreq_get_cpu_frequency(0);
 
-	result = cpufreq_frequency_table_cpuinfo(policy, elanfreq_table);
-	if (result)
-		return result;
-
-	cpufreq_frequency_table_get_attr(elanfreq_table, policy->cpu);
-	return 0;
+	return cpufreq_table_validate_and_show(policy, elanfreq_table);
 }
 
 
-- 
1.7.12.rc2.18.g61b472e

