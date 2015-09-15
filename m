From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: cpufreq_cpu_get_raw() isn't a static function anymore
Date: Tue, 15 Sep 2015 13:40:16 +0530
Message-ID: <d7e3e729d09d15cfc73ebaf251a2bb4d33ec54a9.1442303903.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35657 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbbIOIKa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 04:10:30 -0400
Received: by pacfv12 with SMTP id fv12so173136878pac.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2015 01:10:30 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, alexandra.yates@linux.intel.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

Its used outside of the core file and is exported as well. Drop the
'static' keyword from its declaration and fix below build error:

linux/drivers/cpufreq/cpufreq.c:241:31: error: static declaration of
'cpufreq_cpu_get_raw' follows non-static declaration

Fixes: 503655f70d9b ("cpufreq: acpi-cpufreq: Use cpufreq_cpu_get_raw() in ->get()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a8252bb0f80c..ef5ed9470de9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -238,7 +238,7 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_init);
 
-static struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
+struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
-- 
2.4.0

