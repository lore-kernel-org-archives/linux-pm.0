From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Send START policy notifier after sending CREATE
Date: Tue, 24 May 2016 10:26:50 +0530
Message-ID: <5ad28985448ea96b9e952b5d722cfc4f70ab9549.1464065802.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35019 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbcEXE45 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 00:56:57 -0400
Received: by mail-pf0-f170.google.com with SMTP id g64so2889615pfb.2
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 21:56:57 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

The sequence got a bit wrong as we are sending CPUFREQ_START notifier
even before we have sent CPUFREQ_CREATE_POLICY.

Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 36bc11a106aa..c3f950f0e5f0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1265,9 +1265,6 @@ static int cpufreq_online(unsigned int cpu)
 		}
 	}
 
-	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-				     CPUFREQ_START, policy);
-
 	if (new_policy) {
 		ret = cpufreq_add_dev_interface(policy);
 		if (ret)
@@ -1280,6 +1277,9 @@ static int cpufreq_online(unsigned int cpu)
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 	}
 
+	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+				     CPUFREQ_START, policy);
+
 	ret = cpufreq_init_policy(policy);
 	if (ret) {
 		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
-- 
2.7.1.410.g6faf27b

