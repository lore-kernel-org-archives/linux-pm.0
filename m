From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 56/92] cpufreq: maple: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:50 +0530
Message-ID: <cbd9d440c8dec46248b2811355514b43527b4395.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49473 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab3JCPFb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:05:31 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so2603111pbc.15
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:05:31 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/maple-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index b23d1d8..1c0cec1 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -166,7 +166,6 @@ static unsigned int maple_cpufreq_get_speed(unsigned int cpu)
 static int maple_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	policy->cpuinfo.transition_latency = 12000;
-	policy->cur = maple_cpu_freqs[maple_scom_query_freq()].frequency;
 	/* secondary CPUs are tied to the primary one by the
 	 * cpufreq core if in the secondary policy we tell it that
 	 * it actually must be one policy together with all others. */
-- 
1.7.12.rc2.18.g61b472e

