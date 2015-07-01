From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH] thermal: cpu_cooling: Iterate over all CPUs in clip_cpu mask to get frequency table
Date: Wed,  1 Jul 2015 12:13:14 +0800
Message-ID: <1435723994-3882-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1435723647-3354-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435723647-3354-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Sorry for the mistake I made when cherry-picking the patch. Fix and resend
again.

__cpufreq_cooling_register() might fail if some CPU other than first one in
clip_cpu mask is present earlier e.g. CPU hotplug. Iterate all CPUs in the mask
to handle this case.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6509c61..5e90eb6 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -776,9 +776,14 @@ __cpufreq_cooling_register(struct device_node *np,
 	char dev_name[THERMAL_NAME_LENGTH];
 	struct cpufreq_frequency_table *pos, *table;
 	unsigned int freq, i, num_cpus;
-	int ret;
+	int ret, cpu;
+
+	for_each_cpu(cpu, clip_cpus) {
+		table = cpufreq_frequency_get_table(cpu);
+		if (table)
+			break;
+	}
 
-	table = cpufreq_frequency_get_table(cpumask_first(clip_cpus));
 	if (!table) {
 		pr_debug("%s: CPUFreq table not found\n", __func__);
 		return ERR_PTR(-EPROBE_DEFER);
-- 
1.9.1
