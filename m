From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/5] thermal: devfreq: Simplify expression
Date: Mon, 13 Mar 2017 15:37:34 +0530
Message-ID: <caa0dba4b6345573a8b92e38bcef4919eb126ec2.1489399567.git.viresh.kumar@linaro.org>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

There is no need to check for IS_ERR() as we are looking for a very
particular error value here. Drop the first check.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 7743a78d4723..4793fc7b06dd 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -186,7 +186,7 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 		return 0;
 
 	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
-	if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))
+	if (PTR_ERR(opp) == -ERANGE)
 		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
 
 	voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
-- 
2.7.1.410.g6faf27b
