From: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] thermal: ensure SoC thermal drivers depend on associated SoC
Date: Sun, 27 Dec 2015 16:53:55 +0000
Message-ID: <1451235235-31387-1-git-send-email-pbrobinson@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36073 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbL0QyV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2015 11:54:21 -0500
Received: by mail-pf0-f182.google.com with SMTP id 65so57154026pff.3
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2015 08:54:21 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>

The i.MX and QCom thermal drivers don't depend on their associated
SoC, fix it so they depend on the SoC and COMPILE_TEST.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/thermal/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 8cc4ac6..2d33f8d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -185,6 +185,7 @@ config HISI_THERMAL
 
 config IMX_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX SoCs"
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on CPU_THERMAL
 	depends on MFD_SYSCON
 	depends on OF
@@ -382,6 +383,7 @@ endmenu
 
 config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on OF && SPMI && IIO
 	select REGMAP_SPMI
 	help
-- 
2.5.0

