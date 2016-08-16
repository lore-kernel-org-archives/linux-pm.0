From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH v2 4/8] power: intel_mid_battery: Remove deprecated
 create_singlethread_workqueue
Date: Tue, 16 Aug 2016 10:52:56 +0530
Message-ID: <0fb5c3eed5df732a7a4689c28b467b656cdb5814.1471324750.git.bhaktipriya96@gmail.com>
References: <cover.1471324749.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1471324749.git.bhaktipriya96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

The workqueue "monitor_wqueue" is used to monitor the PMIC battery status.
It queues a single work item (pbi->monitor_battery) and hence doesn't
require ordering. Hence, alloc_workqueue has been used to replace the
deprecated create_singlethread_workqueue instance.

Since PMIC battery status needs to be monitored for any change, the
WQ_MEM_RECLAIM flag has been set to ensure forward progress under memory
pressure.

Since there is a single work item, explicit concurrency
limit is unnecessary here.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/power/intel_mid_battery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/intel_mid_battery.c b/drivers/power/intel_mid_battery.c
index 9fa4acc..dc7feef 100644
--- a/drivers/power/intel_mid_battery.c
+++ b/drivers/power/intel_mid_battery.c
@@ -689,8 +689,7 @@ static int probe(int irq, struct device *dev)
 	/* initialize all required framework before enabling interrupts */
 	INIT_WORK(&pbi->handler, pmic_battery_handle_intrpt);
 	INIT_DELAYED_WORK(&pbi->monitor_battery, pmic_battery_monitor);
-	pbi->monitor_wqueue =
-			create_singlethread_workqueue(dev_name(dev));
+	pbi->monitor_wqueue = alloc_workqueue(dev_name(dev), WQ_MEM_RECLAIM, 0);
 	if (!pbi->monitor_wqueue) {
 		dev_err(dev, "%s(): wqueue init failed\n", __func__);
 		retval = -ESRCH;
--
2.1.4
