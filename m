From: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] power_supply: rt9455_charger: Fix error reported by static analysis tool
Date: Fri, 12 Jun 2015 15:25:51 +0300
Message-ID: <1434111951-9378-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The result of container_of macro cannot be NULL, so there is no need to
check whether info is NULL.

Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/power/rt9455_charger.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/rt9455_charger.c b/drivers/power/rt9455_charger.c
index de86913..08baac6 100644
--- a/drivers/power/rt9455_charger.c
+++ b/drivers/power/rt9455_charger.c
@@ -1412,9 +1412,6 @@ static int rt9455_usb_event(struct notifier_block *nb,
 	unsigned int opa_mode, iaicr;
 	int ret;
 
-	if (!info)
-		return NOTIFY_DONE;
-
 	/*
 	 * Determine whether the charger is in charge mode
 	 * or in boost mode.
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
