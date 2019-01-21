From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 2/2] thermal: cpu_cooling: Clarify error message
Date: Mon, 21 Jan 2019 15:12:23 +0530
Message-ID: <3812a31a821981eb36858852d2f66c018c8fa0d4.1548063429.git.amit.kucheria@linaro.org>
References: <cover.1548063429.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1548063429.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548063429.git.amit.kucheria@linaro.org>
References: <cover.1548063429.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, edubezval@gmail.com, swboyd@chromium.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Make it clear that it is a failure if the cpufreq driver was unable to
register as a cooling device. Makes it easier to find in logs and
grepping for words like fail, err, warn.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
