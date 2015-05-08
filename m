From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 06/14] cpufreq: Mark policy->governor = NULL for inactive policies
Date: Fri,  8 May 2015 11:53:49 +0530
Message-ID: <58eb9c886496ba58c3fbdf5afb261ed89b157d0e.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35844 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbbEHGYx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 02:24:53 -0400
Received: by pdea3 with SMTP id a3so67124884pde.3
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 23:24:53 -0700 (PDT)
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

Later commits would change the way policies are managed today. Policies
wouldn't be freed on cpu hotplug (currently they aren't freed on
suspend), and while the CPU is offline, the sysfs cpufreq files would
still be present.

Because we don't mark policy->governor as NULL, it still contains
pointer of the last used governor. And if the governor is removed, while
all the CPUs of a policy are hotplugged out, this pointer wouldn't be
valid anymore. And if we try to read the 'scaling_governor', etc.  from
sysfs, it will result in kernel OOPs.

To prevent this, mark policy->governor as NULL for all inactive policies
while the governor is removed from kernel.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5e87679ec6d1..bd8a47b5054e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1095,7 +1095,6 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	if (likely(policy)) {
 		/* Policy should be inactive here */
 		WARN_ON(!policy_is_inactive(policy));
-		policy->governor = NULL;
 	}
 
 	return policy;
@@ -2157,8 +2156,10 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
 	/* clear last_governor for all inactive policies */
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 	for_each_inactive_policy(policy, tpolicy) {
-		if (!strcmp(policy->last_governor, governor->name))
+		if (!strcmp(policy->last_governor, governor->name)) {
+			policy->governor = NULL;
 			strcpy(policy->last_governor, "\0");
+		}
 	}
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-- 
2.4.0

