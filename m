From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 05/44] cpufreq: acpi-cpufreq: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:07 +0530
Message-ID: <459b18c12f53aaf04058a0f8fc208c26a4491e67.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34258 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab3IPN1U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:27:20 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so5342240pac.17
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:27:20 -0700 (PDT)
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
 drivers/cpufreq/acpi-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index a1260b4..71f8e15 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -837,7 +837,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	data->freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
 	perf->state = 0;
 
-	result = cpufreq_frequency_table_cpuinfo(policy, data->freq_table);
+	result = cpufreq_table_validate_and_show(policy, data->freq_table);
 	if (result)
 		goto err_freqfree;
 
@@ -868,8 +868,6 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 			(u32) perf->states[i].power,
 			(u32) perf->states[i].transition_latency);
 
-	cpufreq_frequency_table_get_attr(data->freq_table, policy->cpu);
-
 	/*
 	 * the first call to ->target() should result in us actually
 	 * writing something to the appropriate registers.
-- 
1.7.12.rc2.18.g61b472e

