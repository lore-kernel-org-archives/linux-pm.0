From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] cpufreq: scpi: fix static checker warning cdev isn't an ERR_PTR
Date: Mon, 22 Jan 2018 14:41:07 +0000
Message-ID: <1516632067-9584-1-git-send-email-sudeep.holla@arm.com>
References: <20180122104823.GA25283@mwanda>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbeAVOlQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jan 2018 09:41:16 -0500
In-Reply-To: <20180122104823.GA25283@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

Commit 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
leads to the following static checker warning:

	drivers/cpufreq/scpi-cpufreq.c:203 scpi_cpufreq_ready()
	warn: 'cdev' isn't an ERR_PTR

of_cpufreq_cooling_register() returns NULL on error. This patch removes
the incorrect IS_ERR check on the returned pointer.

Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 247fcbfa4cb5..efe32cbefa06 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -197,11 +197,8 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 static void scpi_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct scpi_data *priv = policy->driver_data;
-	struct thermal_cooling_device *cdev;
 
-	cdev = of_cpufreq_cooling_register(policy);
-	if (!IS_ERR(cdev))
-		priv->cdev = cdev;
+	priv->cdev = of_cpufreq_cooling_register(policy);
 }
 
 static struct cpufreq_driver scpi_cpufreq_driver = {
-- 
2.7.4
