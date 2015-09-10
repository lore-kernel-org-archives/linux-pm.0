From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 13/17] thermal: int340x: allow compile test
Date: Wed,  9 Sep 2015 21:11:09 -0700
Message-ID: <1441858273-4017-14-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "lan,Tianyu" <tianyu.lan@intel.com>, Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Adding COMPILE_TEST flag to int340x driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "lan,Tianyu" <tianyu.lan@intel.com>
Cc: Ilkka Koskinen <ilkka.koskinen@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d0ff238..0fa5d20 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -317,7 +317,7 @@ config INTEL_QUARK_DTS_THERMAL
 
 config INT340X_THERMAL
 	tristate "ACPI INT340X thermal drivers"
-	depends on X86 && ACPI
+	depends on (X86 && ACPI) || COMPILE_TEST
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
-- 
2.5.0
