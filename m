From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 2/2] cpufreq: acpi: policy->driver_data can't be NULL in ->exit()
Date: Thu,  7 Apr 2016 14:06:58 +0530
Message-ID: <a03d2da898006ac21e6ba25b9cc583cc98538e56.1460018171.git.viresh.kumar@linaro.org>
References: <31560235fc686a26bb5d975059d480fd9e645b17.1460018171.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <31560235fc686a26bb5d975059d480fd9e645b17.1460018171.git.viresh.kumar@linaro.org>
In-Reply-To: <31560235fc686a26bb5d975059d480fd9e645b17.1460018171.git.viresh.kumar@linaro.org>
References: <31560235fc686a26bb5d975059d480fd9e645b17.1460018171.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Its always set by ->init() and so it will always be there in ->exit().
There is no need to have a special check for just that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 4fe67775555a..74182209bab7 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -887,14 +887,12 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 	pr_debug("acpi_cpufreq_cpu_exit\n");
 
-	if (data) {
-		policy->fast_switch_possible = false;
-		policy->driver_data = NULL;
-		acpi_processor_unregister_performance(data->acpi_perf_cpu);
-		free_cpumask_var(data->freqdomain_cpus);
-		kfree(policy->freq_table);
-		kfree(data);
-	}
+	policy->fast_switch_possible = false;
+	policy->driver_data = NULL;
+	acpi_processor_unregister_performance(data->acpi_perf_cpu);
+	free_cpumask_var(data->freqdomain_cpus);
+	kfree(policy->freq_table);
+	kfree(data);
 
 	return 0;
 }
-- 
2.7.1.410.g6faf27b
