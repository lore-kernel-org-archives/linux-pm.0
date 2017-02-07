From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/5] thermal: devfreq: Simplify expression
Date: Tue,  7 Feb 2017 09:40:01 +0530
Message-ID: <79611a51240c83504c35a8739fe8e1837e903671.1486440448.git.viresh.kumar@linaro.org>
References: <cover.1486440448.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486440448.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

There is no need to check for IS_ERR() as we are looking for a very
particular error value here. Drop the first check.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ba7a5cd994dc..cf71550b9d00 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -222,7 +222,7 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 		return 0;
 
 	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
-	if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))
+	if (PTR_ERR(opp) == -ERANGE)
 		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
 
 	voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
-- 
2.7.1.410.g6faf27b
