From: Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: [PATCH] cpufreq: acpi: Remove some redundant code
Date: Mon, 20 Aug 2018 06:15:11 -0400
Message-ID: <1534760111-31614-1-git-send-email-dingxiang@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

For single statement blocks,braces are not necessary.
And "else" is not useful after return. So,remove these code.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b61f4ec..0751a0a 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -423,9 +423,8 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	unsigned int next_perf_state = 0; /* Index into perf table */
 	int result = 0;
 
-	if (unlikely(!data)) {
+	if (unlikely(!data))
 		return -ENODEV;
-	}
 
 	perf = to_perf_data(data);
 	next_perf_state = policy->freq_table[index].driver_data;
@@ -521,11 +520,10 @@ static unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 		}
 		perf->state = perf->state_count-1;
 		return freqn;
-	} else {
-		/* assume CPU is at P0... */
-		perf->state = 0;
-		return perf->states[0].core_frequency * 1000;
 	}
+	/* assume CPU is at P0... */
+	perf->state = 0;
+	return perf->states[0].core_frequency * 1000;
 }
 
 static void free_acpi_perf_data(void)
-- 
1.8.3.1
