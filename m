From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 23/44] cpufreq: pasemi: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:25 +0530
Message-ID: <5e4d862be96ed0934920267cecdcb402096914f6.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:33656 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab3IPN3B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:29:01 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so4054390pbc.36
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:29:00 -0700 (PDT)
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
 drivers/cpufreq/pasemi-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 534e43a..23bc8a82 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -219,12 +219,10 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	ppc_proc_freq = policy->cur * 1000ul;
 
-	cpufreq_frequency_table_get_attr(pas_freqs, policy->cpu);
-
 	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max
 	 * are set correctly
 	 */
-	return cpufreq_frequency_table_cpuinfo(policy, pas_freqs);
+	return cpufreq_table_validate_and_show(policy, pas_freqs);
 
 out_unmap_sdcpwr:
 	iounmap(sdcpwr_mapbase);
-- 
1.7.12.rc2.18.g61b472e

