From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 10/17] thermal: intel_soc_dts_iosf: allow compile test
Date: Wed,  9 Sep 2015 21:11:06 -0700
Message-ID: <1441858273-4017-11-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Adding COMPILE_TEST flag to intel_soc_dts_iosf driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 449508f..eb2978d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -284,7 +284,7 @@ config X86_PKG_TEMP_THERMAL
 
 config INTEL_SOC_DTS_IOSF_CORE
 	tristate
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	select IOSF_MBI
 	help
 	  This is becoming a common feature for Intel SoCs to expose the additional
-- 
2.5.0
