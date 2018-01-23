From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 7/8] cpuidle/drivers/cpuidle-arm: Register the cooling device
Date: Tue, 23 Jan 2018 16:34:30 +0100
Message-ID: <1516721671-16360-8-git-send-email-daniel.lezcano@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Register the ARM generic cpuidle driver as a cooling device.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index ddee1b6..c100915 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -172,6 +173,10 @@ static int __init arm_idle_init(void)
 			goto out_fail;
 	}
 
+	ret = cpuidle_cooling_register();
+	if (ret)
+		pr_warn("Failed to register the cpuidle cooling device\n");
+
 	return 0;
 
 out_fail:
-- 
2.7.4
