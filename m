From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] cpufreq: powernow-k8: Delete an error message for a
 failed memory allocation in three functions
Date: Thu, 15 Feb 2018 20:29:44 +0100
Message-ID: <895a6088-5266-0be7-90f6-b1f838eb58c1@users.sourceforge.net>
References: <4dd36236-fc39-19e6-c1a7-a094cf13469c@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4dd36236-fc39-19e6-c1a7-a094cf13469c@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 20:00:23 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/cpufreq/powernow-k8.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index b01e31db5f83..460bf22a8a2b 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -591,10 +591,8 @@ static int fill_powernow_table(struct powernow_k8_data *data,
 
 	powernow_table = kzalloc((sizeof(*powernow_table)
 		* (data->numps + 1)), GFP_KERNEL);
-	if (!powernow_table) {
-		pr_err("powernow_table memory alloc failure\n");
+	if (!powernow_table)
 		return -ENOMEM;
-	}
 
 	for (j = 0; j < data->numps; j++) {
 		int freq;
@@ -760,10 +758,8 @@ static int powernow_k8_cpu_init_acpi(struct powernow_k8_data *data)
 	/* fill in data->powernow_table */
 	powernow_table = kzalloc((sizeof(*powernow_table)
 		* (data->acpi_data.state_count + 1)), GFP_KERNEL);
-	if (!powernow_table) {
-		pr_debug("powernow_table memory alloc failure\n");
+	if (!powernow_table)
 		goto err_out;
-	}
 
 	/* fill in data */
 	data->numps = data->acpi_data.state_count;
@@ -1042,10 +1038,8 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 		return -ENODEV;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		pr_err("unable to alloc powernow_k8_data\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	data->cpu = pol->cpu;
 
-- 
2.16.1
