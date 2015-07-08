From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Initialize the governor again while restoring policy
Date: Wed,  8 Jul 2015 11:23:58 +0530
Message-ID: <f428ecb0927075b25cf7e2ea5fb00eab3d254fdd.1436333568.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35502 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbbGHFyE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 01:54:04 -0400
Received: by pdrg1 with SMTP id g1so7897997pdr.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2015 22:54:04 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, open list <linux-kernel@vger.kernel.org>

When all CPUs of a policy are hot-unplugged, we EXIT the governor but
don't mark policy->governor as NULL. This was done in order to keep last
used governor's information intact in sysfs, while the CPUs are offline.

We also missed marking policy->governor as NULL while restoring the
policy. Because of that, we call __cpufreq_governor(CPUFREQ_GOV_LIMITS)
for an uninitialized policy. Which eventually returns -EBUSY.

Fix this by setting policy->governor to NULL while restoring the policy.

Reported-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Reported-by: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Fixes: 18bf3a124ef8 ("cpufreq: Mark policy->governor = NULL for inactive policies")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
For 4.2-rc

 drivers/cpufreq/cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b612411655f9..2c22e3902e72 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1132,6 +1132,7 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 
 		down_write(&policy->rwsem);
 		policy->cpu = cpu;
+		policy->governor = NULL;
 		up_write(&policy->rwsem);
 	}
 
-- 
2.4.0

