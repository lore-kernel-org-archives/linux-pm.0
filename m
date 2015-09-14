From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 04/10] thermal: kirkwood: allow compile test
Date: Sun, 13 Sep 2015 19:31:33 -0700
Message-ID: <1442197899-5952-5-git-send-email-edubezval@gmail.com>
References: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Adding COMPILE_TEST flag to kirkwood driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2e0aaee..f1da24e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -208,7 +208,7 @@ config RCAR_THERMAL
 
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
-	depends on MACH_KIRKWOOD
+	depends on MACH_KIRKWOOD || COMPILE_TEST
 	depends on OF
 	help
 	  Support for the Kirkwood thermal sensor driver into the Linux thermal
-- 
2.5.0
