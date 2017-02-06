From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] thermal: devfreq: Check OPP for errors
Date: Mon,  6 Feb 2017 15:56:29 +0530
Message-ID: <cfa2455e97b47a53b81651540fc407c0ce38143a.1486376756.git.viresh.kumar@linaro.org>
References: <232171cd9d89c2179e10e1f2aed71ad7fc1f7872.1486376756.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <232171cd9d89c2179e10e1f2aed71ad7fc1f7872.1486376756.git.viresh.kumar@linaro.org>
In-Reply-To: <232171cd9d89c2179e10e1f2aed71ad7fc1f7872.1486376756.git.viresh.kumar@linaro.org>
References: <232171cd9d89c2179e10e1f2aed71ad7fc1f7872.1486376756.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-pm@vger.kernel.org

It is possible for dev_pm_opp_find_freq_exact() to return errors. It was
all fine earlier as dev_pm_opp_get_voltage() had a check within it to
check for invalid OPPs, but dev_pm_opp_put() doesn't have any similar
checks and the callers need to make sure OPP is valid before calling
them.

Also update the later dev_warn_ratelimited() to not print the error
message as the OPP is guaranteed to be valid now.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index cf71550b9d00..ee013fc02980 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -225,13 +225,20 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 	if (PTR_ERR(opp) == -ERANGE)
 		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
 
+	if (IS_ERR(opp)) {
+		dev_warn_ratelimited(dev,
+				     "Failed to find OPP for frequency %lu: %ld\n",
+				     freq, PTR_ERR(opp));
+		return 0;
+	}
+
 	voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
 		dev_warn_ratelimited(dev,
-				     "Failed to get voltage for frequency %lu: %ld\n",
-				     freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+				     "Failed to get voltage for frequency %lu\n",
+				     freq);
 		return 0;
 	}
 
-- 
2.7.1.410.g6faf27b
