From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH v2 1/8] power: abx500_chargalg: Remove deprecated
 create_singlethread_workqueue
Date: Tue, 16 Aug 2016 10:52:02 +0530
Message-ID: <be20a988e6626cc2dd9cfcee63722d50386ba8ca.1471324750.git.bhaktipriya96@gmail.com>
References: <cover.1471324749.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36689 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbcHPFWE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2016 01:22:04 -0400
Content-Disposition: inline
In-Reply-To: <cover.1471324749.git.bhaktipriya96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>

alloc_ordered_workqueue() with WQ_MEM_RECLAIM set replaces
deprecated create_singlethread_workqueue(). This is the identity
conversion.

The workqueue "chargalg_wq" is used for running the charging algorithm.
It has multiple workitems viz &di->chargalg_periodic_work,
&di->chargalg_wd_work, &di->chargalg_work per abx500_chargalg, which
require ordering. It has been identity converted.

Also, WQ_MEM_RECLAIM has been set to ensure forward progress under
memory pressure.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/power/abx500_chargalg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/abx500_chargalg.c
index d9104b1..a4411d6 100644
--- a/drivers/power/abx500_chargalg.c
+++ b/drivers/power/abx500_chargalg.c
@@ -2091,8 +2091,8 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 		abx500_chargalg_maintenance_timer_expired;

 	/* Create a work queue for the chargalg */
-	di->chargalg_wq =
-		create_singlethread_workqueue("abx500_chargalg_wq");
+	di->chargalg_wq = alloc_ordered_workqueue("abx500_chargalg_wq",
+						   WQ_MEM_RECLAIM);
 	if (di->chargalg_wq == NULL) {
 		dev_err(di->dev, "failed to create work queue\n");
 		return -ENOMEM;
--
2.1.4

