From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 02/13] power: bq24257: Add dead battery reporting
Date: Mon, 31 Aug 2015 21:10:24 -0500
Message-ID: <1441073435-12349-3-git-send-email-dannenberg@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57518 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbbIACLV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2015 22:11:21 -0400
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

A missing/disconnected battery is now reported as dead rather than an
unspecified failure via the charger's sysfs health property.

$ cat health
Dead

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index db81356..0b34528 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -274,6 +274,10 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
 			break;
 
+		case FAULT_NO_BAT:
+			val->intval = POWER_SUPPLY_HEALTH_DEAD;
+			break;
+
 		default:
 			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 			break;
-- 
1.9.1

