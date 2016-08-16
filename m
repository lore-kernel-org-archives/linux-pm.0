From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH v2 2/8] power: ab8500_btemp: Remove deprecated
 create_singlethread_workqueue
Date: Tue, 16 Aug 2016 10:52:26 +0530
Message-ID: <72373ab781124f2bbab73774442859d1b17b6748.1471324750.git.bhaktipriya96@gmail.com>
References: <cover.1471324749.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33797 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbcHPFW1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2016 01:22:27 -0400
Content-Disposition: inline
In-Reply-To: <cover.1471324749.git.bhaktipriya96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>

The workqueue "btemp_wq" is used for measuring the temperature
periodically. It queues a single workitem (btemp_periodic_work) and
hence doesn't require ordering. Thus, the deprecated
create_singlethread_workqueue() instance has been replaced with
alloc_workqueue().

The WQ_MEM_RECLAIM flag has been set to ensure forward progress under
memory pressure.

Since there is a single work item, explicit concurrency
limit is unnecessary here.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/power/ab8500_btemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index bf2e5dd..6ffdc18 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -1095,7 +1095,7 @@ static int ab8500_btemp_probe(struct platform_device *pdev)

 	/* Create a work queue for the btemp */
 	di->btemp_wq =
-		create_singlethread_workqueue("ab8500_btemp_wq");
+		alloc_workqueue("ab8500_btemp_wq", WQ_MEM_RECLAIM, 0);
 	if (di->btemp_wq == NULL) {
 		dev_err(di->dev, "failed to create work queue\n");
 		return -ENOMEM;
--
2.1.4

