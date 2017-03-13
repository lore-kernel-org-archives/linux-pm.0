From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 5/5] thermal: cpu_cooling: Check OPP for errors
Date: Mon, 13 Mar 2017 15:37:38 +0530
Message-ID: <d6ee9c511ad83941ad8d94cd074e89ea7b6ddbc9.1489399567.git.viresh.kumar@linaro.org>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33942 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752202AbdCMKIf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 06:08:35 -0400
Received: by mail-pf0-f176.google.com with SMTP id v190so67570771pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 03:08:29 -0700 (PDT)
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rui.zhang@intel.com, edubezval@gmail.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com

It is possible for dev_pm_opp_find_freq_exact() to return errors. It was
all fine earlier as dev_pm_opp_get_voltage() had a check within it to
check for invalid OPPs, but dev_pm_opp_put() doesn't have any similar
checks and the callers need to make sure OPP is valid before calling
them.

Also update the later dev_warn_ratelimited() to not print the error
message as the OPP is guaranteed to be valid now.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 2f9a1c7e7b1f..c2525b585487 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -395,13 +395,20 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_device,
 
 	opp = dev_pm_opp_find_freq_exact(cpufreq_device->cpu_dev, freq_hz,
 					 true);
+	if (IS_ERR(opp)) {
+		dev_warn_ratelimited(cpufreq_device->cpu_dev,
+				     "Failed to find OPP for frequency %lu: %ld\n",
+				     freq_hz, PTR_ERR(opp));
+		return -EINVAL;
+	}
+
 	voltage = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
 		dev_err_ratelimited(cpufreq_device->cpu_dev,
-				    "Failed to get voltage for frequency %lu: %ld\n",
-				    freq_hz, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+				    "Failed to get voltage for frequency %lu\n",
+				    freq_hz);
 		return -EINVAL;
 	}
 
-- 
2.7.1.410.g6faf27b
