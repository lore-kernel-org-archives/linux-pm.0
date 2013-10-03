From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 50/92] cpufreq: ia64-acpi: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:44 +0530
Message-ID: <c44bff3cd7359d40532be9ccf3566272dc86e48e.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Tony Luck <tony.luck@intel.com>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index b958bdb..90c6598 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -305,7 +305,6 @@ acpi_cpufreq_cpu_init (
 			    data->acpi_data.states[i].transition_latency * 1000;
 		}
 	}
-	policy->cur = processor_get_freq(data, policy->cpu);
 
 	/* table init */
 	for (i = 0; i <= data->acpi_data.state_count; i++)
-- 
1.7.12.rc2.18.g61b472e

