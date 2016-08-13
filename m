From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH 6/8] power: ipaq_micro_battery: Remove deprecated
 create_singlethread_workqueue
Date: Sat, 13 Aug 2016 22:03:53 +0530
Message-ID: <7013fe0c94c6d67d63828aac522a6c2cb147dbec.1471104868.git.bhaktipriya96@gmail.com>
References: <cover.1471104867.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32848 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbcHMQd6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Aug 2016 12:33:58 -0400
Content-Disposition: inline
In-Reply-To: <cover.1471104867.git.bhaktipriya96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>

The workqueue "wq" is used for handling battery related tasks.

It has a single work item viz &mb->update and hence it doesn't require
execution ordering. Hence, alloc_workqueue has been used to replace the
deprecated create_singlethread_workqueue instance.

The WQ_MEM_RECLAIM flag has been set to ensure forward progress under
memory pressure.

Since there is a single work item, explicit concurrency
limit is unnecessary here.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/power/ipaq_micro_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/ipaq_micro_battery.c b/drivers/power/ipaq_micro_battery.c
index 35b01c7..4af7b77 100644
--- a/drivers/power/ipaq_micro_battery.c
+++ b/drivers/power/ipaq_micro_battery.c
@@ -235,7 +235,7 @@ static int micro_batt_probe(struct platform_device *pdev)
 		return -ENOMEM;

 	mb->micro = dev_get_drvdata(pdev->dev.parent);
-	mb->wq = create_singlethread_workqueue("ipaq-battery-wq");
+	mb->wq = alloc_workqueue("ipaq-battery-wq", WQ_MEM_RECLAIM, 0);
 	if (!mb->wq)
 		return -ENOMEM;

--
2.1.4

