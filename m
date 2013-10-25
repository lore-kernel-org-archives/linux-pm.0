From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH] battery: max17042: Fix temperature unit to milli centigrade.
Date: Fri, 25 Oct 2013 13:53:18 +0900
Message-ID: <1382676798-27835-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29614 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3JYExn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2013 00:53:43 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MV70039JK6J6DB0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 25 Oct 2013 13:53:28 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Standard temp node represents temperature of power supply class
in milli centigrade. So fix max17042 fuel gauge driver to follow
the standard. (deci-centigrade --> milli-centigrade)

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/power/max17042_battery.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index d664ef5..892ecfc 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -220,9 +220,9 @@ static int max17042_get_property(struct power_supply *psy,
 			val->intval = (0x7fff & ~val->intval) + 1;
 			val->intval *= -1;
 		}
-		/* The value is converted into deci-centigrade scale */
+		/* The value is converted into milli-centigrade scale */
 		/* Units of LSB = 1 / 256 degree Celsius */
-		val->intval = val->intval * 10 / 256;
+		val->intval = val->intval * 1000 / 256;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (chip->pdata->enable_current_sense) {
-- 
1.7.9.5

