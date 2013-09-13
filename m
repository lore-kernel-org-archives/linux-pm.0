From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 139/228] cpufreq: pasemi: use cpufreq_generic_init() routine
Date: Fri, 13 Sep 2013 18:31:25 +0530
Message-ID: <d73e3d98a7adf10f7d84aa5a1e09aa37e6864828.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:39139 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933641Ab3IMNT1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:19:27 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so2525684pac.31
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:19:27 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pasemi-cpufreq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 16f2508..1cca332 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -204,20 +204,13 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		pr_debug("%d: %d\n", i, pas_freqs[i].frequency);
 	}
 
-	policy->cpuinfo.transition_latency = get_gizmo_latency();
-
 	cur_astate = get_cur_astate(policy->cpu);
 	pr_debug("current astate is at %d\n",cur_astate);
 
 	policy->cur = pas_freqs[cur_astate].frequency;
-	cpumask_copy(policy->cpus, cpu_online_mask);
-
 	ppc_proc_freq = policy->cur * 1000ul;
 
-	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max
-	 * are set correctly
-	 */
-	return cpufreq_table_validate_and_show(policy, pas_freqs);
+	return cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
 
 out_unmap_sdcpwr:
 	iounmap(sdcpwr_mapbase);
-- 
1.7.12.rc2.18.g61b472e

