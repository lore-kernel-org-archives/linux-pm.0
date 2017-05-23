From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] thermal: cpu_cooling: Replace kmalloc with kmalloc_array
Date: Tue, 23 May 2017 12:33:06 +0530
Message-ID: <eff10695c92ff2d2e9733987d1b06adf559c07b0.1495522926.git.viresh.kumar@linaro.org>
References: <1495521460.2303.4.camel@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495521460.2303.4.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Checkpatch reports following:

WARNING: Prefer kmalloc_array over kmalloc with multiply
+	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev->freq_table) * i,

Fix that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 1305020790b2..908a8014cf76 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -724,8 +724,9 @@ __cpufreq_cooling_register(struct device_node *np,
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level = i - 1;
 
-	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev->freq_table) * i,
-					  GFP_KERNEL);
+	cpufreq_cdev->freq_table = kmalloc_array(i,
+					sizeof(*cpufreq_cdev->freq_table),
+					GFP_KERNEL);
 	if (!cpufreq_cdev->freq_table) {
 		cdev = ERR_PTR(-ENOMEM);
 		goto free_idle_time;
-- 
2.13.0.70.g6367777092d9
