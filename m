From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 02/16] power: supply: axp288_charger: Add missing newlines to some messages
Date: Fri, 22 Dec 2017 13:37:40 +0100
Message-ID: <20171222123754.9622-2-hdegoede@redhat.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751514AbdLVMh5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 07:37:57 -0500
In-Reply-To: <20171222123754.9622-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Add missing (terminating) "\n"-s to some dev_dbg messages.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 54a95d196306..d398f8ee296d 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -584,13 +584,13 @@ static void axp288_charger_extcon_evt_worker(struct work_struct *work)
 
 	/* Determine cable/charger type */
 	if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
-		dev_dbg(&info->pdev->dev, "USB SDP charger  is connected");
+		dev_dbg(&info->pdev->dev, "USB SDP charger is connected\n");
 		current_limit = ILIM_500MA;
 	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
-		dev_dbg(&info->pdev->dev, "USB CDP charger is connected");
+		dev_dbg(&info->pdev->dev, "USB CDP charger is connected\n");
 		current_limit = ILIM_1500MA;
 	} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
-		dev_dbg(&info->pdev->dev, "USB DCP charger is connected");
+		dev_dbg(&info->pdev->dev, "USB DCP charger is connected\n");
 		current_limit = ILIM_2000MA;
 	} else {
 		/* Charger type detection still in progress, bail. */
-- 
2.14.3
