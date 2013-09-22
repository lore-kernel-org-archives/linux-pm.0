From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/21] cpuidle: use cpuidle_disabled() instead of "off"
Date: Sun, 22 Sep 2013 06:51:00 +0530
Message-ID: <19979ce88726285c72dd6fe3d7b370d53669443c.1379779777.git.viresh.kumar@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379779777.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379779777.git.viresh.kumar@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

We have a routine for getting value of "off", better call that instead of using
"off" directly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 8c91bad..aec9029 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -119,7 +119,7 @@ int cpuidle_idle_call(void)
 	struct cpuidle_driver *drv;
 	int next_state, entered_state;
 
-	if (off)
+	if (cpuidle_disabled())
 		return -ENODEV;
 
 	if (!initialized)
-- 
1.7.12.rc2.18.g61b472e
