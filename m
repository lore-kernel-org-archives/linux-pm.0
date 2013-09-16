From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 29/44] cpufreq: s5pv210: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:31 +0530
Message-ID: <8877e4d3c24d6e1a54a393314ce49f6a7adda0b7.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:59100 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab3IPN3e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:29:34 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so4078094pbc.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:29:33 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 5c77570..c266a7e 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -553,11 +553,9 @@ static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = policy->min = policy->max = s5pv210_getspeed(0);
 
-	cpufreq_frequency_table_get_attr(s5pv210_freq_table, policy->cpu);
-
 	policy->cpuinfo.transition_latency = 40000;
 
-	return cpufreq_frequency_table_cpuinfo(policy, s5pv210_freq_table);
+	return cpufreq_table_validate_and_show(policy, s5pv210_freq_table);
 
 out_dmc1:
 	clk_put(dmc0_clk);
-- 
1.7.12.rc2.18.g61b472e

