From: gaurav jindal <gauravjindal1104@gmail.com>
Subject: [PATCH] cpudile: optimize cpuidle_enable_device error handling
Date: Fri, 1 Sep 2017 20:37:26 +0530
Message-ID: <20170901150726.GC7569@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37097 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdIAPHa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 11:07:30 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

do not fetch per cpu drv id cpuidle_curr_governor is NULL.
if cpuidle_enable_device is NULL return -EIO. it prevents
the addtional per cpu processing

Signed-off-by: Gaurav Jindal<gauravjindal1104@gmail.com>

---

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 1519716..6464e09 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -367,9 +367,12 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	if (dev->enabled)
 		return 0;

+	if (!cpuidle_curr_governor)
+		return -EIO;
+
 	drv = cpuidle_get_cpu_driver(dev);

-	if (!drv || !cpuidle_curr_governor)
+	if (!drv)
 		return -EIO;

 	if (!dev->registered)
