From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 1/2] PM / Qos: Fix a free error in the dev_pm_qos_constraints_destroy()
Date: Thu,  1 Nov 2012 18:47:25 +0800
Message-ID: <1351766846-24654-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63441 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757238Ab2KAKwE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Nov 2012 06:52:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, stern@rowland.harvard.edu
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Free a wrong point to struct dev_pm_qos->latency which suppose to
be the point to struct dev_pm_qos. The patch is to fix the issue.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/base/power/qos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 3a7687a..31d3f48 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -253,7 +253,7 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 	spin_unlock_irq(&dev->power.lock);
 
 	kfree(c->notifiers);
-	kfree(c);
+	kfree(qos);
 
  out:
 	mutex_unlock(&dev_pm_qos_mtx);
-- 
1.7.9.5

