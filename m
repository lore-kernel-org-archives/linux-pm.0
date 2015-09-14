From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 08/10] thermal: qcom_spmi: allow compile test
Date: Sun, 13 Sep 2015 19:31:37 -0700
Message-ID: <1442197899-5952-9-git-send-email-edubezval@gmail.com>
References: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

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
index 202905e8..63b46c0 100644
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
