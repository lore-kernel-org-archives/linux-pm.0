From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 05/17] thermal: dove: allow compile test
Date: Wed,  9 Sep 2015 21:11:01 -0700
Message-ID: <1441858273-4017-6-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35116 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbbIJELw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 00:11:52 -0400
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Adding COMPILE_TEST flag to dove driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index f1da24e..b38ce41 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -216,7 +216,7 @@ config KIRKWOOD_THERMAL
 
 config DOVE_THERMAL
 	tristate "Temperature sensor on Marvell Dove SoCs"
-	depends on ARCH_DOVE || MACH_DOVE
+	depends on ARCH_DOVE || MACH_DOVE || COMPILE_TEST
 	depends on OF
 	help
 	  Support for the Dove thermal sensor driver in the Linux thermal
-- 
2.5.0

