From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 12/17] thermal: intel_quark: allow compile test
Date: Wed,  9 Sep 2015 21:11:08 -0700
Message-ID: <1441858273-4017-13-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Adding COMPILE_TEST flag to intel_quark driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 027b662..d0ff238 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -307,7 +307,7 @@ config INTEL_SOC_DTS_THERMAL
 
 config INTEL_QUARK_DTS_THERMAL
 	tristate "Intel Quark DTS thermal driver"
-	depends on X86_INTEL_QUARK
+	depends on X86_INTEL_QUARK || COMPILE_TEST
 	help
 	  Enable this to register Intel Quark SoC (e.g. X1000) platform digital
 	  temperature sensor (DTS). For X1000 SoC, it has one on-die DTS.
-- 
2.5.0
