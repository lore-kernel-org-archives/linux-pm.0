From: Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH] power: max14577: Remove SYSFS dependency from Kconfig
Date: Fri, 28 Nov 2014 14:23:02 +0100
Message-ID: <1417180982-15127-1-git-send-email-k.wrona@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:16216 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbaK1NbO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 08:31:14 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <k.wrona@samsung.com>

This is only a small clean-up. The driver can be built without SYSFS
as there exist stubs for used functions.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
---
 drivers/power/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 0108c2a..69fa8a9 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -327,7 +327,6 @@ config CHARGER_MANAGER
 config CHARGER_MAX14577
 	tristate "Maxim MAX14577/77836 battery charger driver"
 	depends on MFD_MAX14577
-	depends on SYSFS
 	help
 	  Say Y to enable support for the battery charger control sysfs and
 	  platform data of MAX14577/77836 MUICs.
-- 
1.7.9.5

