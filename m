From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] thermal: hisilicon: fix COMPILE_TEST dependencies
Date: Fri, 26 Aug 2016 17:44:21 +0200
Message-ID: <20160826154434.992160-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Leo Yan <leo.yan@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

As we now 'select STUB_CLK_HI6220', all dependencies for that driver have
to be present in order to enable HISI_THERMAL, as pointed out by
Kconfig:

warning: (HISI_THERMAL) selects STUB_CLK_HI6220 which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_HI6220 && MAILBOX)

This rearranges the dependencies for this symbol, so all the dependencies
aside from ARCH_HISI are always met when building it for compile testing.
This mainly helps for randconfig testing, as an "allmodconfig" kernel will
enable them anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 5f63581ce68e ("thermal: hisilicon: Add dependency on the clock driver to allow frequency scaling")
---
 drivers/thermal/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5cba072c3a62..3c8607c07352 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -177,7 +177,8 @@ config THERMAL_EMULATION
 
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
-	depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
+	depends on ARCH_HISI || COMPILE_TEST
+	depends on CPU_THERMAL && OF && COMMON_CLK_HI6220 && MAILBOX
 	depends on HAS_IOMEM
 	select STUB_CLK_HI6220
 	help
-- 
2.9.0
