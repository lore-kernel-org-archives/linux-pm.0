From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: longhaul: Revert transition_delay_us to 200 ms
Date: Thu,  7 Dec 2017 15:15:19 +0530
Message-ID: <4985fe0a825edcd4b5a13f4c42e4d5b8f49d25ff.1512639844.git.viresh.kumar@linaro.org>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35316 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdLGJpa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Dec 2017 04:45:30 -0500
Received: by mail-pg0-f65.google.com with SMTP id q20so4108713pgv.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2017 01:45:29 -0800 (PST)
In-Reply-To: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, mroos@linux.ee
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 14+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org

The commit e948bc8fbee0 ("cpufreq: Cap the default transition delay
value to 10 ms") caused a regression on EPIA-M min-ITX computer where
shutdown or reboot hangs occasionally with a print message like:

longhaul: Warning: Timeout while waiting for idle PCI bus
cpufreq: __target_index: Failed to change cpu frequency: -16

This probably happens because the cpufreq governor tries to change the
frequency of the CPU faster than allowed by the hardware.

Before the above commit, the default transition delay was set to 200 ms
for a transition_latency of 200000 ns. Lets revert back to that
transition delay value to fix it. Note that several other transition
delay values were tested like 20 ms and 30 ms and none of them have
resolved system hang issue completely.

Fixes: e948bc8fbee0 ("cpufreq: Cap the default transition delay value to 10 ms")
Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
Reported-by: Meelis Roos <mroos@linux.ee>
Suggested-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- s/20 ms/200 ms.

 drivers/cpufreq/longhaul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index c46a12df40dd..5faa37c5b091 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -894,7 +894,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 	if ((longhaul_version != TYPE_LONGHAUL_V1) && (scale_voltage != 0))
 		longhaul_setup_voltagescaling();
 
-	policy->cpuinfo.transition_latency = 200000;	/* nsec */
+	policy->transition_delay_us = 200000;	/* usec */
 
 	return cpufreq_table_validate_and_show(policy, longhaul_table);
 }
-- 
2.14.1
