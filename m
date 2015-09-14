From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 01/10] thermal: hisi: allow compile test
Date: Sun, 13 Sep 2015 19:31:30 -0700
Message-ID: <1442197899-5952-2-git-send-email-edubezval@gmail.com>
References: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Adding COMPILE_TEST flag to hisi driver to facilitate maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 118938e..f2b1d31 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -163,7 +163,7 @@ config THERMAL_EMULATION
 
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
-	depends on ARCH_HISI && CPU_THERMAL && OF
+	depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
 	help
 	  Enable this to plug hisilicon's thermal sensor driver into the Linux
 	  thermal framework. cpufreq is used as the cooling device to throttle
-- 
2.5.0
