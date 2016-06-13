From: Rhyland Klein <rklein@nvidia.com>
Subject: [PATCH] power_supply: fix return value of get_property
Date: Mon, 13 Jun 2016 17:03:41 -0400
Message-ID: <1465851821-1163-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19801 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161183AbcFMVFw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2016 17:05:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Rhyland Klein <rklein@nvidia.com>

power_supply_get_property() should ideally return -EAGAIN if it is
called while the power_supply is being registered. There was no way
previously to determine if use_cnt == 0 meant that the power_supply
wasn't fully registered yet, or if it had already been unregistered.

Add a new boolean to the power_supply struct to simply show if
registration is completed.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
This patch continues what was discussed with the patch
"power_supply: power_supply_read_temp only if use_cnt > 0".
Looking at the thermal code, it looks like we should indeed return
EAGAIN if possible, and since this change is fairly simple, I think
it makes sense to do it.

 drivers/power/power_supply_core.c | 6 +++++-
 include/linux/power_supply.h      | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index b13cd074c52a..a39a47672979 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -491,8 +491,11 @@ int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
 {
-	if (atomic_read(&psy->use_cnt) <= 0)
+	if (atomic_read(&psy->use_cnt) <= 0) {
+		if (!psy->initialized)
+			return -EAGAIN;
 		return -ENODEV;
+	}
 
 	return psy->desc->get_property(psy, psp, val);
 }
@@ -775,6 +778,7 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto create_triggers_failed;
 
+	psy->initialized = true;
 	/*
 	 * Update use_cnt after any uevents (most notably from device_add()).
 	 * We are here still during driver's probe but
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 751061790626..3965503315ef 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -248,6 +248,7 @@ struct power_supply {
 	struct delayed_work deferred_register_work;
 	spinlock_t changed_lock;
 	bool changed;
+	bool initialized;
 	atomic_t use_cnt;
 #ifdef CONFIG_THERMAL
 	struct thermal_zone_device *tzd;
-- 
1.9.1

