From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] cpufreq: qoriq: Delete two error messages for a failed memory
 allocation in qoriq_cpufreq_cpu_init()
Date: Thu, 15 Feb 2018 18:08:32 +0100
Message-ID: <650e783f-7b4c-17b5-3bc7-56e3058a95d1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 18:00:37 +0100

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/cpufreq/qoriq-cpufreq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 0562761a3dec..ee3e3656485b 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -192,16 +192,12 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	count = clk_hw_get_num_parents(hwclk);
 
 	data->pclk = kcalloc(count, sizeof(struct clk *), GFP_KERNEL);
-	if (!data->pclk) {
-		pr_err("%s: no memory\n", __func__);
+	if (!data->pclk)
 		goto err_nomem2;
-	}
 
 	table = kcalloc(count + 1, sizeof(*table), GFP_KERNEL);
-	if (!table) {
-		pr_err("%s: no memory\n", __func__);
+	if (!table)
 		goto err_pclk;
-	}
 
 	for (i = 0; i < count; i++) {
 		clk = clk_hw_get_parent_by_index(hwclk, i)->clk;
-- 
2.16.1

