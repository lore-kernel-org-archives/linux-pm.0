From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] cpufreq: powernow-k8: pr_err() strings should end with newlines
Date: Mon, 25 Sep 2017 15:10:11 +0530
Message-ID: <113fdc7d136811950c78a7cb2f11f9d98eeb26dc.1506332261.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

pr_err() messages should terminated with a new-line to avoid
other messages being concatenated onto the end.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/cpufreq/powernow-k8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 062d714..b01e31d 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1043,7 +1043,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
-		pr_err("unable to alloc powernow_k8_data");
+		pr_err("unable to alloc powernow_k8_data\n");
 		return -ENOMEM;
 	}
 
-- 
1.9.1
