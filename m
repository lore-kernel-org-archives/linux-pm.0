From: Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH v4] power: bq27xxx_battery: Fix bq27541 AveragePower register address
Date: Sat,  9 Jan 2016 22:10:39 +0800
Message-ID: <1452348639-3072-1-git-send-email-liu.xiang6@zte.com.cn>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m15-113.126.com ([220.181.15.113]:47014 "EHLO m15-113.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbcAIOLi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 9 Jan 2016 09:11:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: pali.rohar@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, Liu Xiang <liu.xiang6@zte.com.cn>

Currently in bq27541 driver, the average power register address is
incorrectly set to 0x76, which would result in an error:
bq27xxx-battery 2-0055: error reading average power register  10: -11
According to the bq27541 datasheet, fix this problem by setting
the average power register address to 0x24.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
v4:
 - Modify the patch format.  
---
 drivers/power/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 880233c..633f96d 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -242,7 +242,7 @@ static u8 bq27541_regs[] = {
 	INVALID_REG_ADDR,	/* AE - NA	*/
 	0x2c,	/* SOC(RSOC)	*/
 	0x3c,	/* DCAP		*/
-	0x76,	/* AP		*/
+	0x24,	/* AP		*/
 };
 
 static u8 bq27545_regs[] = {
-- 
1.9.1


