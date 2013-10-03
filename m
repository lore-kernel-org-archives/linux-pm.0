From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 36/92] cpufreq: call cpufreq_driver->get() after calling ->init()
Date: Thu,  3 Oct 2013 20:28:30 +0530
Message-ID: <c10dca2086f401ff5f33902c2b00f39a185e3ffa.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:63036 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab3JCPDZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:03:25 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so2592134pde.37
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:03:25 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Almost all drivers set policy->cur with current cpu frequency in their ->init()
part. This can be done for all of them at core level and so they wouldn't need
to do it.

This patch adds supporting code in cpufreq core for calling get() after we have
called init() for a policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 04548f7..1a944f7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1053,6 +1053,14 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		goto err_set_policy_cpu;
 	}
 
+	if (cpufreq_driver->get) {
+		policy->cur = cpufreq_driver->get(policy->cpu);
+		if (!policy->cur) {
+			pr_err("%s: ->get() failed\n", __func__);
+			goto err_get_freq;
+		}
+	}
+
 	/* related cpus should atleast have policy->cpus */
 	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
 
@@ -1107,6 +1115,9 @@ err_out_unregister:
 		per_cpu(cpufreq_cpu_data, j) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+err_get_freq:
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
 	cpufreq_policy_free(policy);
 nomem_out:
-- 
1.7.12.rc2.18.g61b472e

