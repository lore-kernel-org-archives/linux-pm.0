From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 58/92] cpufreq: p4: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:52 +0530
Message-ID: <141618c10f90a5477c5a9d77d9369ef1a16506d5.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:49082 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab3JCPFn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:05:43 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so2573975pdj.30
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:05:43 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "David S. Miller" <davem@davemloft.net>

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/p4-clockmod.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 4fe6d4c..6164c1c 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -230,7 +230,6 @@ static int cpufreq_p4_cpu_init(struct cpufreq_policy *policy)
 	/* the transition latency is set to be 1 higher than the maximum
 	 * transition latency of the ondemand governor */
 	policy->cpuinfo.transition_latency = 10000001;
-	policy->cur = stock_freq;
 
 	return cpufreq_table_validate_and_show(policy, &p4clockmod_table[0]);
 }
-- 
1.7.12.rc2.18.g61b472e

