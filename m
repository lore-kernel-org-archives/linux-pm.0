From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH 1/8] power: abx500_chargalg: Remove deprecated
 create_singlethread_workqueue
Date: Sat, 13 Aug 2016 21:46:10 +0530
Message-ID: <6da8de0c3cbba922c0d1710a7ddfd6080a446aa5.1471104868.git.bhaktipriya96@gmail.com>
References: <cover.1471104124.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1471104124.git.bhaktipriya96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

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
