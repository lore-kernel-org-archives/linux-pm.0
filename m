From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] cpufreq: unicore32: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Fri, 11 Apr 2014 15:59:38 +0800
Message-ID: <1397203178-16780-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Duan Jiong <duanj.fnst@cn.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

This patch fixes coccinelle error regarding usage of IS_ERR and
PTR_ERR instead of PTR_ERR_OR_ZERO.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 drivers/cpufreq/unicore2-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
index 8d045af..6f9dfa8 100644
--- a/drivers/cpufreq/unicore2-cpufreq.c
+++ b/drivers/cpufreq/unicore2-cpufreq.c
@@ -60,9 +60,7 @@ static int __init ucv2_cpu_init(struct cpufreq_policy *policy)
 	policy->max = policy->cpuinfo.max_freq = 1000000;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	policy->clk = clk_get(NULL, "MAIN_CLK");
-	if (IS_ERR(policy->clk))
-		return PTR_ERR(policy->clk);
-	return 0;
+	return PTR_ERR_OR_ZERO(policy->clk);
 }
 
 static struct cpufreq_driver ucv2_driver = {
-- 
1.8.3.1

