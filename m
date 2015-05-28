From: Thomas Elste <thomas.elste@imms.de>
Subject: [PATCH] power: bq24190_charger: Change first_time flag reset condition
Date: Thu, 28 May 2015 11:05:32 +0200
Message-ID: <1432803932-5315-2-git-send-email-thomas.elste@imms.de>
References: <1432803932-5315-1-git-send-email-thomas.elste@imms.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from infosrv.imms.de ([194.95.250.51]:58185 "EHLO infosrv.imms.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932093AbbE1Jbu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 May 2015 05:31:50 -0400
Received: from infosrv.imms.de (infosrv.imms.de [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C3E59004F
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2015 11:05:37 +0200 (CEST)
Received: from iimail.ii.imms.de (iimail.imms.de [194.95.133.35])
	by infosrv.imms.de (Postfix) with ESMTP id 0C6BB9004D
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2015 11:05:37 +0200 (CEST)
In-Reply-To: <1432803932-5315-1-git-send-email-thomas.elste@imms.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: thomas.elste@imms.de

The initial register reset of BQ24190 generates a charger status change
whose propagation via power_supply_changed is prevented using a flag.
This flag gets never reset so all following events are ignored as well
leading for example to userspace not detecting charger connects/disconnects.

Therefor change the reset condition of first_time flag, so only the
propagation of the first charger status change is prevented.

Signed-off-by: Thomas Elste <thomas.elste@imms.de>
---
 drivers/power/bq24190_charger.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_charger.c
index 407c4af..052db78 100644
--- a/drivers/power/bq24190_charger.c
+++ b/drivers/power/bq24190_charger.c
@@ -1258,10 +1258,13 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 	 * register reset so we should ignore that one (the very first
 	 * interrupt received).
 	 */
-	if (alert_userspace && !bdi->first_time) {
-		power_supply_changed(bdi->charger);
-		power_supply_changed(bdi->battery);
-		bdi->first_time = false;
+	if (alert_userspace) {
+		if (!bdi->first_time) {
+			power_supply_changed(bdi->charger);
+			power_supply_changed(bdi->battery);
+		} else {
+			bdi->first_time = false;
+		}
 	}
 
 out:
-- 
2.0.5

