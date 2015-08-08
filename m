From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] power: twl4030: missing dep for CHARGER_TWL4030
Date: Fri,  7 Aug 2015 19:04:18 -0700
Message-ID: <1438999458-30475-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34164 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946535AbbHHCCw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 22:02:52 -0400
Received: by pdbfa8 with SMTP id fa8so11155375pdb.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2015 19:02:51 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

CHARGER_TWL4030 requires TWL4030_MADC to build due to the
twl4030_get_madc_conversion function

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/power/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index f8758d6..4143e74 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -313,7 +313,7 @@ config CHARGER_MAX8903
 
 config CHARGER_TWL4030
 	tristate "OMAP TWL4030 BCI charger driver"
-	depends on TWL4030_CORE
+	depends on TWL4030_CORE && TWL4030_MADC
 	help
 	  Say Y here to enable support for TWL4030 Battery Charge Interface.
 
-- 
1.9.1

