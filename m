From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: ppc-corenet: remove duplicate update of cpu_data
Date: Tue,  2 Sep 2014 09:11:24 +0530
Message-ID: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:52952 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbaIBDlm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Sep 2014 23:41:42 -0400
Received: by mail-pd0-f179.google.com with SMTP id z10so7426007pdj.24
        for <linux-pm@vger.kernel.org>; Mon, 01 Sep 2014 20:41:42 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, yuantian.tang@freescale.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, hongbo.zhang@freescale.com, leoli@freescale.com, Viresh Kumar <viresh.kumar@linaro.org>

'cpu_data' is updated for policy->cpu first and then for all CPUs in
policy->cpus. policy->cpus is guaranteed to contain policy->cpu as well and so
the first write to 'cpu_data' for policy->cpu is redundant. Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Yuantian,

I was looking into this driver due to issues reported by Hongtao (cc'd) and
found that we can live without some code. These aren't fixing any bugs and are
just cleanups.

I didn't had a compiler for this and so this isn't even compiled. It would be
great if you can please review/test these patches.

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

