From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/12] cpufreq: governor: Drop unused field 'cpu'
Date: Thu, 11 Jun 2015 16:21:45 +0530
Message-ID: <df4228bfaeed49925a0aca4528852de2d1b3c44f.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35027 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbbFKKwS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 06:52:18 -0400
Received: by pdbnf5 with SMTP id nf5so2453217pdb.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 03:52:18 -0700 (PDT)
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Its not used at all, drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 1 -
 drivers/cpufreq/cpufreq_governor.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 6024bbc782c0..2149ba7d32a8 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -353,7 +353,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		struct cpu_dbs_common_info *j_cdbs = cdata->get_cpu_cdbs(j);
 		unsigned int prev_load;
 
-		j_cdbs->cpu = j;
 		j_cdbs->cur_policy = policy;
 		j_cdbs->prev_cpu_idle =
 			get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 352eecaae789..1bbf8c87fdd5 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -130,7 +130,6 @@ static void *get_cpu_dbs_info_s(int cpu)				\
 
 /* Per cpu structures */
 struct cpu_dbs_common_info {
-	int cpu;
 	u64 prev_cpu_idle;
 	u64 prev_cpu_wall;
 	u64 prev_cpu_nice;
-- 
2.4.0

