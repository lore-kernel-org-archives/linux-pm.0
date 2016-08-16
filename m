From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH v2 8/8] power: ds2760_battery: Remove deprecated
 create_singlethread_workqueue
Date: Tue, 16 Aug 2016 10:54:06 +0530
Message-ID: <7c1c19df679dd438c4351909f55169583d9386b3.1471324750.git.bhaktipriya96@gmail.com>
References: <cover.1471324749.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32870 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbcHPFYH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2016 01:24:07 -0400
Content-Disposition: inline
In-Reply-To: <cover.1471324749.git.bhaktipriya96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>

alloc_ordered_workqueue() with WQ_MEM_RECLAIM set replaces
deprecated create_singlethread_workqueue(). This is the identity
conversion.

The workqueue "monitor_wqueue" is used to monitor the battery
status. It has been identity converted.

It queues multiple work items viz &di->monitor_work,
&di->set_charged_work, which require execution ordering.
Hence, alloc_workqueue has been used to replace the
deprecated create_singlethread_workqueue instance.

WQ_MEM_RECLAIM flag has been set to ensure forward progress under
memory pressure.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/power/ds2760_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/ds2760_battery.c b/drivers/power/ds2760_battery.c
index 80f73cc..ac92e80 100644
--- a/drivers/power/ds2760_battery.c
+++ b/drivers/power/ds2760_battery.c
@@ -566,7 +566,8 @@ static int ds2760_battery_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&di->monitor_work, ds2760_battery_work);
 	INIT_DELAYED_WORK(&di->set_charged_work,
 			  ds2760_battery_set_charged_work);
-	di->monitor_wqueue = create_singlethread_workqueue(dev_name(&pdev->dev));
+	di->monitor_wqueue = alloc_ordered_workqueue(dev_name(&pdev->dev),
+						     WQ_MEM_RECLAIM);
 	if (!di->monitor_wqueue) {
 		retval = -ESRCH;
 		goto workqueue_failed;
--
2.1.4

