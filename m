From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 11/16] power: supply: axp288_charger: Properly stop work on probe-error / remove
Date: Tue, 26 Dec 2017 13:59:09 +0100
Message-ID: <20171226125914.10235-11-hdegoede@redhat.com>
References: <20171226125914.10235-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdLZM73 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 07:59:29 -0500
In-Reply-To: <20171226125914.10235-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Properly stop any work we may have queued on probe-errors / remove.

Rather then adding a remove driver callback for this, and goto style
error handling to probe, use a devm_action for this.

The devm_action gets registered before we register any of the extcon
notifiers which may queue the work, devm does cleanup in reverse order,
so this ensures that the notifiers are removed before we cancel the work.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 4ec7b023c881..9bfbde15b07d 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -724,6 +724,14 @@ static int charger_init_hw_regs(struct axp288_chrg_info *info)
 	return 0;
 }
 
+static void axp288_charger_cancel_work(void *data)
+{
+	struct axp288_chrg_info *info = data;
+
+	cancel_work_sync(&info->otg.work);
+	cancel_work_sync(&info->cable.work);
+}
+
 static int axp288_charger_probe(struct platform_device *pdev)
 {
 	int ret, i, pirq;
@@ -772,6 +780,11 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Cancel our work on cleanup, register this before the notifiers */
+	ret = devm_add_action(dev, axp288_charger_cancel_work, info);
+	if (ret)
+		return ret;
+
 	/* Register for extcon notification */
 	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
 	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
-- 
2.14.3
