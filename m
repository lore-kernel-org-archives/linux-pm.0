From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 16/17] thermal: qcom_spmi: allow compile test
Date: Wed,  9 Sep 2015 21:11:12 -0700
Message-ID: <1441858273-4017-17-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33893 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbbIJEMP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 00:12:15 -0400
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Adding COMPILE_TEST flag to qcom_spmi driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d94b4e9..a752bef 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -356,7 +356,7 @@ endmenu
 
 config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
-	depends on OF && SPMI && IIO
+	depends on OF && (SPMI || COMPILE_TEST) && IIO
 	select REGMAP_SPMI
 	help
 	  This enables a thermal sysfs driver for Qualcomm plug-and-play (QPNP)
-- 
2.5.0

