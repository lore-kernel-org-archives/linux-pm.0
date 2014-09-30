From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH resend] cpufreq: ppc-corenet: remove duplicate update of cpu_data
Date: Tue, 30 Sep 2014 09:19:57 +0530
Message-ID: <5714b9e8a37bd5aea5f77676b75d9e7773e0f0e2.1412048958.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:63090 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbaI3DuG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 23:50:06 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so5615420pad.16
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2014 20:50:06 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, yuantian.tang@freescale.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

'cpu_data' is updated for policy->cpu first and then for all CPUs in
policy->cpus. policy->cpus is guaranteed to contain policy->cpu as well and so
the first write to 'cpu_data' for policy->cpu is redundant. Remove it.

Acked-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 3607070..bee5df7 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -199,7 +199,6 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	data->table = table;
-	per_cpu(cpu_data, cpu) = data;
 
 	/* update ->cpus if we have cluster, no harm if not */
 	cpumask_copy(policy->cpus, per_cpu(cpu_mask, cpu));
-- 
2.0.3.693.g996b0fd

