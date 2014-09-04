From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/15] power-supply: Use PTR_ERR_OR_ZERO() routine
Date: Thu,  4 Sep 2014 17:31:33 +0530
Message-ID: <50c6a288bc4a7b767fcdc13bb946454b35ad7e24.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:64492 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMDG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:03:06 -0400
Received: by mail-pd0-f176.google.com with SMTP id w10so4024074pde.7
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:03:04 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

At multiple places we are doing exactly what PTR_ERR_OR_ZERO() does. And so that
routine can be reused instead of increasing lines of code here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 26518c8..376464e 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -435,9 +435,7 @@ static int psy_register_thermal(struct power_supply *psy)
 		if (psy->properties[i] == POWER_SUPPLY_PROP_TEMP) {
 			psy->tzd = thermal_zone_device_register(psy->name, 0, 0,
 					psy, &psy_tzd_ops, NULL, 0, 0);
-			if (IS_ERR(psy->tzd))
-				return PTR_ERR(psy->tzd);
-			break;
+			return PTR_ERR_OR_ZERO(psy->tzd);
 		}
 	}
 	return 0;
@@ -515,9 +513,7 @@ static int psy_register_cooler(struct power_supply *psy)
 			psy->tcd = thermal_cooling_device_register(
 							(char *)psy->name,
 							psy, &psy_tcd_ops);
-			if (IS_ERR(psy->tcd))
-				return PTR_ERR(psy->tcd);
-			break;
+			return PTR_ERR_OR_ZERO(psy->tcd);
 		}
 	}
 	return 0;
-- 
2.0.3.693.g996b0fd

