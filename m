From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 22/44] cpufreq: p4-clockmod: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:24 +0530
Message-ID: <aea01f3a28287e41caf3a840ad86c16aa30b1f3f.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:49990 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab3IPN2z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:28:55 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so5391185pad.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:28:55 -0700 (PDT)
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/p4-clockmod.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 2f0a2a6..03478bf 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -230,7 +230,6 @@ static int cpufreq_p4_cpu_init(struct cpufreq_policy *policy)
 		else
 			p4clockmod_table[i].frequency = (stock_freq * i)/8;
 	}
-	cpufreq_frequency_table_get_attr(p4clockmod_table, policy->cpu);
 
 	/* cpuinfo and default policy values */
 
@@ -239,7 +238,7 @@ static int cpufreq_p4_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 10000001;
 	policy->cur = stock_freq;
 
-	return cpufreq_frequency_table_cpuinfo(policy, &p4clockmod_table[0]);
+	return cpufreq_table_validate_and_show(policy, &p4clockmod_table[0]);
 }
 
 
-- 
1.7.12.rc2.18.g61b472e

