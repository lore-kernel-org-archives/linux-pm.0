From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH] thermal: fix cpu cooling initialization
Date: Tue, 18 Apr 2017 15:51:48 +0100
Message-ID: <20170418145148.GD6898@e105217-lin.cambridge.arm.com>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
 <20170417173431.GA10447@localhost.localdomain>
 <20170418103818.GQ28191@vireshk-i7>
 <3925c07c-1442-9e00-6f50-c4ae900ed834@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752813AbdDROvy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Apr 2017 10:51:54 -0400
Content-Disposition: inline
In-Reply-To: <3925c07c-1442-9e00-6f50-c4ae900ed834@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: javi.merino@kernel.org, rui.zhang@intel.com, linaro-kernel@lists.linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vincent.guittot@linaro.org

This patch fixes issues with incorrect initialization
during cpu cooling registration.
The 'policy' and 'freq_table' must be initialized in cpufreq_cooling_device
before usage.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpu_cooling.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

This patch fixes some issues to the patch set posted by Viresh.
I have tested it on Juno r2.

Regards,
Lukasz

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 99ffd9f..c682e25 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -691,6 +691,9 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
 	struct thermal_cooling_device_ops *cooling_ops;
 	bool first;
 
+	if (WARN_ON(!policy))
+		return ERR_PTR(-EINVAL);
+
 	i = cpufreq_table_count_valid_entries(policy);
 	if (!i) {
 		pr_debug("%s: CPUFreq table not found or has no valid entries\n",
@@ -711,6 +714,7 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
 		goto free_cdev;
 	}
 
+	cpufreq_cdev->policy = policy;
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level = i - 1;
 
@@ -721,6 +725,18 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
 		goto free_idle_time;
 	}
 
+	/* Fill freq-table in descending order of frequencies */
+	for (i = 0, freq = -1; i <= cpufreq_cdev->max_level; i++) {
+		freq = find_next_max(policy->freq_table, freq);
+		cpufreq_cdev->freq_table[i].frequency = freq;
+
+		/* Warn for duplicate entries */
+		if (!freq)
+			pr_warn("%s: table has duplicate entries\n", __func__);
+		else
+			pr_debug("%s: freq:%u KHz\n", __func__, freq);
+	}
+
 	if (capacitance) {
 		cpufreq_cdev->plat_get_static_power = plat_static_func;
 
@@ -742,18 +758,6 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
 	}
 	cpufreq_cdev->id = ret;
 
-	/* Fill freq-table in descending order of frequencies */
-	for (i = 0, freq = -1; i <= cpufreq_cdev->max_level; i++) {
-		freq = find_next_max(policy->freq_table, freq);
-		cpufreq_cdev->freq_table[i].frequency = freq;
-
-		/* Warn for duplicate entries */
-		if (!freq)
-			pr_warn("%s: table has duplicate entries\n", __func__);
-		else
-			pr_debug("%s: freq:%u KHz\n", __func__, freq);
-	}
-
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
 		 cpufreq_cdev->id);
 
-- 
1.9.1
