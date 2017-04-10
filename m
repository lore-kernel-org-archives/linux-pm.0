From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] thermal: cpu_cooling: Use kmalloc_array() in
 __cpufreq_cooling_register()
Date: Mon, 10 Apr 2017 17:12:06 +0200
Message-ID: <d45b0bbb-0893-906d-edfc-44b712e55b14@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 10 Apr 2017 17:00:13 +0200

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus use the corresponding function "kmalloc_array".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/thermal/cpu_cooling.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 69d0f430b2d1..273d9d5dbe0f 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -823,8 +823,9 @@ __cpufreq_cooling_register(struct device_node *np,
 	cpufreq_for_each_valid_entry(pos, table)
 		cpufreq_dev->max_level++;
 
-	cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev->freq_table) *
-					  cpufreq_dev->max_level, GFP_KERNEL);
+	cpufreq_dev->freq_table = kmalloc_array(cpufreq_dev->max_level,
+						sizeof(*cpufreq_dev->freq_table),
+						GFP_KERNEL);
 	if (!cpufreq_dev->freq_table) {
 		cool_dev = ERR_PTR(-ENOMEM);
 		goto free_time_in_idle_timestamp;
-- 
2.12.2
