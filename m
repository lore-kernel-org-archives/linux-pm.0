From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/5] thermal: devfreq_cooling: Replace dev_warn with dev_err
Date: Tue,  7 Feb 2017 09:40:02 +0530
Message-ID: <992f71aa060655e45dd32349275773e760141948.1486440448.git.viresh.kumar@linaro.org>
References: <79611a51240c83504c35a8739fe8e1837e903671.1486440448.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79611a51240c83504c35a8739fe8e1837e903671.1486440448.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1486440448.git.viresh.kumar@linaro.org>
References: <cover.1486440448.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

There isn't much the user can do on seeing this warning, as the hardware
is actually okay. dev_err suits much better here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index cf71550b9d00..218ccc30c7ad 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -229,9 +229,9 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
-		dev_warn_ratelimited(dev,
-				     "Failed to get voltage for frequency %lu: %ld\n",
-				     freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+		dev_err_ratelimited(dev,
+				    "Failed to get voltage for frequency %lu: %ld\n",
+				    freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
 		return 0;
 	}
 
-- 
2.7.1.410.g6faf27b
