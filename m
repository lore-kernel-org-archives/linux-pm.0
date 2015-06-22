From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/10] cpufreq: conservative: Avoid races with transition notifier
Date: Mon, 22 Jun 2015 13:32:49 +0530
Message-ID: <41ef05ed3b93677b4519e4c6c758753a7e63d432.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35132 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbbFVIDP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 04:03:15 -0400
Received: by pdbci14 with SMTP id ci14so75090367pdb.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 01:03:14 -0700 (PDT)
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

It is possible that cpufreq transition notifier is called while the
governor is performing its EXIT operation. If this happens, 'ccdbs'
may get updated to NULL, while it is being accessed from the notifier
callback. And that will result in NULL pointer dereference.

ccdbs is used here just to get cpufreq policy, which can be obtained
from cpufreq_cpu_get() as well. And so the reference to ccdbs can be
avoided.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 0e4154e584bf..1e3cabfb2b57 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -119,12 +119,13 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 	struct cpufreq_freqs *freq = data;
 	struct cs_cpu_dbs_info_s *dbs_info =
 					&per_cpu(cs_cpu_dbs_info, freq->cpu);
-	struct cpufreq_policy *policy;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
 
-	if (!dbs_info->enable)
+	if (!policy)
 		return 0;
 
-	policy = dbs_info->cdbs.ccdbs->policy;
+	if (!dbs_info->enable)
+		goto policy_put;
 
 	/*
 	 * we only care if our internally tracked freq moves outside the 'valid'
@@ -134,6 +135,9 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 			|| dbs_info->requested_freq < policy->min)
 		dbs_info->requested_freq = freq->new;
 
+policy_put:
+	cpufreq_cpu_put(policy);
+
 	return 0;
 }
 
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
