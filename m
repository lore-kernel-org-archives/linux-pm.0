From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 18/37] cpufreq: kirkwood: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:02:07 +0530
Message-ID: <f52b0b6a54102c80abcfcc4011726bb15c076e50.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47462 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823Ab3HNNfI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2013 09:35:08 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so5735085pdi.27
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2013 06:35:07 -0700 (PDT)
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Andrew Lunn <andrew@lunn.ch>

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index d0d107a..c3d6987 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -109,7 +109,6 @@ static int kirkwood_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 5000; /* 5uS */
-	policy->cur = kirkwood_cpufreq_get_cpu_frequency(0);
 
 	return cpufreq_table_validate_and_show(policy, kirkwood_freq_table);
 }
-- 
1.7.12.rc2.18.g61b472e

