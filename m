From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/4] cpufreq-dt: pass 'policy->related_cpus' to of_cpufreq_cooling_register()
Date: Thu, 27 Nov 2014 06:07:50 +0530
Message-ID: <20dee4a7aa3e5fded99f93705bdf7b5623295815.1417048449.git.viresh.kumar@linaro.org>
References: <cover.1417048449.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59985 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaK0Ai2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:38:28 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so3868715pab.33
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 16:38:27 -0800 (PST)
In-Reply-To: <cover.1417048449.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417048449.git.viresh.kumar@linaro.org>
References: <cover.1417048449.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

The second parameter of of_cpufreq_cooling_register() should be the CPUs to
which the frequency constraint will apply. As the cpufreq-dt driver now supports
platforms with multiple 'struct cpufreq_policy' instances (i.e. > 1 clock
domains for CPUs), passing 'cpu_present_mask' isn't correct anymore. As every
policy will have a set of CPUs and that may not be equal to 'cpu_present_mask'
always.

So, pass only mask of CPUs which are controlled by current policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Eduardo Valentin <edubezval@gmail.com>
Tested-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/cpufreq-dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8cba13d..7374fc4 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -274,7 +274,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 * thermal DT code takes care of matching them.
 	 */
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		cdev = of_cpufreq_cooling_register(np, cpu_present_mask);
+		cdev = of_cpufreq_cooling_register(np, policy->related_cpus);
 		if (IS_ERR(cdev))
 			dev_err(cpu_dev,
 				"running cpufreq without cooling device: %ld\n",
-- 
2.0.3.693.g996b0fd

