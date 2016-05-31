From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Fix incorrect usage of clamp_val()
Date: Tue, 31 May 2016 16:49:42 +0530
Message-ID: <a5c21ebe773d364b49bc5df9c4f69ff2eb181dbb.1464693539.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35435 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbcEaLTt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 07:19:49 -0400
Received: by mail-pa0-f43.google.com with SMTP id fy7so54063980pac.2
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 04:19:49 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

clamp_val() doesn't change anything by itself, rather it returns the
clamped value.

Fix it.

Fixes: 0ac587b32f49 ("cpufreq: Use clamp_val() in __cpufreq_driver_target()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Rafael,

Please merge this with the offending commit if you are fine with rebase,
else apply this one as well.

Sorry for blindly copying code.

 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d0c02a7eec0f..c6a14ba239a2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1927,7 +1927,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 		return -ENODEV;
 
 	/* Make sure that target_freq is within supported range */
-	clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, policy->min, policy->max);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
-- 
2.7.1.410.g6faf27b

