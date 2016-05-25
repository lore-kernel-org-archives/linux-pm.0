From: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2] thermal: imx: depend on imx SoC arch
Date: Wed, 25 May 2016 14:45:50 +0100
Message-ID: <1464183950-7035-1-git-send-email-pbrobinson@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33585 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbcEYNqC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2016 09:46:02 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>

Not much use unless the SoC is selected so depend on the ARCH_MXC
and COMPILE_TEST like all the other thermal drivers.

v2: drop extraneous OF

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3c3dc4a..d297338 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -186,7 +186,7 @@ config HISI_THERMAL
 
 config IMX_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX SoCs"
-	depends on CPU_THERMAL
+	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
 	depends on MFD_SYSCON
 	depends on OF
 	help
-- 
2.7.4

