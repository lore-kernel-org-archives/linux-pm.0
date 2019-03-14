From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] power: charger-manager: fix a potential NULL pointer dereference
Date: Thu, 14 Mar 2019 01:02:47 -0500
Message-ID: <20190314060247.7848-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In case create_freezable_workqueue fails, the fix return -ENOMEM
to avoid a potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/power/supply/charger-manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 38be91f21cc4..d29c4f338157 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1987,6 +1987,9 @@ static struct platform_driver charger_manager_driver = {
 static int __init charger_manager_init(void)
 {
 	cm_wq = create_freezable_workqueue("charger_manager");
+	if (unlikely(!cm_wq))
+		return -ENOMEM;
+
 	INIT_DELAYED_WORK(&cm_monitor_work, cm_monitor_poller);
 
 	return platform_driver_register(&charger_manager_driver);
-- 
2.17.1
