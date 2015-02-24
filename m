From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/5] power_supply: max14577: Don't store charging and battery
 states for later
Date: Tue, 24 Feb 2015 10:54:44 +0100
Message-ID: <1424771687-7976-2-git-send-email-k.kozlowski@samsung.com>
References: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35166 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbBXJy4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 04:54:56 -0500
In-reply-to: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Remove caching of charging and battery states in driver's state
container because the cached value was not used later.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/max14577_charger.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/max14577_charger.c b/drivers/power/max14577_charger.c
index ef4103ee6021..c72238aa011b 100644
--- a/drivers/power/max14577_charger.c
+++ b/drivers/power/max14577_charger.c
@@ -26,9 +26,6 @@ struct max14577_charger {
 	struct max14577	*max14577;
 	struct power_supply	charger;
 
-	unsigned int		charging_state;
-	unsigned int		battery_state;
-
 	struct max14577_charger_platform_data	*pdata;
 };
 
@@ -89,7 +86,6 @@ static int max14577_get_charger_state(struct max14577_charger *chg)
 	}
 
 state_set:
-	chg->charging_state = state;
 	return state;
 }
 
@@ -167,7 +163,6 @@ static int max14577_get_battery_health(struct max14577_charger *chg)
 	}
 
 state_set:
-	chg->battery_state = state;
 	return state;
 }
 
-- 
1.9.1

