From: Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH V1 2/5] cpufreq: Loongson1: Replace kzalloc() with kcalloc()
Date: Tue, 12 Apr 2016 18:40:16 +0800
Message-ID: <1460457619-14786-2-git-send-email-keguang.zhang@gmail.com>
References: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kelvin Cheung <keguang.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch replaces kzalloc() with kcalloc() when allocating
frequency table, and remove unnecessary 'out of memory' message.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/cpufreq/loongson1-cpufreq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index 57fae9b..4c3087f 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -81,13 +81,9 @@ static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
 	pll_freq = clk_get_rate(ls1x_cpufreq.pll_clk) / 1000;
 
 	steps = 1 << DIV_CPU_WIDTH;
-	freq_tbl = kzalloc(sizeof(*freq_tbl) * steps, GFP_KERNEL);
-	if (!freq_tbl) {
-		dev_err(ls1x_cpufreq.dev,
-			"failed to alloc cpufreq_frequency_table\n");
-		ret = -ENOMEM;
-		goto out;
-	}
+	freq_tbl = kcalloc(steps, sizeof(*freq_tbl), GFP_KERNEL);
+	if (!freq_tbl)
+		return -ENOMEM;
 
 	for (i = 0; i < (steps - 1); i++) {
 		freq = pll_freq / (i + 1);
@@ -106,7 +102,7 @@ static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
 	ret = cpufreq_generic_init(policy, freq_tbl, 0);
 	if (ret)
 		kfree(freq_tbl);
-out:
+
 	return ret;
 }
 
-- 
1.9.1
