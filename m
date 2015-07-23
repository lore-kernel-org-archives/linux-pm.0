From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: print error messages with dev_err()
Date: Thu, 23 Jul 2015 13:43:18 +0530
Message-ID: <e6d358cd9a19b6da6326deb05f9be2594904fad2.1437639021.git.viresh.kumar@linaro.org>
References: <20150723060938.GD5322@linux>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34416 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbbGWINb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 04:13:31 -0400
Received: by pdbbh15 with SMTP id bh15so107647767pdb.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2015 01:13:31 -0700 (PDT)
In-Reply-To: <20150723060938.GD5322@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

By mistake dev_err was replaced by dev_dbg in a recent patch, fix that.

Fixes: 9b07109f06a1 ("cpufreq: Fix double addition of sysfs links")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fa718644f1ee..84504ae3fb38 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1173,7 +1173,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
 		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
 		if (ret) {
-			dev_dbg(dev, "%s: Failed to create link (%d)\n",
+			dev_err(dev, "%s: Failed to create link (%d)\n",
 				__func__, ret);
 			return ret;
 		}
-- 
2.4.0

