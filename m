From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/2] power: charger-manager: Check charging state right after
 completed initialization
Date: Tue, 26 Aug 2014 13:41:39 +0900
Message-ID: <1409028099-6081-3-git-send-email-cw00.choi@samsung.com>
References: <1409028099-6081-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1409028099-6081-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: myungjoo.ham@samsung.com, jonghwa3.lee@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch check the charging state after completed initialization of charger-
manager and update current charging state. If charger-manager never check and
update current charging state, charger-manager would have the mismatch issue
between real state of cable connection and the charging state of charger-manager
until first polling time of charger-manager.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/power/charger-manager.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index a10fb57..4e560f7 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1839,6 +1839,13 @@ static int charger_manager_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, true);
 	device_set_wakeup_capable(&pdev->dev, false);
 
+	/*
+	 * Charger-manager have to check the charging state right after
+	 * tialization of charger-manager and then update current charging
+	 * state.
+	 */
+	cm_monitor();
+
 	schedule_work(&setup_polling);
 
 	return 0;
-- 
1.8.0
