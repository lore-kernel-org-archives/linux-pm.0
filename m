From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH 3/8] power: pm2301_charger: Remove deprecated
 create_singlethread_workqueue
Date: Sat, 13 Aug 2016 21:48:43 +0530
Message-ID: <6d89eaf58212611e01cb9e5eba9b0f5dedfd3dbb.1471104868.git.bhaktipriya96@gmail.com>
References: <cover.1471104867.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36295 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbcHMQSr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Aug 2016 12:18:47 -0400
Content-Disposition: inline
In-Reply-To: <cover.1471104867.git.bhaktipriya96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>

alloc_ordered_workqueue() with WQ_MEM_RECLAIM set replaces
deprecated create_singlethread_workqueue(). This is the identity
conversion.

The workqueue "charger_wq" is used for running all the charger related
tasks. This involves charger detection, checking for HW failure and HW
status. This workqueue has been identity converted.

It queues multiple workitems viz &pm2->check_main_thermal_prot_work,
&pm2->check_hw_failure_work, &pm2->ac_work. Hence, the deprecated
create_singlethread_workqueue() instance has been replaced with a
dedicated ordered workqueue.

The WQ_MEM_RECLAIM flag has been set to ensure forward progress under
memory pressure.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/power/pm2301_charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index fb62ed3..78561b6 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -1054,7 +1054,8 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 	pm2->ac_chg.external = true;

 	/* Create a work queue for the charger */
-	pm2->charger_wq = create_singlethread_workqueue("pm2xxx_charger_wq");
+	pm2->charger_wq = alloc_ordered_workqueue("pm2xxx_charger_wq",
+						  WQ_MEM_RECLAIM);
 	if (pm2->charger_wq == NULL) {
 		ret = -ENOMEM;
 		dev_err(pm2->dev, "failed to create work queue\n");
--
2.1.4

