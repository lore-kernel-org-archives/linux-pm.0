From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 9/9] thermal: cpu_cooling: Clarify error message
Date: Mon, 14 Jan 2019 15:51:11 +0530
Message-ID: <2de2d178380525191d99d6c3619ad8c45efdbab4.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Make it clear that it is a failure if the cpufreq driver was unable to
register as a cooling device. Makes it easier to find in logs and
grepping for words like fail, err, warn.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd23245f778..6fff16113628 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -774,7 +774,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 
 		cdev = __cpufreq_cooling_register(np, policy, capacitance);
 		if (IS_ERR(cdev)) {
-			pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
+			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
 			       policy->cpu, PTR_ERR(cdev));
 			cdev = NULL;
 		}
-- 
2.17.1
