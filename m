From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] thermal: cpu_cooling:  pr_err() strings should end with newlines
Date: Tue, 24 Oct 2017 13:20:39 +0530
Message-ID: <4a3646da88934a58525fc00141f634805ee6eb99.1508829220.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

pr_err() messages should end with a new-line to avoid other messages
being concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 908a801..dc63aba 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -696,7 +696,7 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
 	bool first;
 
 	if (IS_ERR_OR_NULL(policy)) {
-		pr_err("%s: cpufreq policy isn't valid: %p", __func__, policy);
+		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
1.9.1
