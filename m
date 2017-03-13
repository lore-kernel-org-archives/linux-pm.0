From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 4/5] thermal: cpu_cooling: Replace dev_warn with dev_err
Date: Mon, 13 Mar 2017 15:37:37 +0530
Message-ID: <7b61db5a96f6c829ecf76712613aca249c6c263d.1489399567.git.viresh.kumar@linaro.org>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33311 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdCMKI0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 06:08:26 -0400
Received: by mail-pf0-f171.google.com with SMTP id w189so67580698pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 03:08:25 -0700 (PDT)
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rui.zhang@intel.com, edubezval@gmail.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com

There isn't much the user can do on seeing these warnings, as the
hardware is actually okay. dev_err suits much better here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/cpu_cooling.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 91048eeca28b..2f9a1c7e7b1f 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -399,9 +399,9 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_device,
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
-		dev_warn_ratelimited(cpufreq_device->cpu_dev,
-				     "Failed to get voltage for frequency %lu: %ld\n",
-				     freq_hz, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+		dev_err_ratelimited(cpufreq_device->cpu_dev,
+				    "Failed to get voltage for frequency %lu: %ld\n",
+				    freq_hz, IS_ERR(opp) ? PTR_ERR(opp) : 0);
 		return -EINVAL;
 	}
 
@@ -693,9 +693,9 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 
 	*state = cpufreq_cooling_get_level(cpu, target_freq);
 	if (*state == THERMAL_CSTATE_INVALID) {
-		dev_warn_ratelimited(&cdev->device,
-				     "Failed to convert %dKHz for cpu %d into a cdev state\n",
-				     target_freq, cpu);
+		dev_err_ratelimited(&cdev->device,
+				    "Failed to convert %dKHz for cpu %d into a cdev state\n",
+				    target_freq, cpu);
 		return -EINVAL;
 	}
 
-- 
2.7.1.410.g6faf27b
