From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 19/44] cpufreq: loongson2: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:21 +0530
Message-ID: <cca17b75af3df5a6466925e553ab3289e5f71c7c.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:39560 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab3IPN2j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:28:39 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so5360330pab.35
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:28:39 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: John Crispin <blogic@openwrt.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/loongson2_cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index 7bc3c44..5dd3692 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -133,10 +133,7 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = loongson2_cpufreq_get(policy->cpu);
 
-	cpufreq_frequency_table_get_attr(&loongson2_clockmod_table[0],
-					 policy->cpu);
-
-	return cpufreq_frequency_table_cpuinfo(policy,
+	return cpufreq_table_validate_and_show(policy,
 					    &loongson2_clockmod_table[0]);
 }
 
-- 
1.7.12.rc2.18.g61b472e

