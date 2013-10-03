From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 12/16] cpuidle: use drv instead of cpuidle_driver in show_current_driver()
Date: Thu,  3 Oct 2013 21:26:51 +0530
Message-ID: <db6ad03989323c290e26eb89a4db7f69a4c7abc8.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Instances of "struct cpuidle_driver *" are consistently named as "drv" in
cpuidle core. Its broken only at one place: show_current_driver().

Fix it for consistency.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpuidle/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index a022393..e918b6d 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -52,12 +52,12 @@ static ssize_t show_current_driver(struct device *dev,
 				   char *buf)
 {
 	ssize_t ret;
-	struct cpuidle_driver *cpuidle_driver;
+	struct cpuidle_driver *drv;
 
 	spin_lock(&cpuidle_driver_lock);
-	cpuidle_driver = cpuidle_get_driver();
-	if (cpuidle_driver)
-		ret = sprintf(buf, "%s\n", cpuidle_driver->name);
+	drv = cpuidle_get_driver();
+	if (drv)
+		ret = sprintf(buf, "%s\n", drv->name);
 	else
 		ret = sprintf(buf, "none\n");
 	spin_unlock(&cpuidle_driver_lock);
-- 
1.7.12.rc2.18.g61b472e
