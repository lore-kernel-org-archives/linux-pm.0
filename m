From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: acpi: policy->driver_data can't be NULL in ->exit()
Date: Wed, 30 Mar 2016 09:54:24 +0530
Message-ID: <f4f0e029b46cdd09dd7d3f0035e8588f5de94e21.1459311858.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33946 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbcC3EYg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 00:24:36 -0400
Received: by mail-pa0-f44.google.com with SMTP id fe3so30303781pab.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 21:24:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Its always set by ->init() and so it will always be there in ->exit().
There is no need to have a special check for just that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index eb2196f9d7fa..e20cbb1317cc 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -847,13 +847,11 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 	pr_debug("acpi_cpufreq_cpu_exit\n");
 
-	if (data) {
-		policy->driver_data = NULL;
-		acpi_processor_unregister_performance(data->acpi_perf_cpu);
-		free_cpumask_var(data->freqdomain_cpus);
-		kfree(policy->freq_table);
-		kfree(data);
-	}
+	policy->driver_data = NULL;
+	acpi_processor_unregister_performance(data->acpi_perf_cpu);
+	free_cpumask_var(data->freqdomain_cpus);
+	kfree(policy->freq_table);
+	kfree(data);
 
 	return 0;
 }
-- 
2.7.1.410.g6faf27b

