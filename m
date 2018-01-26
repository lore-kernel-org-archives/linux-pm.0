From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] base: power: domain: Replace mdelay with msleep
Date: Fri, 26 Jan 2018 16:38:19 +0800
Message-ID: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41417 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbeAZIdq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jan 2018 03:33:46 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>

After checking all possible call chains to genpd_dev_pm_detach() and
genpd_dev_pm_attach() here,
my tool finds that these functions are never called in atomic context,
namely never in an interrupt handler or holding a spinlock.
Thus mdelay can be replaced with msleep to avoid busy wait.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/base/power/domain.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0c80bea..f84ac72 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2144,7 +2144,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 		if (ret != -EAGAIN)
 			break;
 
-		mdelay(i);
+		msleep(i);
 		cond_resched();
 	}
 
@@ -2231,7 +2231,7 @@ int genpd_dev_pm_attach(struct device *dev)
 		if (ret != -EAGAIN)
 			break;
 
-		mdelay(i);
+		msleep(i);
 		cond_resched();
 	}
 	mutex_unlock(&gpd_list_lock);
-- 
1.7.9.5
