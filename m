From: gaurav jindal <gauravjindal1104@gmail.com>
Subject: [PATCH]drivers: cpuidle: remove checkpatch error
Date: Sat, 2 Sep 2017 00:56:38 +0530
Message-ID: <20170901192638.GB5075@gaurav>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37387 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbdIAT0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 15:26:45 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

this commit removes the checkpatch error in cpuidle_enable_device
function. With removal of error, this commit makes the calling of
cpuidle_curr_governor->enable more smooth. 

Signed-off-by: gaurav jindal<gauravjindal1104@gmail.com>

---

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 60bb64f..44f09a8 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -399,9 +399,11 @@ int cpuidle_enable_device(struct cpuidle_device *dev)
 	if (ret)
 		return ret;

-	if (cpuidle_curr_governor->enable &&
-	    (ret = cpuidle_curr_governor->enable(drv, dev)))
-		goto fail_sysfs;
+	if (cpuidle_curr_governor->enable) {
+		ret = cpuidle_curr_governor->enable(drv, dev);
+		if (ret)
+			goto fail_sysfs;
+	}

 	smp_wmb();
