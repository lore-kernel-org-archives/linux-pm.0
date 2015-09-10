From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 09/17] thermal: powerclamp: allow compile test
Date: Wed,  9 Sep 2015 21:11:05 -0700
Message-ID: <1441858273-4017-10-git-send-email-edubezval@gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Adding COMPILE_TEST flag to powerclamp driver to facilitate
maintenance.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c94efd3..449508f 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -264,7 +264,7 @@ config DB8500_CPUFREQ_COOLING
 config INTEL_POWERCLAMP
 	tristate "Intel PowerClamp idle injection driver"
 	depends on THERMAL
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	depends on CPU_SUP_INTEL
 	help
 	  Enable this to enable Intel PowerClamp idle injection driver. This
-- 
2.5.0
