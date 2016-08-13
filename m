From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH 7/8] power: ab8500_fg: Remove deprecated
 create_singlethread_workqueue
Date: Sat, 13 Aug 2016 22:05:00 +0530
Message-ID: <468534f54e0c4f038bdf3d0031faf8ca5354607c.1471104868.git.bhaktipriya96@gmail.com>
References: <cover.1471104867.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33803 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbcHMQfD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Aug 2016 12:35:03 -0400
Content-Disposition: inline
In-Reply-To: <cover.1471104867.git.bhaktipriya96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>

alloc_ordered_workqueue() with WQ_MEM_RECLAIM set replaces
deprecated create_singlethread_workqueue(). This is the identity
conversion.

The workqueue "fg_wq" is used for running the FG algorithm periodically.
It has been identity converted.

It has multiple work items viz fg_periodic_work, fg_low_bat_work,
fg_reinit_work, fg_work, fg_acc_cur_work and fg_check_hw_failure_work,
which require execution ordering. Hence, a dedicated ordered workqueue
has been used here.

The WQ_MEM_RECLAIM flag has been set to guarantee forward progress under
memory pressure.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/power/ab8500_fg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index 5a36cf8..199f2db 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -3096,7 +3096,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	ab8500_fg_discharge_state_to(di, AB8500_FG_DISCHARGE_INIT);

 	/* Create a work queue for running the FG algorithm */
-	di->fg_wq = create_singlethread_workqueue("ab8500_fg_wq");
+	di->fg_wq = alloc_ordered_workqueue("ab8500_fg_wq", WQ_MEM_RECLAIM);
 	if (di->fg_wq == NULL) {
 		dev_err(di->dev, "failed to create work queue\n");
 		return -ENOMEM;
--
2.1.4

